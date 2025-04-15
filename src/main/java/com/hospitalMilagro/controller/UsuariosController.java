package com.hospitalMilagro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/categorias/agregar")
public class UsuariosController {
    
   
    public String page(Model model) {
        model.addAttribute("attribute", "value");
        return "view.name";
    }
    
}
