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
public interface SubEspecialidadDAO {
    
    @Procedure(procedureName = "Insert_Subespecialidad")
    void insertSubespecialidad(
        @Param("p_id_subespecialidad") Long idSubespecialidad,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Subespecialidad")
    void obtenerSubespecialidad(
        @Param("p_id_subespecialidad") Long idSubespecialidad,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Subespecialidad")
    void updateSubespecialidad(
        @Param("p_id_subespecialidad") Long idSubespecialidad,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Subespecialidad")
    void deleteSubespecialidad(@Param("p_id_subespecialidad") Long idSubespecialidad);
}

