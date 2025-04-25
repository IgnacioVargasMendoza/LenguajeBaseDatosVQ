package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.EspecialidadesDAO;
import com.hospitalMilagro.domain.Especialidades;
import com.hospitalMilagro.service.EspecialidadesService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class EspecialidadesServiceImpl implements EspecialidadesService{

    @Autowired
    private EspecialidadesDAO especialidadesDao;
    
    @Override
    @Transactional(readOnly=true)
    public List<Especialidades> listaEspecialidades() {
        List listaEspecialidades=especialidadesDao.listaEspecialidades();
        return listaEspecialidades;
    }

    @Override
    public void insertarEspecialidad(Especialidades especialidades) {
        especialidadesDao.insertarEspecialidad(
                especialidades.getNombre(), 
                especialidades.getDescripcion()
        );
    }
    
}
