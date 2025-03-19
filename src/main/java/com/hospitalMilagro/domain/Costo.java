/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hospitalMilagro.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;
import java.util.Date;

/**
 *
 * @author tanyr
 */
@Data
@Entity
@Table(name = "FIDE_COSTO_TB")
public class Costo implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_COSTO", nullable = false)
    private Long idCosto;

    @Column(name = "DESCRIPTION", nullable = false, length = 50)
    private String description;

    @Column(name = "MONTO", nullable = false, precision = 10, scale = 2)
    private Double monto;

    @Column(name = "FECHA_REGISTRO", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date fechaRegistro;

    @Column(name = "ID_PROCEDIMIENTO", nullable = false)
    private Long idProcedimiento;

    @Column(name = "ACTIVO", nullable = false, precision = 1)
    private Integer activo;
}
