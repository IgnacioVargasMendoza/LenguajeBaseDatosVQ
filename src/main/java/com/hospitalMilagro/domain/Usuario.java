package com.hospitalMilagro.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.List;
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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_USUARIO")
    private Long idUsuario;

    @Column(name = "NOMBRE")
    private String nombre;
    @Column(name = "PRIMER_APELLIDO")
    private String primerApellido;
    @Column(name = "SEGUNDO_APPELLIDO")
    private String segundoApellido;
    @Column(name = "CORREO")
    private String correo;
    @Column(name = "CONTRASENA")
    private String contrasena;
    @Column(name = "ACTIVO")
    private byte activo;

    // -- Asociasiones con otras Entidades --
    //Relacion con tabla intermedia de UsuarioRol: muchos usuarios pueden tener un mismo rol
    @ManyToMany
    @JoinTable(
            name = "FIDE_USUARIO_ROL_TB",
            joinColumns = @JoinColumn(name = "ID_USUARIO"),
            inverseJoinColumns = @JoinColumn(name = "ID_ROL")
    )
    private List<Rol> roles;

    @OneToOne(mappedBy = "usuario")
    private Paciente paciente;

    @OneToOne(mappedBy = "usuario")
    private Doctores doctor;
    
    @OneToMany(mappedBy = "usuario")
    private List<Notificaciones> notificaciones;

}
