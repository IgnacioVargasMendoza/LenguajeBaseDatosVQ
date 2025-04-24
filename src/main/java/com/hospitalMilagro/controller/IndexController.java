package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Usuario;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Ignac
 */
@Controller
public class IndexController {
    
    @GetMapping("/")
    public String page() {
        return "/index";
    }
    
    @RequestMapping("/index")
    public String index(HttpSession session, Model model) {
        // Obtener usuario de la sesión
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Si no hay usuario en sesión, redirigir al login
        if (usuario == null) {
            return "redirect:/login";
        }
        
        // Agregar el usuario al modelo (aunque ya está en la sesión, esto es para verificar)
        model.addAttribute("usuarioActual", usuario);
        
        return "/index";
    }
    
}
