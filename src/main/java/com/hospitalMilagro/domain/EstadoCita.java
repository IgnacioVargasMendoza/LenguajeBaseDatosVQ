package com.hospitalMilagro.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import java.io.Serializable;
import lombok.Data;

@Data
@Entity
@Table(name="FIDE_ESTADOS_CITAS_TB")
public class EstadoCita implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name="ID_ESTADO_CITA")
    private Long idEstadoCita;
    
    @Column(name="NOMBRE_ESTADO")
    private String nombreEstado;
    
    @Column(name = "CREATION_DATE")
    private String creationDate;
    
    @Column(name = "CREATED_BY")
    private String createdBy;
    
    @Column(name = "LAST_UPDATE")
    private String lastUpdate;
    
    @Column(name = "LAST_UPDATE_BY")
    private String lastUpdateBy;
    
    @Transient
    private String accion;
    
    @Column(name = "ACTIVO")
    private byte activo;
} 