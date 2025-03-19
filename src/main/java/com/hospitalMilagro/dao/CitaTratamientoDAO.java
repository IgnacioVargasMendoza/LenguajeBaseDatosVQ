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
public interface CitaTratamientoDAO {
    
     @Procedure(procedureName = "Insert_CitaTratamiento")
    void insertCitaTratamiento(
        @Param("p_id_cita") Long idCita,
        @Param("p_id_tratamiento") Long idTratamiento
    );

    @Procedure(procedureName = "Obtener_CitaTratamiento")
    void obtenerCitaTratamiento(
        @Param("p_id_cita") Long idCita,
        @Param("p_id_tratamiento") Long idTratamiento,
        @Param("p_cursor") Object cursor // Ajusta el tipo según tu necesidad
    );

    @Procedure(procedureName = "Delete_CitaTratamiento")
    void deleteCitaTratamiento(
        @Param("p_id_cita") Long idCita,
        @Param("p_id_tratamiento") Long idTratamiento
    );
}

