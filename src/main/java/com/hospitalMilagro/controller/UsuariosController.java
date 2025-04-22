package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.UsuarioService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/usuario")
public class UsuariosController {
    
    @Autowired UsuarioService usuarioService;
    
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
    public String nuevo(Usuario usuario){
        usuarioService.insertarUsuario(usuario);
        return "redirect:/usuario/listado?titulo=Registro Exitoso&mensaje=Su cuenta ha sido creada correctamente";
    }
    
}
