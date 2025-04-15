package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/registro")
public class AuthController {
   
    @Autowired
    private UsuarioService usuarioService;
    
    @GetMapping("/nuevo")
    public String nuevo(Model model, Usuario usuario){
        model = model.addAttribute("usuario", new Usuario());
        return "registro/nuevo";
    }
    
    @PostMapping("/crear")
    public String usuarioInsertar(Usuario usuario){
        usuarioService.insertarUsuario(usuario);
        return "redirect:/registro/salida?titulo=Registro Exitoso&mensaje=Su cuenta ha sido creada correctamente";
    }

}
