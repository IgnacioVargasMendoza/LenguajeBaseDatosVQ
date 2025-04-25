package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/registro")
public class RegistroController {
   
    @Autowired
    private UsuarioService usuarioService;
    
    @GetMapping("/nuevo")
    public String nuevo(Model model, Usuario usuario){
        model = model.addAttribute("usuario", new Usuario());
        return "registro/nuevo";
    }
    
    @PostMapping("/crear")
    public String usuarioInsertar(Usuario usuario, RedirectAttributes redirectAttributes){
        usuarioService.insertarUsuario(usuario);
        redirectAttributes.addFlashAttribute("registroExitoso", true);
        return "redirect:/registro/exito";
    }

    @GetMapping("/exito")
    public String registroExitoso(){
        return "registro/exito";
    }

    // Endpoint para solicitudes AJAX de registro
    @PostMapping("/crearAjax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> usuarioInsertarAjax(Usuario usuario){
        Map<String, Object> response = new HashMap<>();
        try {
            usuarioService.insertarUsuario(usuario);
            response.put("success", true);
            response.put("message", "Usuario registrado correctamente");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
}
