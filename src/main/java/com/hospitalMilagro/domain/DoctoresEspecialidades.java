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
@Table(name = "FIDE_DOCTORES_ESPECIALIDADES_TB")
public class DoctoresEspecialidades implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @ManyToOne
    @JoinColumn(name = "ID_ESPECIALIDAD", nullable = false)
    private Especialidades especialidad;

    @Id
    @ManyToOne
    @JoinColumn(name = "ID_DOCTOR", nullable = false)
    private Doctores doctor;

}
