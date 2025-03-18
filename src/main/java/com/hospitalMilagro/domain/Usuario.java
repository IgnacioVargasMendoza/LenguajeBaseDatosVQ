
package com.hospitalMilagro.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
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
@Table(name="FIDE_USUARIOS_TB")
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
    @Column(name = "ID_ROL")
    private short id_rol;
    
    //Relacion con tabla intermedia de UsuarioRol: muchos usuarios pueden tener un mismo rol
    @OneToMany
    @JoinColumn(name ="ID_USUARIO", nullable = false)
    private List<UsuarioRol> usuarioRol;
    
}
