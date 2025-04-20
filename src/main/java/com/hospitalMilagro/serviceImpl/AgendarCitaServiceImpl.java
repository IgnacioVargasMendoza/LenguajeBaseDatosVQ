package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.AgendarCitaDAO;
import com.hospitalMilagro.domain.AgendarCita;
import com.hospitalMilagro.service.AgendarCitaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AgendarCitaServiceImpl implements AgendarCitaService{

    @Autowired
    private AgendarCitaDAO agendarCitaDao;
    
    @Override
    @Transactional
    public void insertarCita(AgendarCita agendarCita) {
        agendarCitaDao.insertCita(
                agendarCita.getFecha(), 
                agendarCita.getHoraCita(), 
                agendarCita.getIdEstadoCita(), 
                agendarCita.getIdDoctor(), 
                agendarCita.getIdPaciente());
    }
    
}
