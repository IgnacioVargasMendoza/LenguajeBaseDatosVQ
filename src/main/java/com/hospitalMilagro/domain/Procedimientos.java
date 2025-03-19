/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hospitalMilagro.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

/**
 *
 * @author tanyr
 */
@Entity
@Data
@Table(name = "FIDE_PROCEDIMIENTOS_TB")
public class Procedimientos implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_PROCEDIMIENTO", nullable = false)
    private Long idProcedimiento;

    @Column(name = "NOMBRE_PROCEDIMIENTO", nullable = false, length = 50)
    private String nombreProcedimiento;

    @Column(name = "DESCRIPTION", nullable = false, length = 255)
    private String description;

    @Column(name = "TIPO_PROCEDIMIENTO", nullable = false, length = 20)
    private String tipoProcedimiento;

    @Column(name = "RIESGO", nullable = true, length = 10)
    private String riesgo;

    @Column(name = "ACTIVO", nullable = false, precision = 1)
    private Integer activo;

    @Column(name = "ID_TRATAMIENTO", nullable = false)
    private Long idTratamiento;
}
