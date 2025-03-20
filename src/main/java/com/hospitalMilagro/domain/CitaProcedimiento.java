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
@Table(name = "FIDE_CITA_PROCEDIMIENTO_TB")
public class CitaProcedimiento implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @ManyToOne
    @JoinColumn(name = "ID_CITA", nullable = false)
    private Citas cita;

    @Id
    @ManyToOne
    @JoinColumn(name = "ID_PROCEDIMIENTO", nullable = false)
    private Procedimientos procedimiento;
}
