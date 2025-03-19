/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Direccion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface DireccionDAO extends JpaRepository<Direccion, Long> {
    
     @Procedure(procedureName = "Insert_Direccion")
    void insertDireccion(
        @Param("p_id_direccion") Long idDireccion,
        @Param("p_pais") String pais,
        @Param("p_canton") String canton,
        @Param("p_distrito") String distrito,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Direccion")
    void obtenerDireccion(
        @Param("p_id_direccion") Long idDireccion,
        @Param("p_pais") String pais,
        @Param("p_canton") String canton,
        @Param("p_distrito") String distrito,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Direccion")
    void updateDireccion(
        @Param("p_id_direccion") Long idDireccion,
        @Param("p_pais") String pais,
        @Param("p_canton") String canton,
        @Param("p_distrito") String distrito,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Direccion")
    void deleteDireccion(@Param("p_id_direccion") Long idDireccion);
}



