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
@Table(name="FIDE_DIRECCION_TB")
public class Direccion implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name="ID_DIRECCION")
    private Long idDireccion;
    
    @Column(name="ID_PAIS")
    private Long idPais;
    
    @Column(name="ID_CANTON")
    private Long idCanton;
    
    @Column(name="ID_DISTRITO")
    private Long idDistrito;
    
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
    
    @Transient
    private String nombrePais;
    
    @Transient
    private String nombreCanton;
    
    @Transient
    private String nombreDistrito;
} 