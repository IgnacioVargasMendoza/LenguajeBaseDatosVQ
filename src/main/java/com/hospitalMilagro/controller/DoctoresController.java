package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Direccion;
import com.hospitalMilagro.domain.Doctor;
import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.DireccionService;
import com.hospitalMilagro.service.DoctorService;
import com.hospitalMilagro.service.UsuarioService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/doctor")
public class DoctoresController {
    
    @Autowired 
    private DoctorService doctorService;
    
    @Autowired
    private UsuarioService usuarioService;
    
    @Autowired
    private DireccionService direccionService;
    
    @GetMapping("/listado")
    public String page(Model model){
        List<Doctor> listaDoctores = doctorService.listaDoctores();
        List<Usuario> listaUsuarios = usuarioService.listaUsuarios();
        List<Direccion> listaDirecciones = direccionService.listaDirecciones();
        
        model.addAttribute("listaDoctores", listaDoctores);
        model.addAttribute("listaUsuarios", listaUsuarios);
        model.addAttribute("listaDirecciones", listaDirecciones);
        model.addAttribute("doctor", new Doctor());
        
        return "/doctor/listado";
    }
    
    @PostMapping("/guardar")
    public String guardarDoctor(Doctor doctor, RedirectAttributes redirectAttributes) {
        try {
            doctorService.registrarDoctor(doctor);
            redirectAttributes.addFlashAttribute("mensaje", "Doctor agregado con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("mensaje", "Error al agregar doctor: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/doctor/listado";
    }
}
