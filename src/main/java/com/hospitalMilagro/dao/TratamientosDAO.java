/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Tratamientos;
import java.util.Date;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface TratamientosDAO extends JpaRepository<Tratamientos, Long> {
    
    @Procedure(procedureName = "Insert_Tratamiento")
    void insertTratamiento(
        @Param("p_id_tratamiento") Long idTratamiento,
        @Param("p_descripcion") String descripcion,
        @Param("p_fecha_inicio") Date fechaInicio,
        @Param("p_fecha_fin") Date fechaFin,
        @Param("p_activo") Integer activo,
        @Param("p_id_paciente") Long idPaciente
    );

    @Procedure(procedureName = "Obtener_Tratamiento")
    void obtenerTratamiento(
        @Param("p_id_tratamiento") Long idTratamiento,
        @Param("p_descripcion") String descripcion,
        @Param("p_fecha_inicio") Date fechaInicio,
        @Param("p_fecha_fin") Date fechaFin,
        @Param("p_activo") Integer activo,
        @Param("p_id_paciente") Long idPaciente
    );

    @Procedure(procedureName = "Update_Tratamiento")
    void updateTratamiento(
        @Param("p_id_tratamiento") Long idTratamiento,
        @Param("p_descripcion") String descripcion,
        @Param("p_fecha_inicio") Date fechaInicio,
        @Param("p_fecha_fin") Date fechaFin,
        @Param("p_activo") Integer activo,
        @Param("p_id_paciente") Long idPaciente
    );

    @Procedure(procedureName = "Delete_Tratamiento")
    void deleteTratamiento(@Param("p_id_tratamiento") Long idTratamiento);
}


