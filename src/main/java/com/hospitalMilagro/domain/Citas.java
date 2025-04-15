package com.hospitalMilagro.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
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

    @Column(name = "FECHA",
            nullable = false)
    private Date fecha;

    @Column(name = "HORA_CITA",
            nullable = false,
            length = 10)
    private String horaCita;

    @OneToOne(mappedBy = "cita")
    private Costo costo;
    
    @ManyToMany
    @JoinTable(
            name = "FIDE_CITAS_PROCEDIMIENTOS",
            joinColumns = @JoinColumn(name = "ID_CITA"),
            inverseJoinColumns = @JoinColumn(name = "ID_PROCEDIMIENTO")
    )
    private List<Procedimientos> procedimientos;
    
    @ManyToMany
    @JoinTable(
            name = "FIDE_CITAS_TRATAMIENTOS",
            joinColumns = @JoinColumn(name = "ID_CITA"),
            inverseJoinColumns = @JoinColumn(name = "ID_TRATAMIENTO")
    )
    private List<Tratamientos> tratamientos;
 

    @ManyToOne
    @JoinColumn(name = "ID_PACIENTE",
            nullable = false)
    private Paciente paciente;
    @ManyToOne
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    @JoinColumn(name = "ID_DOCTOR", nullable = false)
    private Doctores doctor;

    @ManyToOne
    @JoinColumn(name = "ID_ESTADO", nullable = false)
=======
    @JoinColumn(name = "ID_ESTADO",
            nullable = false)
>>>>>>> Stashed changes
=======
    @JoinColumn(name = "ID_ESTADO",
            nullable = false)
>>>>>>> Stashed changes
    private EstadoCitas estado;

    @ManyToOne
    @JoinColumn(name = "ID_DOCTOR",
            nullable = false)
    private Doctores doctor;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;
}
