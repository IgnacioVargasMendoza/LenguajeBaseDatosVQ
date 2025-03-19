/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Paciente;
import java.util.Date;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface PacienteDAO extends JpaRepository<Paciente, Long> {
    
    @Procedure(procedureName = "Insert_Paciente")
    void insertPaciente(
        @Param("p_id_paciente") Long idPaciente,
        @Param("p_fecha_nacimiento") Date fechaNacimiento,
        @Param("p_numero_seguro") String numeroSeguro,
        @Param("p_direccion") String direccion,
        @Param("p_telefono") String telefono,
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_activo") Integer activo,
        @Param("p_id_direccion") Long idDireccion
    );

    @Procedure(procedureName = "Obtener_Paciente")
    void obtenerPaciente(
        @Param("p_id_paciente") Long idPaciente,
        @Param("p_fecha_nacimiento") Date fechaNacimiento,
        @Param("p_numero_seguro") String numeroSeguro,
        @Param("p_direccion") String direccion,
        @Param("p_telefono") String telefono,
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_activo") Integer activo,
        @Param("p_id_direccion") Long idDireccion
    );

    @Procedure(procedureName = "Update_Paciente")
    void updatePaciente(
        @Param("p_id_paciente") Long idPaciente,
        @Param("p_fecha_nacimiento") Date fechaNacimiento,
        @Param("p_numero_seguro") String numeroSeguro,
        @Param("p_direccion") String direccion,
        @Param("p_telefono") String telefono,
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_activo") Integer activo,
        @Param("p_id_direccion") Long idDireccion
    );

    @Procedure(procedureName = "Delete_Paciente")
    void deletePaciente(@Param("p_id_paciente") Long idPaciente);
}


