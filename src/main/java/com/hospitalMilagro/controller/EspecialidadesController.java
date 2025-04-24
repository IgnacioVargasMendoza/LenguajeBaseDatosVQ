package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Especialidades;
import com.hospitalMilagro.service.EspecialidadesService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/especialidades")
public class EspecialidadesController {
    
    @Autowired EspecialidadesService especialidadesService;
    
    @GetMapping("/listado")
    public String page(Model model){
        List<Especialidades> listaEspecialidades= especialidadesService.listaEspecialidades();
        
        model.addAttribute("listaEspecialidades", listaEspecialidades);
        
        return "/especialidades/listado";
    }
}
