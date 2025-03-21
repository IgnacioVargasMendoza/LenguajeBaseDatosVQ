package com.hospitalMilagro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/registro")
public class AuthController {
    
    @GetMapping("/nuevo")
    public String nuevo(){
        return "registro/nuevo";
    }

}
