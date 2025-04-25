package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.AgendarCita;
import com.hospitalMilagro.domain.Doctor;
import com.hospitalMilagro.domain.EstadoCita;
import com.hospitalMilagro.domain.Paciente;
import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.AgendarCitaService;
import com.hospitalMilagro.service.DoctorService;
import com.hospitalMilagro.service.EstadoCitaService;
import com.hospitalMilagro.service.PacienteService;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/paciente")
public class PacienteCitasController {
    
    private static final Logger logger = Logger.getLogger(PacienteCitasController.class.getName());
    
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
    
    @GetMapping("/citas")
    public String misCitas(HttpSession session, Model model) {
        try {
            logger.info("Obteniendo citas del paciente");
            
            // Obtener usuario y paciente de la sesión
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            if (usuario == null) {
                return "redirect:/login";
            }
            
            // Buscar el ID del paciente asociado al usuario
            Long idPaciente = null;
            List<Paciente> pacientes = pacienteService.listaPacientes();
            for (Paciente paciente : pacientes) {
                if (paciente.getIdUsuario().equals(usuario.getIdUsuario())) {
                    idPaciente = paciente.getIdPaciente();
                    break;
                }
            }
            
            if (idPaciente == null) {
                model.addAttribute("error", "No se encontró información de paciente para este usuario");
                return "/paciente/citas";
            }
            
            // Obtener todas las citas y filtrar por paciente
            List<AgendarCita> todasLasCitas = agendarCitaService.listaCitas();
            List<AgendarCita> citasPaciente = new ArrayList<>();
            
            for (AgendarCita cita : todasLasCitas) {
                if (cita.getIdPaciente().equals(idPaciente)) {
                    citasPaciente.add(cita);
                }
            }
            
            model.addAttribute("citas", citasPaciente);
            model.addAttribute("pacienteActual", idPaciente);
            
        } catch (Exception e) {
            logger.severe("Error al cargar las citas del paciente: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error al cargar las citas: " + e.getMessage());
        }
        
        return "/paciente/citas";
    }
    
    @GetMapping("/agendar-cita")
    public String agendarCita(HttpSession session, Model model) {
        try {
            logger.info("Mostrando formulario para agendar cita");
            
            // Obtener usuario y paciente de la sesión
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            if (usuario == null) {
                return "redirect:/login";
            }
            
            // Buscar el ID del paciente asociado al usuario
            Long idPaciente = null;
            List<Paciente> pacientes = pacienteService.listaPacientes();
            for (Paciente paciente : pacientes) {
                if (paciente.getIdUsuario().equals(usuario.getIdUsuario())) {
                    idPaciente = paciente.getIdPaciente();
                    break;
                }
            }
            
            if (idPaciente == null) {
                model.addAttribute("error", "No se encontró información de paciente para este usuario");
                return "/paciente/agendar-cita";
            }
            
            List<Doctor> doctores = doctorService.listaDoctores();
            List<EstadoCita> estadosCita = estadoCitaService.listaEstadosCita();
            
            // Buscar el estado "Pendiente" para preseleccionarlo
            Long idEstadoPredeterminado = 1L; // Valor predeterminado
            try {
                idEstadoPredeterminado = jdbcTemplate.queryForObject(
                    "SELECT MIN(ID_ESTADO_CITA) FROM FIDE_ESTADOS_CITAS_TB WHERE ACTIVO = 1 AND NOMBRE_ESTADO = 'Pendiente'", Long.class);
                if (idEstadoPredeterminado == null) {
                    idEstadoPredeterminado = jdbcTemplate.queryForObject(
                        "SELECT MIN(ID_ESTADO_CITA) FROM FIDE_ESTADOS_CITAS_TB WHERE ACTIVO = 1", Long.class);
                }
            } catch (Exception e) {
                logger.severe("Error al obtener ID del estado predeterminado: " + e.getMessage());
            }
            
            model.addAttribute("doctores", doctores);
            model.addAttribute("estadosCita", estadosCita);
            model.addAttribute("idEstadoPendiente", idEstadoPredeterminado);
            model.addAttribute("idPacienteActual", idPaciente);
            model.addAttribute("nuevaCita", new AgendarCita());
            
        } catch (Exception e) {
            logger.severe("Error al cargar formulario de cita: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error al cargar el formulario: " + e.getMessage());
        }
        
        return "/paciente/agendar-cita";
    }
    
    @PostMapping("/guardar-cita")
    public String guardarCita(AgendarCita cita, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Guardando cita con doctor=" + cita.getIdDoctor());
            
            // Obtener usuario y verificar que sea el paciente correcto
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            if (usuario == null) {
                return "redirect:/login";
            }
            
            // Buscar el ID del paciente asociado al usuario
            Long idPaciente = null;
            List<Paciente> pacientes = pacienteService.listaPacientes();
            for (Paciente paciente : pacientes) {
                if (paciente.getIdUsuario().equals(usuario.getIdUsuario())) {
                    idPaciente = paciente.getIdPaciente();
                    break;
                }
            }
            
            if (idPaciente == null || !idPaciente.equals(cita.getIdPaciente())) {
                redirectAttributes.addFlashAttribute("mensaje", "No tiene permiso para agendar citas para otro paciente");
                redirectAttributes.addFlashAttribute("tipo", "error");
                return "redirect:/paciente/agendar-cita";
            }
            
            // Si no se proporciona un estado, asignar estado "Pendiente"
            if (cita.getIdEstadoCita() == null) {
                Long estadoId = null;
                try {
                    estadoId = jdbcTemplate.queryForObject(
                        "SELECT MIN(ID_ESTADO_CITA) FROM FIDE_ESTADOS_CITAS_TB WHERE ACTIVO = 1 AND NOMBRE_ESTADO = 'Pendiente'", Long.class);
                    if (estadoId == null) {
                        estadoId = jdbcTemplate.queryForObject(
                            "SELECT MIN(ID_ESTADO_CITA) FROM FIDE_ESTADOS_CITAS_TB WHERE ACTIVO = 1", Long.class);
                    }
                } catch (Exception e) {
                    logger.severe("Error al verificar estados de cita: " + e.getMessage());
                }
                
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
            
            agendarCitaService.registrarCita(cita);
            redirectAttributes.addFlashAttribute("mensaje", "Cita agendada con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
            
        } catch (Exception e) {
            logger.severe("Error al guardar cita: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("mensaje", "Error al agendar cita: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
            redirectAttributes.addFlashAttribute("error_detalle", e.toString());
        }
        
        return "redirect:/paciente/citas";
    }
} 