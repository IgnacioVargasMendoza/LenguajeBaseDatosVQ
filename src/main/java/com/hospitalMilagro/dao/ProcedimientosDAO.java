/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Procedimientos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface ProcedimientosDAO extends JpaRepository<Procedimientos, Long> {
     @Procedure(procedureName = "Insert_Procedimiento")
    void insertProcedimiento(
        @Param("p_id_procedimiento") Long idProcedimiento,
        @Param("p_nombre_procedimiento") String nombreProcedimiento,
        @Param("p_descripcion") String descripcion,
        @Param("p_tipo_procedimiento") String tipoProcedimiento,
        @Param("p_riesgo") String riesgo,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Procedimiento")
    void obtenerProcedimiento(
        @Param("p_id_procedimiento") Long idProcedimiento,
        @Param("p_nombre_procedimiento") String nombreProcedimiento,
        @Param("p_descripcion") String descripcion,
        @Param("p_tipo_procedimiento") String tipoProcedimiento,
        @Param("p_riesgo") String riesgo,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Procedimiento")
    void updateProcedimiento(
        @Param("p_id_procedimiento") Long idProcedimiento,
        @Param("p_nombre_procedimiento") String nombreProcedimiento,
        @Param("p_descripcion") String descripcion,
        @Param("p_tipo_procedimiento") String tipoProcedimiento,
        @Param("p_riesgo") String riesgo,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Procedimiento")
    void deleteProcedimiento(@Param("p_id_procedimiento") Long idProcedimiento);
}


