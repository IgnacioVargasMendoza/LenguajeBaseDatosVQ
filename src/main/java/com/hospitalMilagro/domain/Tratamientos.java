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
@Table(name = "FIDE_TRATAMIENTOS_TB")
public class Tratamientos implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_TRATAMIENTO", 
            nullable = false)
    private Long idTratamiento;

    @Column(name = "NOMBRE_TRATAMIENTO", 
            nullable = false, 
            length = 20)
    private String nombreTratamiento;

    @Column(name = "DESCRIPTION", 
            nullable = false, 
            length = 1000)
    private String description;

    @Column(name = "COSTO", 
            nullable = false, 
            precision = 10, 
            scale = 2)
    private Double costo;

    @Column(name = "ACTIVO", 
            nullable = false, 
            precision = 1)
    private Integer activo;

    @ManyToOne
    @JoinColumn(name = "ID_PACIENTE", 
            nullable = false)
    private Paciente paciente;

}
