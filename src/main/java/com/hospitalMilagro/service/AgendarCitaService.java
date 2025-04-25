package com.hospitalMilagro.service;

import com.hospitalMilagro.domain.AgendarCita;
import java.util.List;

public interface AgendarCitaService {
    
    public void registrarCita(AgendarCita cita);
    
    public List<AgendarCita> listaCitas();
}
