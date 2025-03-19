
package com.hospitalMilagro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Ignac
 */
@Controller
public class UsuariosController {
    
    @RequestMapping("/categorias/agregar")
    public String page(Model model) {
        model.addAttribute("attribute", "value");
        return "view.name";
    }
    
}
