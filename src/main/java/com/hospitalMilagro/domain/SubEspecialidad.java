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
@Table(name = "FIDE_SUBESPECIALIDAD_TB")
public class SubEspecialidad implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_SUBESPECIALIDAD", nullable = false)
    private Long idSubEspecialidad;

    @Column(name = "NOMBRE", length = 50, nullable = false)
    private String nombre;

    @Column(name = "DESCRIPCION", length = 5000, nullable = true)
    private String descripcion;

    @ManyToOne
    @JoinColumn(name = "ID_ESPECIALIDAD", nullable = false)
    private Especialidad especialidad;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;
}
