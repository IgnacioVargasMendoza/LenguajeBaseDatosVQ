package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.AgendarCita;
import com.hospitalMilagro.domain.Doctor;
import com.hospitalMilagro.domain.EstadoCita;
import com.hospitalMilagro.domain.Paciente;
import com.hospitalMilagro.service.AgendarCitaService;
import com.hospitalMilagro.service.DoctorService;
import com.hospitalMilagro.service.EstadoCitaService;
import com.hospitalMilagro.service.PacienteService;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/citas")
public class CitasController {
    
    private static final Logger logger = Logger.getLogger(CitasController.class.getName());
    
    @Autowired
    private AgendarCitaService agendarCitaService;
    
    @Autowired
    private DoctorService doctorService;
    
    @Autowired
    private PacienteService pacienteService;
    
    @Autowired
    private EstadoCitaService estadoCitaService;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
    
    @GetMapping("/listado")
    public String listado(Model model) {
        try {
            logger.info("Obteniendo listado de citas");
            
            List<AgendarCita> citas = agendarCitaService.listaCitas();
            List<Doctor> doctores = doctorService.listaDoctores();
            List<Paciente> pacientes = pacienteService.listaPacientes();
            List<EstadoCita> estadosCita = estadoCitaService.listaEstadosCita();
            
            Long idEstadoPredeterminado = 1L; // Valor predeterminado por si no hay resultados
            
            // Verificar si hay estados de cita
            if (estadosCita == null || estadosCita.isEmpty()) {
                // No hay estados de cita, intentar crearlos
                try {
                    jdbcTemplate.update("INSERT INTO FIDE_ESTADOS_CITAS_TB (NOMBRE_ESTADO) VALUES ('Pendiente')");
                    jdbcTemplate.update("INSERT INTO FIDE_ESTADOS_CITAS_TB (NOMBRE_ESTADO) VALUES ('Completada')");
                    jdbcTemplate.update("INSERT INTO FIDE_ESTADOS_CITAS_TB (NOMBRE_ESTADO) VALUES ('Cancelada')");
                    
                    // Recargar la lista
                    estadosCita = estadoCitaService.listaEstadosCita();
                    logger.info("Se han creado estados de cita predeterminados");
                } catch (Exception e) {
                    logger.severe("Error al crear estados de cita predeterminados: " + e.getMessage());
                }
            }
            
            // Buscar el estado "Pendiente" para preseleccionarlo
            // Obtener el ID directamente de la base de datos para asegurarnos que existe
            try {
                idEstadoPredeterminado = jdbcTemplate.queryForObject(
                    "SELECT MIN(ID_ESTADO_CITA) FROM FIDE_ESTADOS_CITAS_TB WHERE ACTIVO = 1", Long.class);
                if (idEstadoPredeterminado == null) {
                    idEstadoPredeterminado = 1L;
                }
                logger.info("ID del estado predeterminado obtenido de la BD: " + idEstadoPredeterminado);
            } catch (Exception e) {
                logger.severe("Error al obtener ID del estado predeterminado: " + e.getMessage());
                // Mantener el valor predeterminado
            }
            
            logger.info("Citas encontradas: " + citas.size());
            logger.info("Doctores disponibles: " + doctores.size());
            logger.info("Pacientes disponibles: " + pacientes.size());
            logger.info("Estados de cita disponibles: " + (estadosCita != null ? estadosCita.size() : 0));
            logger.info("ID del estado predeterminado: " + idEstadoPredeterminado);
            
            model.addAttribute("citas", citas);
            model.addAttribute("doctores", doctores);
            model.addAttribute("pacientes", pacientes);
            model.addAttribute("estadosCita", estadosCita);
            model.addAttribute("idEstadoPendiente", idEstadoPredeterminado);
            model.addAttribute("nuevaCita", new AgendarCita());
        } catch (Exception e) {
            logger.severe("Error al cargar la página de citas: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error al cargar la página: " + e.getMessage());
        }
        
        return "/citas/listado";
    }
    
