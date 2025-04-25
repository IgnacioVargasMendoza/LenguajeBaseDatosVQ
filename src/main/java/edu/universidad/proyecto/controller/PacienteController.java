package edu.universidad.proyecto.controller;

import edu.universidad.proyecto.domain.Cita;
import edu.universidad.proyecto.domain.Doctor;
import edu.universidad.proyecto.domain.Especialidad;
import edu.universidad.proyecto.domain.EstadoCita;
import edu.universidad.proyecto.domain.Paciente;
import edu.universidad.proyecto.domain.Usuario;
import edu.universidad.proyecto.service.CitaService;
import edu.universidad.proyecto.service.DoctorService;
import edu.universidad.proyecto.service.EspecialidadService;
import edu.universidad.proyecto.service.EstadoCitaService;
import edu.universidad.proyecto.service.PacienteService;
import edu.universidad.proyecto.service.UsuarioService;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/paciente")
public class PacienteController {
    
    @Autowired
    private CitaService citaService;
    
    @Autowired
    private DoctorService doctorService;
    
    @Autowired
    private EspecialidadService especialidadService;
    
    @Autowired
    private EstadoCitaService estadoCitaService;
    
    @Autowired
    private PacienteService pacienteService;
    
    @Autowired
    private UsuarioService usuarioService;
    
    @GetMapping("/citas")
    public String verCitas(Model model, HttpSession session) {
        Long usuarioId = (Long) session.getAttribute("usuarioId");
        
        if (usuarioId == null) {
            return "redirect:/login";
        }
        
        Usuario usuario = usuarioService.buscarPorId(usuarioId);
        
        // Solo si el usuario es un paciente puede acceder a esta página
        if (usuario == null || !usuario.getRol().equals("PACIENTE")) {
            return "redirect:/";
        }
        
        Paciente paciente = pacienteService.buscarPorUsuarioId(usuarioId);
        if (paciente == null) {
            model.addAttribute("error", "No se encontró información del paciente");
            return "redirect:/";
        }
        
        List<Cita> citas = citaService.listarCitasPorPaciente(paciente.getIdPaciente());
        model.addAttribute("citas", citas);
        
        return "paciente/citas";
    }
    
    @GetMapping("/agendar")
    public String agendarCita(Model model, HttpSession session) {
        Long usuarioId = (Long) session.getAttribute("usuarioId");
        
        if (usuarioId == null) {
            return "redirect:/login";
        }
        
        Usuario usuario = usuarioService.buscarPorId(usuarioId);
        
        // Solo si el usuario es un paciente puede acceder a esta página
        if (usuario == null || !usuario.getRol().equals("PACIENTE")) {
            return "redirect:/";
        }
        
        Paciente paciente = pacienteService.buscarPorUsuarioId(usuarioId);
        if (paciente == null) {
            model.addAttribute("error", "No se encontró información del paciente");
            return "redirect:/";
        }
        
        List<Especialidad> especialidades = especialidadService.listarEspecialidades();
        model.addAttribute("especialidades", especialidades);
        
        return "paciente/agendar-cita";
    }
    
    @PostMapping("/guardar-cita")
    public String guardarCita(
            @RequestParam Long idPaciente,
            @RequestParam Long idDoctor,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date fecha,
            @RequestParam String horaCita,
            @RequestParam(required = false) String motivo,
            RedirectAttributes redirectAttributes,
            HttpSession session) {
        
        Long usuarioId = (Long) session.getAttribute("usuarioId");
        
        if (usuarioId == null) {
            return "redirect:/login";
        }
        
        try {
            // Verificar que el doctor exista
            Doctor doctor = doctorService.buscarPorId(idDoctor);
            if (doctor == null) {
                redirectAttributes.addFlashAttribute("error", "El doctor seleccionado no existe");
                return "redirect:/paciente/agendar";
            }
            
            // Verificar que el paciente exista y corresponda al usuario logueado
            Paciente paciente = pacienteService.buscarPorId(idPaciente);
            if (paciente == null || !paciente.getUsuario().getIdUsuario().equals(usuarioId)) {
                redirectAttributes.addFlashAttribute("error", "No tiene permisos para agendar citas para este paciente");
                return "redirect:/paciente/agendar";
            }
            
            // Verificar disponibilidad del doctor en la fecha y hora seleccionada
            boolean disponible = citaService.verificarDisponibilidadDoctor(idDoctor, fecha, horaCita);
            if (!disponible) {
                redirectAttributes.addFlashAttribute("error", "El doctor no está disponible en la fecha y hora seleccionada");
                return "redirect:/paciente/agendar";
            }
            
            // Obtenemos el estado "Pendiente" para la cita
            EstadoCita estadoPendiente = estadoCitaService.buscarPorNombre("Pendiente");
            if (estadoPendiente == null) {
                // Si no existe, creamos los estados por defecto
                estadoCitaService.crearEstadosPorDefecto();
                estadoPendiente = estadoCitaService.buscarPorNombre("Pendiente");
            }
            
            // Crear la cita
            Cita cita = new Cita();
            cita.setPaciente(paciente);
            cita.setDoctor(doctor);
            cita.setFechaCita(fecha);
            cita.setHoraCita(horaCita);
            cita.setMotivo(motivo);
            cita.setEstadoCita(estadoPendiente);
            
            citaService.guardarCita(cita);
            
            redirectAttributes.addFlashAttribute("mensaje", "Cita agendada exitosamente");
            redirectAttributes.addFlashAttribute("tipo", "success");
            
            return "redirect:/paciente/citas";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error al agendar la cita: " + e.getMessage());
            return "redirect:/paciente/agendar";
        }
    }
    
    @GetMapping("/cancelar-cita/{id}")
    public String cancelarCita(@PathVariable Long id, RedirectAttributes redirectAttributes, HttpSession session) {
        Long usuarioId = (Long) session.getAttribute("usuarioId");
        
        if (usuarioId == null) {
            return "redirect:/login";
        }
        
        try {
            Cita cita = citaService.buscarPorId(id);
            
            if (cita == null) {
                redirectAttributes.addFlashAttribute("error", "La cita no existe");
                return "redirect:/paciente/citas";
            }
            
            // Verificar que la cita pertenezca al paciente logueado
            Paciente paciente = pacienteService.buscarPorUsuarioId(usuarioId);
            if (paciente == null || !cita.getPaciente().getIdPaciente().equals(paciente.getIdPaciente())) {
                redirectAttributes.addFlashAttribute("error", "No tiene permisos para cancelar esta cita");
                return "redirect:/paciente/citas";
            }
            
            // Verificar que la cita esté pendiente
            if (!cita.getEstadoCita().getNombreEstado().equals("Pendiente")) {
                redirectAttributes.addFlashAttribute("error", "Solo puede cancelar citas en estado pendiente");
                return "redirect:/paciente/citas";
            }
            
            // Obtener el estado "Cancelada"
            EstadoCita estadoCancelada = estadoCitaService.buscarPorNombre("Cancelada");
            if (estadoCancelada == null) {
                redirectAttributes.addFlashAttribute("error", "No se pudo encontrar el estado 'Cancelada'");
                return "redirect:/paciente/citas";
            }
            
            // Actualizar estado de la cita
            cita.setEstadoCita(estadoCancelada);
            citaService.actualizarCita(cita);
            
            redirectAttributes.addFlashAttribute("mensaje", "Cita cancelada exitosamente");
            redirectAttributes.addFlashAttribute("tipo", "success");
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error al cancelar la cita: " + e.getMessage());
        }
        
        return "redirect:/paciente/citas";
    }
} 