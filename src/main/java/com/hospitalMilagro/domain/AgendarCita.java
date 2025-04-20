package com.hospitalMilagro.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

@Data
@Entity
@Table(name="FIDE_CITAS_TB")
public class AgendarCita implements Serializable{
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "ID_CITA")
    private Long idCita;
    
    @Column(name="FECHA")
    private Date fecha;
    @Column(name="HORA_CITA")
    private String horaCita;
    @Column(name="ID_ESTADO_CITA")
    private Long idEstadoCita;
    @Column(name="ID_DOCTOR")
    private Long idDoctor;
    @Column(name="ID_PACIENTE")
    private Long idPaciente;
    @Column(name = "CREATION_DATE")
    private String creationDate;
    @Column(name = "CREATED_BY")
    private String createdBy;
    @Column(name = "LAST_UPDATE")
    private String lastUpdate;
    @Column(name = "LAST_UPDATE_BY")
    private String lastUpdateBy;
    
    @Column(name = "ACCION")
    private String accion;
    
    @Column(name = "ACTIVO")
    private byte activo;
}
