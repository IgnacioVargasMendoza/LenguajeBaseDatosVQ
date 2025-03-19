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
public interface ServicioEspecialidadDAO {
 
     @Procedure(procedureName = "Insert_ServicioEspecialidad")
    void insertServicioEspecialidad(
        @Param("p_id_servicio") Long idServicio,
        @Param("p_id_especialidad") Long idEspecialidad
    );

    @Procedure(procedureName = "Obtener_ServicioEspecialidad")
    void obtenerServicioEspecialidad(
        @Param("p_id_servicio") Long idServicio,
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_cursor") Object cursor // Ajusta el tipo según tu necesidad
    );

    @Procedure(procedureName = "Delete_ServicioEspecialidad")
    void deleteServicioEspecialidad(
        @Param("p_id_servicio") Long idServicio,
        @Param("p_id_especialidad") Long idEspecialidad
    );
}

   

