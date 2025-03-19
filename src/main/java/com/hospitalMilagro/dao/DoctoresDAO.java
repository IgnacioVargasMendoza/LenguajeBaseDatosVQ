/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Doctores;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface DoctoresDAO extends JpaRepository<Doctores, Long> {
    @Procedure(procedureName = "Insert_Doctor")
    void insertDoctor(
        @Param("p_id_doctor") Long idDoctor,
        @Param("p_telefono") String telefono,
        @Param("p_numerolicencia") String numeroLicencia,
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Doctor")
    void obtenerDoctor(
        @Param("p_id_doctor") Long idDoctor,
        @Param("p_telefono") String telefono,
        @Param("p_numerolicencia") String numeroLicencia,
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Doctor")
    void updateDoctor(
        @Param("p_id_doctor") Long idDoctor,
        @Param("p_telefono") String telefono,
        @Param("p_numerolicencia") String numeroLicencia,
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Doctor")
    void deleteDoctor(@Param("p_id_doctor") Long idDoctor);
}


