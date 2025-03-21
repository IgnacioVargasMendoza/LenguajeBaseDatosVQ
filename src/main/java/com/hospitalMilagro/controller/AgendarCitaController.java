package com.hospitalMilagro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AgendarCitaController {
    @GetMapping("/agendarCita")
    public String agendarCita() {
        return "/agendarCita";
    }
}
