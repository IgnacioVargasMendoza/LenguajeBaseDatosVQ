/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Disponibilidad;
import java.util.Date;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface DisponibilidadDAO extends JpaRepository<Disponibilidad, Long> {
    @Procedure(procedureName = "Insert_Disponibilidad")
    void insertDisponibilidad(
        @Param("p_id_disponibilidad") Long idDisponibilidad,
        @Param("p_dia") String dia,
        @Param("p_hora_inicio") Date horaInicio,
        @Param("p_hora_fin") Date horaFin,
        @Param("p_activo") Integer activo,
        @Param("p_id_doctor") Long idDoctor
    );

    @Procedure(procedureName = "Obtener_Disponibilidad")
    void obtenerDisponibilidad(
        @Param("p_id_disponibilidad") Long idDisponibilidad,
        @Param("p_dia") String dia,
        @Param("p_hora_inicio") Date horaInicio,
        @Param("p_hora_fin") Date horaFin,
        @Param("p_activo") Integer activo,
        @Param("p_id_doctor") Long idDoctor
    );

    @Procedure(procedureName = "Update_Disponibilidad")
    void updateDisponibilidad(
        @Param("p_id_disponibilidad") Long idDisponibilidad,
        @Param("p_dia") String dia,
        @Param("p_hora_inicio") Date horaInicio,
        @Param("p_hora_fin") Date horaFin,
        @Param("p_activo") Integer activo,
        @Param("p_id_doctor") Long idDoctor
    );

    @Procedure(procedureName = "Delete_Disponibilidad")
    void deleteDisponibilidad(@Param("p_id_disponibilidad") Long idDisponibilidad);
}


