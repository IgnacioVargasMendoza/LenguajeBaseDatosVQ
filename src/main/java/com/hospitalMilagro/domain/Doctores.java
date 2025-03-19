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
@Table(name = "FIDE_DOCTORES_TB")
public class Doctores implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_DOCTOR", nullable = false)
    private Long idDoctor;

    @Column(name = "TELEFONO", length = 15)
    private String telefono;

    @Column(name = "NUMEROLICENCIA", length = 50, nullable = false, unique = true)
    private String numeroLicencia;

    @Column(name = "ID_USUARIO", nullable = false, unique = true)
    private Long idUsuario;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;

}
