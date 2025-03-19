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
@Table(name = "FIDE_INVENTARIO_MEDICAMENTOS_TB")
public class InventarioMedicamentos implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_INVENTARIO", nullable = false)
    private Long idInventario;

    @Column(name = "NOMBRE_INVENTARIO", length = 20, nullable = false)
    private String nombreInventario;

    @Column(name = "CANTIDAD_MEDICAMENTO", precision = 10, nullable = false)
    private Long cantidadMedicamento;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;

    @ManyToOne
    @JoinColumn(name = "ID_MEDICAMENTO", nullable = false)
    private Medicamentos medicamento;

}
