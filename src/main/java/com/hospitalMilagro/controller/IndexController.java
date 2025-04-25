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
    public String page(HttpSession session, Model model) {
        // Obtener usuario de la sesión (ya validado por el interceptor)
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        model.addAttribute("usuarioActual", usuario);
        return "/index";
    }

    @RequestMapping("/index")
    public String index(HttpSession session, Model model) {
        // Obtener usuario de la sesión (ya validado por el interceptor)
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        model.addAttribute("usuarioActual", usuario);
        return "/index";
    }
}
