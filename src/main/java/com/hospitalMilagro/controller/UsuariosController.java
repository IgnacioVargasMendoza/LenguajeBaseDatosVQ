package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Usuario;
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
@RequestMapping("/usuario")
public class UsuariosController {
    
    private static final Logger logger = Logger.getLogger(UsuariosController.class.getName());
    
    @Autowired 
    private UsuarioService usuarioService;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @GetMapping("/listado")
    public String page(Model model) {
        List<Usuario> listaUsuarios = usuarioService.listaUsuarios();
        model.addAttribute("listaUsuarios", listaUsuarios);
        
        return "/usuario/listado";
    }
    
    @GetMapping("/nuevo")
    public String nuevo(Model model, Usuario usuario){
        model = model.addAttribute("usuario", new Usuario());
        return "listado/nuevo";
    }
    
    @PostMapping("/guardar")
    public String nuevo(Usuario usuario, RedirectAttributes redirectAttributes){
        try {
            usuarioService.insertarUsuario(usuario);
            redirectAttributes.addFlashAttribute("mensaje", "Usuario agregado con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("mensaje", "Error al agregar usuario: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/usuario/listado";
    }
    
    @GetMapping("/eliminar/{id}")
    public String eliminarUsuario(@PathVariable("id") Long idUsuario, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Eliminando usuario con ID: " + idUsuario);
            // Inactivar usuario usando procedimiento almacenado
            jdbcTemplate.update("BEGIN FIDE_DESACTIVAR_USUARIO_TB_SP(?); END;", idUsuario);
            
            redirectAttributes.addFlashAttribute("mensaje", "Usuario eliminado con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            logger.severe("Error al eliminar usuario: " + e.getMessage());
            redirectAttributes.addFlashAttribute("mensaje", "Error al eliminar usuario: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/usuario/listado";
    }
    
    @GetMapping("/editar/{id}")
    public String mostrarFormularioEdicion(@PathVariable("id") Long idUsuario, Model model) {
        try {
            // Obtener usuario por ID
            Usuario usuario = null;
            List<Usuario> usuarios = usuarioService.listaUsuarios();
            for (Usuario user : usuarios) {
                if (user.getIdUsuario().equals(idUsuario)) {
                    usuario = user;
                    break;
                }
            }
            
            if (usuario != null) {
                model.addAttribute("usuario", usuario);
                model.addAttribute("editMode", true);
                
                return "/usuario/editar";
            } else {
                return "redirect:/usuario/listado";
            }
        } catch (Exception e) {
            logger.severe("Error al cargar formulario de edición: " + e.getMessage());
            return "redirect:/usuario/listado";
        }
    }
    
    @PostMapping("/actualizar")
    public String actualizarUsuario(Usuario usuario, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Actualizando usuario con ID: " + usuario.getIdUsuario());
            
            // Actualizar usuario usando procedimiento almacenado
            jdbcTemplate.update("BEGIN FIDE_ACTUALIZAR_USUARIO_TB_SP(?, ?, ?, ?, ?, ?); END;",
                    usuario.getIdUsuario(),
                    usuario.getNombre(),
                    usuario.getPrimerApellido(),
                    usuario.getSegundoApellido(),
                    usuario.getCorreo(),
                    usuario.getContrasena());
            
            redirectAttributes.addFlashAttribute("mensaje", "Usuario actualizado con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            logger.severe("Error al actualizar usuario: " + e.getMessage());
            redirectAttributes.addFlashAttribute("mensaje", "Error al actualizar usuario: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/usuario/listado";
    }
}
