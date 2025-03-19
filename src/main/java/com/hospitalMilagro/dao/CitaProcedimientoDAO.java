/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface CitaProcedimientoDAO {
    
     @Procedure(procedureName = "Insert_CitaProcedimiento")
    void insertCitaProcedimiento(
        @Param("p_id_cita") Long idCita,
        @Param("p_id_procedimiento") Long idProcedimiento
    );

    @Procedure(procedureName = "Obtener_CitaProcedimiento")
    void obtenerCitaProcedimiento(
        @Param("p_id_cita") Long idCita,
        @Param("p_id_procedimiento") Long idProcedimiento,
        @Param("p_cursor") Object cursor // Ajusta el tipo según tu necesidad
    );

    @Procedure(procedureName = "Delete_CitaProcedimiento")
    void deleteCitaProcedimiento(
        @Param("p_id_cita") Long idCita,
        @Param("p_id_procedimiento") Long idProcedimiento
    );
}

