package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.AgendarCita;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AgendarCitaDAO extends CrudRepository<AgendarCita, Long>{
    
    @Procedure(procedureName = "FIDE_CREAR_CITA_SP")
    void insertCita(
        @Param("p_fecha") String fecha,
        @Param("p_hora_cita") String horaCita,
        @Param("p_estado_cita") String estadoCita,
        @Param("p_doctor") String doctor,
        @Param("p_paciente") String paciente
    );
}
