package com.hospitalMilagro.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

@Data
@Entity
@Table(name = "FIDE_CITAS_TB")
public class Cita implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_CITA")
    private Long idCita;
    
    @ManyToOne
    @JoinColumn(name = "ID_PACIENTE")
    private Paciente paciente;
    
    @ManyToOne
    @JoinColumn(name = "ID_DOCTOR")
    private Doctor doctor;
    
    @Column(name = "FECHA_CITA")
    private Date fechaCita;
    
    @Column(name = "HORA_CITA")
    private String horaCita;
    
    @Column(name = "MOTIVO")
    private String motivo;
    
    @ManyToOne
    @JoinColumn(name = "ID_ESTADO_CITA")
    private EstadoCita estadoCita;
    
    @Column(name = "CREATION_DATE")
    private String creationDate;
    
    @Column(name = "CREATED_BY")
    private String createdBy;
    
    @Column(name = "LAST_UPDATE")
    private String lastUpdate;
    
    @Column(name = "LAST_UPDATE_BY")
    private String lastUpdateBy;
} 