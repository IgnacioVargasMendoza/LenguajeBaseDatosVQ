package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Doctor;
import java.util.List;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DoctorDAO extends CrudRepository<Doctor, Long>{
    
    @Procedure(procedureName = "FIDE_LISTAR_DOCTORES_SP" , refCursor = true, outputParameterName = "LISTA_DOCTORES")
    List<Doctor> listaDoctores();
}
