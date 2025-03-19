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
@Table(name = "FIDE_ESPECIALIDADES_TB")
public class Especialidades implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_ESPECIALIDAD", nullable = false)
    private Long idEspecialidad;

    @Column(name = "NOMBRE_ESPECIALIDAD", length = 50, nullable = false)
    private String nombreEspecialidad;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;

}
