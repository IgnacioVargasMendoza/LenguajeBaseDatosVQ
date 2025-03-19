/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Medicamentos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface MedicamentosDAO extends JpaRepository<Medicamentos, Long> {
    
      @Procedure(procedureName = "Insert_Medicamento")
    void insertMedicamento(
        @Param("p_id_medicamento") Long idMedicamento,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_precio") Double precio,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Medicamento")
    void obtenerMedicamento(
        @Param("p_id_medicamento") Long idMedicamento,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_precio") Double precio,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Medicamento")
    void updateMedicamento(
        @Param("p_id_medicamento") Long idMedicamento,
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion,
        @Param("p_precio") Double precio,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Medicamento")
    void deleteMedicamento(@Param("p_id_medicamento") Long idMedicamento);
}

