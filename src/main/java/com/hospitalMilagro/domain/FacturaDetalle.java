package com.hospitalMilagro.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

/**
 *
 * @author tanyr
 */

@Data
@Entity
@Table(name = "FIDE_FACTURAS_DETALLE_TB")
public class FacturaDetalle {

    @Column(name = "MONTO", nullable = false)
    private Double monto;

    @Column(name = "DESCRIPCION", length = 2000)
    private String descripcion;

    @ManyToOne
    @JoinColumn(name = "ID_FACTURA", nullable = false)
    private Factura factura;

    @ManyToOne
    @JoinColumn(name = "ID_COSTO", nullable = false)
    private Costo costoCita;
}
