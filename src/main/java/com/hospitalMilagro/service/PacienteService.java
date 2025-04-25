package com.hospitalMilagro.service;

import com.hospitalMilagro.domain.Paciente;
import java.util.List;

public interface PacienteService {
    
    public List<Paciente> listaPacientes();
    
    public void registrarPaciente(Paciente paciente);
} 