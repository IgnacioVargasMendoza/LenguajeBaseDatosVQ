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
public interface ServicioDAO {
    
     @Procedure(procedureName = "Insert_Servicio")
    void insertServicio(
        @Param("p_id_servicio") Long idServicio,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Servicio")
    void obtenerServicio(
        @Param("p_id_servicio") Long idServicio,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Servicio")
    void updateServicio(
        @Param("p_id_servicio") Long idServicio,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Servicio")
    void deleteServicio(@Param("p_id_servicio") Long idServicio);
}

