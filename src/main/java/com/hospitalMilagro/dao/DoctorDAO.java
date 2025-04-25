package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Doctor;
import java.util.List;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DoctorDAO extends CrudRepository<Doctor, Long>{
    
    @Procedure(procedureName = "FIDE_LISTAR_DOCTORES_SP" , refCursor = true, outputParameterName = "LISTA_DOCTORES")
    List<Doctor> listaDoctores();
    
    @Procedure(procedureName = "FIDE_REGISTRAR_DOCTOR_SP")
    void registrarDoctor(
        @Param("p_telefono") String telefono,
        @Param("p_numero_licencia") String numeroLicencia,
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_id_direccion") Long idDireccion
    );
}
