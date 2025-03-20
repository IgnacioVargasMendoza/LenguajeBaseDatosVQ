package com.hospitalMilagro.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 *
 * @author tanyr
 */
@Data
@Entity
@Table(name = "FIDE_FACTURA_TB")
public class Factura implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_FACTURA", nullable = false)
    private Long idFactura;

    @Column(name = "NUMERO_FACTURA", length = 50, nullable = false)
    private String numeroFactura;

    @Column(name = "FECHA_EMISION", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date fechaEmision;

    @Column(name = "FECHA_VENCIMIENTO", nullable = true)
    @Temporal(TemporalType.DATE)
    private Date fechaVencimiento;

    @Column(name = "MONTO_TOTAL", precision = 10, scale = 2, nullable = false)
    private Double montoTotal;

    @Column(name = "ESTADO_PAGO", length = 20, nullable = false)
    private String estadoPago;

    @ManyToOne
    @JoinColumn(name = "ID_PACIENTE", nullable = true)
    private Paciente paciente;

    @Column(name = "ACTIVO", nullable = true)
    private Short activo;
}
