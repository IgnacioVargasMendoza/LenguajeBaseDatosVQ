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
@Table(name = "FIDE_SERVICIO_TB")
public class Servicio implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_SERVICIO", nullable = false)
    private Long idServicio;

    @Column(name = "NOMBRE", length = 30, nullable = false)
    private String nombre;

    @Column(name = "DESCRIPTION", length = 5000, nullable = true)
    private String description;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;
}
