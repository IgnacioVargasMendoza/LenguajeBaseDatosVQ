/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
@Table(name = "FIDE_PACIENTE_TB")
public class Paciente implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_PACIENTE", nullable = false)
    private Long idPaciente;

    @Column(name = "FECHA_NACIMIENTO", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date fechaNacimiento;

    @Column(name = "NUMERO_SEGURO", length = 50)
    private String numeroSeguro;

    @Column(name = "DIRECCION", length = 255, nullable = false)
    private String direccion;

    @Column(name = "TELEFONO", length = 15, nullable = false)
    private String telefono;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO")
    private Usuario usuario;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;

    @ManyToOne
    @JoinColumn(name = "ID_DIRECCION", nullable = false)
    private Direccion direccionFK;

}
