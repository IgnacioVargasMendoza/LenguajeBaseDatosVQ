package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Especialidades;
import com.hospitalMilagro.service.EspecialidadesService;
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
@RequestMapping("/especialidades")
public class EspecialidadesController {
    
    private static final Logger logger = Logger.getLogger(EspecialidadesController.class.getName());
    
    @Autowired 
    private EspecialidadesService especialidadesService;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @GetMapping("/listado")
    public String page(Model model) {
        List<Especialidades> listaEspecialidades = especialidadesService.listaEspecialidades();
        model.addAttribute("listaEspecialidades", listaEspecialidades);
        model.addAttribute("especialidad", new Especialidades());
        
        return "/especialidades/listado";
    }
    
    @GetMapping("/nuevo")
    public String nuevo(Model model, Especialidades especialidades) {
        model = model.addAttribute("especialidades", new Especialidades());
        return "listado/nuevo";
    }
    
    @PostMapping("/guardar")
    public String guardar(Especialidades especialidades, RedirectAttributes redirectAttributes) {
        try {
            especialidadesService.insertarEspecialidad(especialidades);
            redirectAttributes.addFlashAttribute("mensaje", "Especialidad agregada con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("mensaje", "Error al agregar especialidad: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/especialidades/listado";
    }
    
    @GetMapping("/eliminar/{id}")
    public String eliminarEspecialidad(@PathVariable("id") Long idEspecialidad, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Eliminando especialidad con ID: " + idEspecialidad);
            // Inactivar especialidad usando procedimiento almacenado
            jdbcTemplate.update("BEGIN FIDE_DESACTIVAR_ESPECIALIDAD_TB_SP(?); END;", idEspecialidad);
            
            redirectAttributes.addFlashAttribute("mensaje", "Especialidad eliminada con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            logger.severe("Error al eliminar especialidad: " + e.getMessage());
            redirectAttributes.addFlashAttribute("mensaje", "Error al eliminar especialidad: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/especialidades/listado";
    }
    
    @GetMapping("/editar/{id}")
    public String mostrarFormularioEdicion(@PathVariable("id") Long idEspecialidad, Model model) {
        try {
            // Obtener especialidad por ID
            Especialidades especialidad = null;
            List<Especialidades> especialidades = especialidadesService.listaEspecialidades();
            for (Especialidades esp : especialidades) {
                if (esp.getIdEspecialidad().equals(idEspecialidad)) {
                    especialidad = esp;
                    break;
                }
            }
            
            if (especialidad != null) {
                model.addAttribute("especialidad", especialidad);
                model.addAttribute("editMode", true);
                
                return "/especialidades/editar";
            } else {
                return "redirect:/especialidades/listado";
            }
        } catch (Exception e) {
            logger.severe("Error al cargar formulario de edición: " + e.getMessage());
            return "redirect:/especialidades/listado";
        }
    }
    
    @PostMapping("/actualizar")
    public String actualizarEspecialidad(Especialidades especialidad, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Actualizando especialidad con ID: " + especialidad.getIdEspecialidad());
            
            // Actualizar especialidad usando procedimiento almacenado
            jdbcTemplate.update("BEGIN FIDE_ACTUALIZAR_ESPECIALIDAD_TB_SP(?, ?, ?); END;",
                    especialidad.getIdEspecialidad(),
                    especialidad.getNombre(),
                    especialidad.getDescripcion());
            
            redirectAttributes.addFlashAttribute("mensaje", "Especialidad actualizada con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            logger.severe("Error al actualizar especialidad: " + e.getMessage());
            redirectAttributes.addFlashAttribute("mensaje", "Error al actualizar especialidad: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/especialidades/listado";
    }
}
