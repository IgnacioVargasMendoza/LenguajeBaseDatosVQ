package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.EstadoCitaDAO;
import com.hospitalMilagro.domain.EstadoCita;
import com.hospitalMilagro.service.EstadoCitaService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class EstadoCitaServiceImpl implements EstadoCitaService {

    @Autowired
    private EstadoCitaDAO estadoCitaDAO;
    
    @Override
    @Transactional(readOnly=true)
    public List<EstadoCita> listaEstadosCita() {
        return estadoCitaDAO.listaEstadosCita();
    }
} 