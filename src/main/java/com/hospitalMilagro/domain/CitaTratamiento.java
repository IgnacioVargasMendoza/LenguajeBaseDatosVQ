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
@Table(name = "FIDE_CITA_TRATAMIENTO_TB")
public class CitaTratamiento implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @ManyToOne
    @JoinColumn(name = "ID_CITA", nullable = false)
    private Citas cita;

    @Id
    @ManyToOne
    @JoinColumn(name = "ID_TRATAMIENTO", nullable = false)
    private Tratamientos tratamiento;
}
