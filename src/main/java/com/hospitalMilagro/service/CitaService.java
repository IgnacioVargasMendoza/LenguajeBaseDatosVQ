package com.hospitalMilagro.service;

import com.hospitalMilagro.domain.Cita;
import java.util.List;

public interface CitaService {
    
    List<Cita> listarCitas();
    
    List<Cita> listarCitasPorPaciente(Long idPaciente);
    
    List<Cita> listarCitasPorDoctor(Long idDoctor);
    
    List<Cita> listarCitasPorFecha(String fecha);
    
    void guardar(Cita cita);
    
    void eliminar(Cita cita);
    
    Cita encontrarCita(Cita cita);
} 