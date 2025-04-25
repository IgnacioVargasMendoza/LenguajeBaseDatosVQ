package com.hospitalMilagro.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

@Data
@Entity
@Table(name="FIDE_PACIENTES_TB")
public class Paciente implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name="ID_PACIENTE")
    private Long idPaciente;
    
    @Column(name="FECHA_NACIMIENTO")
    private Date fechaNacimiento;
    
    @Column(name="NUMERO_SEGURO")
    private String numeroSeguro;
    
    @Column(name="DIRECCION")
    private String direccion;
    
    @Column(name="TELEFONO")
    private String telefono;
    
    @Column(name="ID_USUARIO")
    private Long idUsuario;
    
    @Column(name="ID_DIRECCION")
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
    
    @Transient
    private String nombreUsuario;
    
    @Transient
    private String direccionCompleta;
} 