package com.hospitalMilagro.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

/**
 *
 * @author tanyr
 */
@Data
@Entity
@Table(name = "FIDE_FACTURA_DETALLE_TB")
public class FacturaDetalle implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_FACTURA", nullable = false)
    private Long idFactura;

    @ManyToOne
    @JoinColumn(name = "ID_COSTO", nullable = false)
    private Costo costo;

    @Column(name = "MONTO", precision = 10, scale = 2, nullable = false)
    private Double monto;

    @Column(name = "DESCRIPCION", length = 2000, nullable = true)
    private String descripcion;
}
