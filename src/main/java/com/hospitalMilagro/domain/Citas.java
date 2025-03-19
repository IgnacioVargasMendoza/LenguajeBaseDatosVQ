
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
@Table(name = "FIDE_CITAS_TB")
public class Citas implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_CITA", nullable = false)
    private Long idCita;

    @Column(name = "FECHA", nullable = false)
    @Temporal(TemporalType.DATE)
    private java.util.Date fecha;

    @Column(name = "HORA_CITA", nullable = false, length = 10)
    private String horaCita;

    @ManyToOne
    @JoinColumn(name = "ID_DISPONIBILIDAD", nullable = false)
    private Disponibilidad disponibilidad;

    @ManyToOne
    @JoinColumn(name = "ID_COSTO", nullable = false)
    private Costo costo;

    @ManyToOne
    @JoinColumn(name = "ID_PACIENTE", nullable = false)
    private Paciente paciente;

    @ManyToOne
    @JoinColumn(name = "ID_DOCTOR", nullable = false)
    private Doctores doctor;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO", nullable = false)
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "ID_ESTADO", nullable = false)
    private EstadoCitas estado;

    @ManyToOne
    @JoinColumn(name = "ID_PROCEDIMIENTO", nullable = false)
    private Procedimientos procedimiento;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;
}
