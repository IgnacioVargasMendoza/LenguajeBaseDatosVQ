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

    @Column(name = "NOMBRE", length = 50, nullable = false)
    private String nombre;

    @Column(name = "DESCRIPCION", length = 5000)
    private String descripcion;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;
}
