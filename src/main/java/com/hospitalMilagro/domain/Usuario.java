package com.hospitalMilagro.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import lombok.Data;

/**
 *
 * @author Ignac
 */
@Data
@Entity
@Table(name = "FIDE_USUARIOS_TB")
public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "ID_USUARIO")
    private Long idUsuario;

    @Column(name = "NOMBRE")
    private String nombre;
    @Column(name = "PRIMER_APELLIDO")
    private String primerApellido;
    @Column(name = "SEGUNDO_APELLIDO")
    private String segundoApellido;
    @Column(name = "CORREO")
    private String correo;
    @Column(name = "CONTRASENA")
    private String contrasena;
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
    
    @ManyToMany
    @JoinTable(
        name = "FIDE_USUARIO_ROL_TB",
        joinColumns = @JoinColumn(name = "ID_USUARIO"),
        inverseJoinColumns = @JoinColumn(name = "ID_ROL")
    )
    private Set<Rol> roles = new HashSet<>();
}
