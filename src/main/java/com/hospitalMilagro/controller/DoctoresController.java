package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Doctor;
import com.hospitalMilagro.service.DoctorService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/doctor")
public class DoctoresController {
    
    @Autowired DoctorService doctorService;
    
    @GetMapping("/listado")
    public String page(Model model){
        List<Doctor> listaDoctores= doctorService.listaDoctores();
        
        model.addAttribute("listaDoctores", listaDoctores);
        
        return "/doctor/listado";
    }
}
