/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.InventarioMedicamentos;
import java.util.Date;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface InventarioMedicamentosDAO extends JpaRepository<InventarioMedicamentos, Long> {
 
      @Procedure(procedureName = "Insert_InventarioMedicamento")
    void insertInventarioMedicamento(
        @Param("p_id_inventario") Long idInventario,
        @Param("p_id_medicamento") Long idMedicamento,
        @Param("p_cantidad") Integer cantidad,
        @Param("p_fecha_ultima_actualizacion") Date fechaUltimaActualizacion,
        @Param("p_observaciones") String observaciones
    );

    @Procedure(procedureName = "Obtener_InventarioMedicamento")
    void obtenerInventarioMedicamento(
        @Param("p_id_inventario") Long idInventario,
        @Param("p_id_medicamento") Long idMedicamento,
        @Param("p_cantidad") Integer cantidad,
        @Param("p_fecha_ultima_actualizacion") Date fechaUltimaActualizacion,
        @Param("p_observaciones") String observaciones
    );

    @Procedure(procedureName = "Update_InventarioMedicamento")
    void updateInventarioMedicamento(
        @Param("p_id_inventario") Long idInventario,
        @Param("p_id_medicamento") Long idMedicamento,
        @Param("p_cantidad") Integer cantidad,
        @Param("p_fecha_ultima_actualizacion") Date fechaUltimaActualizacion,
        @Param("p_observaciones") String observaciones
    );

    @Procedure(procedureName = "Delete_InventarioMedicamento")
    void deleteInventarioMedicamento(@Param("p_id_inventario") Long idInventario);
}


