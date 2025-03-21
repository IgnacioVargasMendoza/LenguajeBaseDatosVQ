package com.hospitalMilagro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TempController {
    
    @GetMapping("/login")
    public String login() {
        return "login";
    }
    
   @GetMapping("/usuario")
    public String usuario() {
        return "usuario";
    }
    
    @GetMapping("/doctor")
    public String doctor() {
        return "/doctor/listado";
    }
}
