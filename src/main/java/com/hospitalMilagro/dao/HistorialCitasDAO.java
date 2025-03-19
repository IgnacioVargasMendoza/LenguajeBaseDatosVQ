/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.HistorialCitas;
import java.util.Date;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface HistorialCitasDAO extends JpaRepository<HistorialCitas, Long> {
    
    @Procedure(procedureName = "Insert_HistorialCita")
    void insertHistorialCita(
        @Param("p_id_historial") Long idHistorial,
        @Param("p_id_cita") Long idCita,
        @Param("p_fecha_cambio") Date fechaCambio,
        @Param("p_id_estado_anterior") Long idEstadoAnterior,
        @Param("p_id_estado_nuevo") Long idEstadoNuevo,
        @Param("p_observaciones") String observaciones,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_HistorialCita")
    void obtenerHistorialCita(
        @Param("p_id_historial") Long idHistorial,
        @Param("p_id_cita") Long idCita,
        @Param("p_fecha_cambio") Date fechaCambio,
        @Param("p_id_estado_anterior") Long idEstadoAnterior,
        @Param("p_id_estado_nuevo") Long idEstadoNuevo,
        @Param("p_observaciones") String observaciones,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_HistorialCita")
    void updateHistorialCita(
        @Param("p_id_historial") Long idHistorial,
        @Param("p_id_cita") Long idCita,
        @Param("p_fecha_cambio") Date fechaCambio,
        @Param("p_id_estado_anterior") Long idEstadoAnterior,
        @Param("p_id_estado_nuevo") Long idEstadoNuevo,
        @Param("p_observaciones") String observaciones,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_HistorialCita")
    void deleteHistorialCita(@Param("p_id_historial") Long idHistorial);
}

