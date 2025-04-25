package com.hospitalMilagro.service;

import com.hospitalMilagro.domain.Especialidades;
import java.util.List;

public interface EspecialidadesService {
    
    public void insertarEspecialidad(Especialidades especialidades);
    
    public List<Especialidades> listaEspecialidades();
    
}
