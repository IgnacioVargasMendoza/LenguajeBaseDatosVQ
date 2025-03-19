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
@Data
@Entity
@Table(name = "FIDE_DISPONIBILIDAD_TB")
public class Disponibilidad implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_DISPONIBILIDAD", nullable = false)
    private Long idDisponibilidad;

    @Column(name = "DIA", length = 30, nullable = false)
    private String dia;

    @Column(name = "HORA_INICIO")
    @Temporal(TemporalType.TIME)
    private java.util.Date horaInicio;

    @Column(name = "HORA_FIN")
    @Temporal(TemporalType.TIME)
    private java.util.Date horaFin;

    @ManyToOne
    @JoinColumn(name = "ACTIVO", nullable = false)
    private Short activo;

    @ManyToOne
    @JoinColumn(name = "ID_PACIENTE", nullable = false)
    private Paciente paciente;

    @ManyToOne
    @JoinColumn(name = "ID_DOCTOR", nullable = false)
    private Doctores doctor;

}
