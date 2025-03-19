/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.TratamientosMedicamentos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface TratamientosMedicamentosDAO extends JpaRepository<TratamientosMedicamentos, Long> {
    
     @Procedure(procedureName = "Insert_TratamientoProcedimiento")
    void insertTratamientoProcedimiento(
        @Param("p_id_tratamiento") Long idTratamiento,
        @Param("p_id_procedimiento") Long idProcedimiento
    );

    @Procedure(procedureName = "Obtener_TratamientoProcedimiento")
    void obtenerTratamientoProcedimiento(
        @Param("p_id_tratamiento") Long idTratamiento,
        @Param("p_id_procedimiento") Long idProcedimiento,
        @Param("p_cursor") Object cursor // Ajusta el tipo según tu necesidad
    );

    @Procedure(procedureName = "Delete_TratamientoProcedimiento")
    void deleteTratamientoProcedimiento(
        @Param("p_id_tratamiento") Long idTratamiento,
        @Param("p_id_procedimiento") Long idProcedimiento
    );
}

