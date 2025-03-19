/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Costo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface CostoDAO extends JpaRepository<Costo, Long> {
    
      @Procedure(procedureName = "Insert_CostoCita")
    void insertCostoCita(
        @Param("p_id_costo") Long idCosto,
        @Param("p_id_cita") Long idCita,
        @Param("p_monto") Double monto,
        @Param("p_descripcion") String descripcion,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_CostoCita")
    void obtenerCostoCita(
        @Param("p_id_costo") Long idCosto,
        @Param("p_id_cita") Long idCita,
        @Param("p_monto") Double monto,
        @Param("p_descripcion") String descripcion,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_CostoCita")
    void updateCostoCita(
        @Param("p_id_costo") Long idCosto,
        @Param("p_id_cita") Long idCita,
        @Param("p_monto") Double monto,
        @Param("p_descripcion") String descripcion,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_CostoCita")
    void deleteCostoCita(@Param("p_id_costo") Long idCosto);
}


