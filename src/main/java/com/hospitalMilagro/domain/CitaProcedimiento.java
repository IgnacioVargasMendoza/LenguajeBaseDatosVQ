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
@Table(name = "FIDE_CITAS_PROCEDIMIENTOS_TB")
public class CitaProcedimiento {

    @ManyToOne
    @JoinColumn(name = "ID_CITA", nullable = false)
    private Citas cita;

    @ManyToOne
    @JoinColumn(name = "ID_PROCEDIMIENTO", nullable = false)
    private Procedimientos procedimiento;
}

