package com.hospitalMilagro.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Data;


@Data
@Entity
@Table(name="FIDE_DOCTORES_TB")
public class Doctor {
    
    @Id
    @Column (name="ID_DOCTOR")
    private Long idDoctor;
    
    @Column (name="TELEFONO")
    private String telefono;
    @Column (name="NUMEROL_LICENCIA")
    private String numLicencia;
    @Column (name="ID_USUARIO")
    private Long idUsuario;
    @Column (name="ID_DIRECCION")
    private Long idDireccion;
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
