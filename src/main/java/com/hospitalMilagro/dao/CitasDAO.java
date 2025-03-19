/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Citas;
import java.util.Date;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface CitasDAO extends JpaRepository<Citas, Long> {
    
     @Procedure(procedureName = "Insert_Cita")
    void insertCita(
        @Param("p_id_cita") Long idCita,
        @Param("p_fecha") Date fecha,
        @Param("p_hora_cita") String horaCita,
        @Param("p_id_estado_cita") Long idEstadoCita,
        @Param("p_id_doctor") Long idDoctor,
        @Param("p_id_paciente") Long idPaciente,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Cita")
    void obtenerCita(
        @Param("p_id_cita") Long idCita,
        @Param("p_fecha") Date fecha,
        @Param("p_hora_cita") String horaCita,
        @Param("p_id_estado_cita") Long idEstadoCita,
        @Param("p_id_doctor") Long idDoctor,
        @Param("p_id_paciente") Long idPaciente,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Cita")
    void updateCita(
        @Param("p_id_cita") Long idCita,
        @Param("p_fecha") Date fecha,
        @Param("p_hora_cita") String horaCita,
        @Param("p_id_estado_cita") Long idEstadoCita,
        @Param("p_id_doctor") Long idDoctor,
        @Param("p_id_paciente") Long idPaciente,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Cita")
    void deleteCita(@Param("p_id_cita") Long idCita);
}



