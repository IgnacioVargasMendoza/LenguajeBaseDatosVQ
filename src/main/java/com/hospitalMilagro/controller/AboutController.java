package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.UsuarioService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/about")
public class AboutController {
    
    
    @GetMapping("/about")
    public String page(Model model) {
        return "/about/about";
    }
    
}
