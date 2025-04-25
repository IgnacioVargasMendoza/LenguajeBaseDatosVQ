package com.hospitalMilagro.controller;

import com.hospitalMilagro.domain.Direccion;
import com.hospitalMilagro.domain.Paciente;
import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.DireccionService;
import com.hospitalMilagro.service.PacienteService;
import com.hospitalMilagro.service.UsuarioService;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/paciente")
public class PacienteController {
    
    @Autowired 
    private PacienteService pacienteService;
    
    @Autowired
    private UsuarioService usuarioService;
    
    @Autowired
    private DireccionService direccionService;
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
    
    @GetMapping("/listado")
    public String page(Model model){
        List<Paciente> listaPacientes = pacienteService.listaPacientes();
        List<Usuario> listaUsuarios = usuarioService.listaUsuarios();
        List<Direccion> listaDirecciones = direccionService.listaDirecciones();
        
        model.addAttribute("listaPacientes", listaPacientes);
        model.addAttribute("listaUsuarios", listaUsuarios);
        model.addAttribute("listaDirecciones", listaDirecciones);
        model.addAttribute("paciente", new Paciente());
        
        return "/paciente/listado";
    }
    
    @PostMapping("/guardar")
    public String guardarPaciente(Paciente paciente, RedirectAttributes redirectAttributes) {
        try {
            pacienteService.registrarPaciente(paciente);
            redirectAttributes.addFlashAttribute("mensaje", "Paciente agregado con éxito");
            redirectAttributes.addFlashAttribute("tipo", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("mensaje", "Error al agregar paciente: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipo", "error");
        }
        return "redirect:/paciente/listado";
    }
} 