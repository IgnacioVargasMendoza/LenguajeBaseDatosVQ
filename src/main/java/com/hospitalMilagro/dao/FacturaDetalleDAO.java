/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface FacturaDetalleDAO {
    
      @Procedure(procedureName = "Insert_FacturaDetalle")
    void insertFacturaDetalle(
        @Param("p_id_factura") Long idFactura,
        @Param("p_id_costo") Long idCosto,
        @Param("p_monto") Double monto,
        @Param("p_descripcion") String descripcion
    );

    @Procedure(procedureName = "Obtener_FacturaDetalle")
    void obtenerFacturaDetalle(
        @Param("p_id_factura") Long idFactura,
        @Param("p_id_costo") Long idCosto,
        @Param("p_monto") Double monto,
        @Param("p_descripcion") String descripcion
    );

    @Procedure(procedureName = "Update_FacturaDetalle")
    void updateFacturaDetalle(
        @Param("p_id_factura") Long idFactura,
        @Param("p_id_costo") Long idCosto,
        @Param("p_monto") Double monto,
        @Param("p_descripcion") String descripcion
    );

    @Procedure(procedureName = "Delete_FacturaDetalle")
    void deleteFacturaDetalle(
        @Param("p_id_factura") Long idFactura,
        @Param("p_id_costo") Long idCosto
    );
}