    @GetMapping("/crear-estados")
    public String crearEstados(RedirectAttributes redirectAttributes) {
        try {
            // Agregar estados de cita predeterminados
            jdbcTemplate.update("BEGIN FIDE_AGREGAR_ESTADO_CITA_SP('Pendiente'); END;");
            jdbcTemplate.update("BEGIN FIDE_AGREGAR_ESTADO_CITA_SP('Completada'); END;");
            jdbcTemplate.update("BEGIN FIDE_AGREGAR_ESTADO_CITA_SP('Cancelada'); END;");
            
            redirectAttributes.addFlashAttribute("mensaje", "Estados de cita creados con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            logger.severe("Error al crear estados de cita: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("mensaje", "Error al crear estados de cita: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
            redirectAttributes.addFlashAttribute("error_detalle", e.toString());
        }
        return "redirect:/citas/listado";
    }
    
    @PostMapping("/guardar")
    public String guardarCita(AgendarCita cita, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Guardando cita con doctor=" + cita.getIdDoctor() + ", paciente=" + cita.getIdPaciente());
            
            // Verificar si el estado de cita existe
            Long estadoId = null;
            try {
                estadoId = jdbcTemplate.queryForObject(
                    "SELECT MIN(ID_ESTADO_CITA) FROM FIDE_ESTADOS_CITAS_TB WHERE ACTIVO = 1", Long.class);
            } catch (Exception e) {
                logger.severe("Error al verificar estados de cita: " + e.getMessage());
            }
            
            // Si no se proporciona un estado o el estado no existe, usar el estado obtenido de la BD
            if (cita.getIdEstadoCita() == null || estadoId == null) {
                if (estadoId != null) {
                    cita.setIdEstadoCita(estadoId);
                } else {
                    // Intentar obtener el primer estado disponible
                    List<EstadoCita> estadosCita = estadoCitaService.listaEstadosCita();
                    if (estadosCita != null && !estadosCita.isEmpty()) {
                        cita.setIdEstadoCita(estadosCita.get(0).getIdEstadoCita());
                    } else {
                        cita.setIdEstadoCita(1L); // Valor predeterminado
                    }
                }
            }
            
            logger.info("Guardando cita con estado=" + cita.getIdEstadoCita());
            
            agendarCitaService.registrarCita(cita);
            redirectAttributes.addFlashAttribute("mensaje", "Cita agendada con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
            logger.info("Cita guardada correctamente");
        } catch (Exception e) {
            logger.severe("Error al guardar cita: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("mensaje", "Error al agendar cita: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
            redirectAttributes.addFlashAttribute("error_detalle", e.toString());
        }
        return "redirect:/citas/listado";
    }
    
    @GetMapping("/eliminar/{id}")
    public String eliminarCita(@PathVariable("id") Long idCita, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Eliminando cita con ID: " + idCita);
            // Inactivar cita usando procedimiento almacenado
            jdbcTemplate.update("BEGIN FIDE_DESACTIVAR_CITA_TB_SP(?); END;", idCita);
            
            redirectAttributes.addFlashAttribute("mensaje", "Cita eliminada con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            logger.severe("Error al eliminar cita: " + e.getMessage());
            redirectAttributes.addFlashAttribute("mensaje", "Error al eliminar cita: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/citas/listado";
    }
    
    @GetMapping("/editar/{id}")
    public String mostrarFormularioEdicion(@PathVariable("id") Long idCita, Model model, RedirectAttributes redirectAttributes) {
        try {
            // Obtener cita por ID
            AgendarCita cita = null;
            List<AgendarCita> citas = agendarCitaService.listaCitas();
            for (AgendarCita c : citas) {
                if (c.getIdCita().equals(idCita)) {
                    cita = c;
                    break;
                }
            }
            
            if (cita != null) {
                List<Doctor> doctores = doctorService.listaDoctores();
                List<Paciente> pacientes = pacienteService.listaPacientes();
                List<EstadoCita> estadosCita = estadoCitaService.listaEstadosCita();
                
                model.addAttribute("cita", cita);
                model.addAttribute("doctores", doctores);
                model.addAttribute("pacientes", pacientes);
                model.addAttribute("estadosCita", estadosCita);
                model.addAttribute("editMode", true);
                
                return "/citas/editar";
            } else {
                redirectAttributes.addFlashAttribute("mensaje", "No se encontró la cita con ID: " + idCita);
                redirectAttributes.addFlashAttribute("tipo", "error");
                return "redirect:/citas/listado";
            }
        } catch (Exception e) {
            logger.severe("Error al cargar formulario de edición: " + e.getMessage());
            redirectAttributes.addFlashAttribute("mensaje", "Error al cargar el formulario de edición: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
            return "redirect:/citas/listado";
        }
    }
    
    @PostMapping("/actualizar")
    public String actualizarCita(AgendarCita cita, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Actualizando cita con ID: " + cita.getIdCita());
            
            // Actualizar cita usando procedimiento almacenado
            jdbcTemplate.update("BEGIN FIDE_ACTUALIZAR_CITA_TB_SP(?, ?, ?, ?, ?, ?); END;",
                    cita.getIdCita(),
                    new SimpleDateFormat("dd/MM/yyyy").format(cita.getFecha()), // Formato esperado por el SP
                    cita.getHoraCita(),
                    cita.getIdEstadoCita(),
                    cita.getIdDoctor(),
                    cita.getIdPaciente());
            
            redirectAttributes.addFlashAttribute("mensaje", "Cita actualizada con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            logger.severe("Error al actualizar cita: " + e.getMessage());
            redirectAttributes.addFlashAttribute("mensaje", "Error al actualizar cita: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/citas/listado";
    }
} 