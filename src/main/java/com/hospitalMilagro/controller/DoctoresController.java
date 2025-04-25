package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Direccion;
import com.hospitalMilagro.domain.Doctor;
import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.DireccionService;
import com.hospitalMilagro.service.DoctorService;
import com.hospitalMilagro.service.UsuarioService;
import java.util.List;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/doctor")
public class DoctoresController {
    
    private static final Logger logger = Logger.getLogger(DoctoresController.class.getName());
    
    @Autowired 
    private DoctorService doctorService;
    
    @Autowired
    private UsuarioService usuarioService;
    
    @Autowired
    private DireccionService direccionService;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @GetMapping("/listado")
    public String page(Model model){
        List<Doctor> listaDoctores = doctorService.listaDoctores();
        List<Usuario> listaUsuarios = usuarioService.listaUsuarios();
        List<Direccion> listaDirecciones = direccionService.listaDirecciones();
        
        model.addAttribute("listaDoctores", listaDoctores);
        model.addAttribute("listaUsuarios", listaUsuarios);
        model.addAttribute("listaDirecciones", listaDirecciones);
        model.addAttribute("doctor", new Doctor());
        
        return "/doctor/listado";
    }
    
    @PostMapping("/guardar")
    public String guardarDoctor(Doctor doctor, RedirectAttributes redirectAttributes) {
        try {
            doctorService.registrarDoctor(doctor);
            redirectAttributes.addFlashAttribute("mensaje", "Doctor agregado con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("mensaje", "Error al agregar doctor: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/doctor/listado";
    }
    
    @GetMapping("/eliminar/{id}")
    public String eliminarDoctor(@PathVariable("id") Long idDoctor, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Eliminando doctor con ID: " + idDoctor);
            // Inactivar doctor usando procedimiento almacenado
            jdbcTemplate.update("BEGIN FIDE_DESACTIVAR_DOCTOR_TB_SP(?); END;", idDoctor);
            
            redirectAttributes.addFlashAttribute("mensaje", "Doctor eliminado con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            logger.severe("Error al eliminar doctor: " + e.getMessage());
            redirectAttributes.addFlashAttribute("mensaje", "Error al eliminar doctor: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/doctor/listado";
    }
    
    @GetMapping("/editar/{id}")
    public String mostrarFormularioEdicion(@PathVariable("id") Long idDoctor, Model model) {
        try {
            // Obtener doctor por ID
            Doctor doctor = null;
            List<Doctor> doctores = doctorService.listaDoctores();
            for (Doctor doc : doctores) {
                if (doc.getIdDoctor().equals(idDoctor)) {
                    doctor = doc;
                    break;
                }
            }
            
            if (doctor != null) {
                List<Usuario> listaUsuarios = usuarioService.listaUsuarios();
                List<Direccion> listaDirecciones = direccionService.listaDirecciones();
                
                model.addAttribute("doctor", doctor);
                model.addAttribute("listaUsuarios", listaUsuarios);
                model.addAttribute("listaDirecciones", listaDirecciones);
                model.addAttribute("editMode", true);
                
                return "/doctor/editar";
            } else {
                return "redirect:/doctor/listado";
            }
        } catch (Exception e) {
            logger.severe("Error al cargar formulario de edición: " + e.getMessage());
            return "redirect:/doctor/listado";
        }
    }
    
    @PostMapping("/actualizar")
    public String actualizarDoctor(Doctor doctor, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Actualizando doctor con ID: " + doctor.getIdDoctor());
            
            // Actualizar doctor usando procedimiento almacenado
            jdbcTemplate.update("BEGIN FIDE_ACTUALIZAR_DOCTOR_TB_SP(?, ?, ?, ?, ?); END;",
                    doctor.getIdDoctor(),
                    doctor.getTelefono(),
                    doctor.getNumLicencia(),
                    doctor.getIdUsuario(),
                    doctor.getIdDireccion());
            
            redirectAttributes.addFlashAttribute("mensaje", "Doctor actualizado con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            logger.severe("Error al actualizar doctor: " + e.getMessage());
            redirectAttributes.addFlashAttribute("mensaje", "Error al actualizar doctor: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/doctor/listado";
    }
}
