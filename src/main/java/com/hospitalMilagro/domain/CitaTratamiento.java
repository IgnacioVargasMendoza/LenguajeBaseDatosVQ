package com.hospitalMilagro.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

/**
 *
 * @author tanyr
 */
@Data
@Entity
@Table(name = "FIDE_CITAS_TRATAMIENTOS_TB")
public class CitaTratamiento {

    @ManyToOne
    @JoinColumn(name = "ID_CITA", nullable = false)
    private Citas cita;

    @ManyToOne
    @JoinColumn(name = "ID_TRATAMIENTO", nullable = false)
    private Tratamientos tratamiento;
}


