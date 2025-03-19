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
@Table(name = "FIDE_HISTORIAL_CITAS_TB")
public class HistorialCitas implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_HISTORIAL", nullable = false)
    private Long idHistorial;

    @ManyToOne
    @JoinColumn(name = "ID_CITA", nullable = false)
    private Citas cita;

    @ManyToOne
    @JoinColumn(name = "ID_ESTADO", nullable = false)
    private EstadoCitas estado;

}
