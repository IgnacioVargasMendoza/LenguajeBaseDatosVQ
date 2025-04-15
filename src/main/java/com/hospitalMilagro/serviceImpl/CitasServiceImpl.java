package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.CitasDAO;
import com.hospitalMilagro.domain.Citas;
import com.hospitalMilagro.service.CitasService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Ignac
 */
@Service
public class CitasServiceImpl implements CitasService{
    
    @Autowired
    private CitasDAO citasDAO;
    
    @Override
    public void insertarCita(Citas cita) {
       citasDAO.insertCita(   
            cita.getFecha(),       
            cita.getHoraCita(),
            cita.getDoctor(),
            cita.getPaciente(),
            cita.getProcedimientos(),
            cita.getTratamientos(),
            cita.getActivo(),
       );
    }

    
}
