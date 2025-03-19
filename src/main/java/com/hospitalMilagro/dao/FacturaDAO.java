/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import java.util.Date;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface FacturaDAO {
    
    @Procedure(procedureName = "Insert_Factura")
    void insertFactura(
        @Param("p_id_factura") Long idFactura,
        @Param("p_numero_factura") String numeroFactura,
        @Param("p_fecha_emision") Date fechaEmision,
        @Param("p_fecha_vencimiento") Date fechaVencimiento,
        @Param("p_monto_total") Double montoTotal,
        @Param("p_estado_pago") String estadoPago,
        @Param("p_id_paciente") Long idPaciente,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Factura")
    void obtenerFactura(
        @Param("p_id_factura") Long idFactura,
        @Param("p_numero_factura") String numeroFactura,
        @Param("p_fecha_emision") Date fechaEmision,
        @Param("p_fecha_vencimiento") Date fechaVencimiento,
        @Param("p_monto_total") Double montoTotal,
        @Param("p_estado_pago") String estadoPago,
        @Param("p_id_paciente") Long idPaciente,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Factura")
    void updateFactura(
        @Param("p_id_factura") Long idFactura,
        @Param("p_numero_factura") String numeroFactura,
        @Param("p_fecha_emision") Date fechaEmision,
        @Param("p_fecha_vencimiento") Date fechaVencimiento,
        @Param("p_monto_total") Double montoTotal,
        @Param("p_estado_pago") String estadoPago,
        @Param("p_id_paciente") Long idPaciente,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Factura")
    void deleteFactura(@Param("p_id_factura") Long idFactura);
}

