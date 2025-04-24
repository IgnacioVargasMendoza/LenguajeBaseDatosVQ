package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/login")
public class LoginController {
    
    @Autowired
    private UsuarioService usuarioService;
    
    @GetMapping
    public String mostrarLogin() {
        return "login/login";
    }
    
    @PostMapping
    public String autenticarUsuario(
            @RequestParam("nombre") String nombre, 
            @RequestParam("password") String contrasena,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        // Autenticar usuario por nombre
        Usuario usuario = usuarioService.autenticarUsuario(nombre, contrasena);
        
        // Verificar si las credenciales son válidas
        if (usuario != null) {
            // Guardar información del usuario en la sesión
            session.setAttribute("usuario", usuario);
            
            // Redireccionar a la página principal
            return "redirect:/index";
        }
        
        // Si las credenciales son inválidas, mostrar mensaje de error
        redirectAttributes.addFlashAttribute("error", "Credenciales inválidas. Por favor, intente nuevamente.");
        return "redirect:/login?error";
    }
    
    @GetMapping("/logout")
    public String cerrarSesion(HttpSession session) {
        // Invalidar la sesión
        session.invalidate();
        
        // Redireccionar a la página de login
        return "redirect:/login";
    }
} 