package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.DoctorDAO;
import com.hospitalMilagro.domain.Doctor;
import com.hospitalMilagro.service.DoctorService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DoctorServiceImpl implements DoctorService{

    @Autowired
    private DoctorDAO doctorDAO;
    
    @Override
    @Transactional
    public List<Doctor> listaDoctores(){
        List listaDoctores=doctorDAO.listaDoctores();
        return listaDoctores;
    }
    
}
