/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.DoctoresEspecialidades;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface DoctoresEspecialidadesDAO extends JpaRepository<DoctoresEspecialidades, Long> {
    
    @Procedure(procedureName = "Insert_DoctorEspecialidad")
    void insertDoctorEspecialidad(
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_id_doctor") Long idDoctor
    );

    @Procedure(procedureName = "Obtener_DoctorEspecialidad")
    void obtenerDoctorEspecialidad(
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_id_doctor") Long idDoctor,
        @Param("p_cursor") Object cursor // Ajusta el tipo según tu necesidad
    );

    @Procedure(procedureName = "Update_DoctorEspecialidad")
    void updateDoctorEspecialidad(
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_id_doctor") Long idDoctor,
        @Param("p_new_id_especialidad") Long newIdEspecialidad,
        @Param("p_new_id_doctor") Long newIdDoctor
    );

    @Procedure(procedureName = "Delete_DoctorEspecialidad")
    void deleteDoctorEspecialidad(
        @Param("p_id_especialidad") Long idEspecialidad,
        @Param("p_id_doctor") Long idDoctor
    );
}

