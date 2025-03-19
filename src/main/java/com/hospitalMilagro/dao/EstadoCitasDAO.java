/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.EstadoCitas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface EstadoCitasDAO extends JpaRepository<EstadoCitas, Long> {
    @Procedure(procedureName = "Insert_EstadoCita")
    void insertEstadoCita(
        @Param("p_id_estado") Long idEstado,
        @Param("p_nombre_estado") String nombreEstado,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_EstadoCita")
    void obtenerEstadoCita(
        @Param("p_id_estado") Long idEstado,
        @Param("p_nombre_estado") String nombreEstado,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_EstadoCita")
    void updateEstadoCita(
        @Param("p_id_estado") Long idEstado,
        @Param("p_nombre_estado") String nombreEstado,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_EstadoCita")
    void deleteEstadoCita(@Param("p_id_estado") Long idEstado);
}


