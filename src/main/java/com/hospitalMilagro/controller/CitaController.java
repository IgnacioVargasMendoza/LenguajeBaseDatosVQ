package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Citas;
import com.hospitalMilagro.service.CitasService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/agendarCita")
public class CitaController {
    
    @Autowired
    private CitasService citasService;
    
    @GetMapping("/agendarCita")
    public String agendarCita() {        
        return "/agendarCita/agendarCita";
    }
    
    @PostMapping("/agregar")
    public String citaAgregar(Citas cita){
        citasService.save(cita);
        return "redirect:/citas/listado";
    }
        

}
