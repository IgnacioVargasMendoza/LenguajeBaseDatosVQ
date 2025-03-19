/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Especialidades;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface EspecialidadesDAO extends JpaRepository<Especialidades, Long> {
     @Procedure(procedureName = "Insert_Especialidad")
    void insertEspecialidad(
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Especialidad")
    void obtenerEspecialidad(
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Especialidad")
    void updateEspecialidad(
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Especialidad")
    void deleteEspecialidad(@Param("p_id_especialidad") Long idEspecialidad);
}



