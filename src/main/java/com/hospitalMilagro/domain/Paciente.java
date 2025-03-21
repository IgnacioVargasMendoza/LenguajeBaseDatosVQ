package com.hospitalMilagro.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 *
 * @author tanyr
 */
@Data
@Entity
@Table(name = "FIDE_PACIENTE_TB")
public class Paciente implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_PACIENTE",
            nullable = false)
    private Long idPaciente;

    @Column(name = "FECHA_NACIMIENTO",
            nullable = false)
    private Date fechaNacimiento;

    @Column(name = "NUMERO_SEGURO",
            length = 50)
    private String numeroSeguro;

    @Column(name = "TELEFONO",
            length = 15,
            nullable = false)
    private String telefono;

    @Column(name = "ACTIVO",
            nullable = false)
    private short activo;
    
    // -- Asociaciones con otras entidades --
    
    //Relacion con la tabla usuario 1:1
    @OneToOne
    @JoinColumn(
            name = "ID_USUARIO",
            referencedColumnName = "ID_USUARIO",
            insertable = false,
            updatable = false
    )
    private Usuario usuario;

    //--Relacion entre paciente y direccion. N:1 Muchas direcciones pertenecen a un mismo usuario
    @ManyToOne()
    @JoinColumn(name = "ID_DIRECCION",
            referencedColumnName="ID_DIRECCION",
            insertable=true,
            updatable=true)
    private Direccion direccion;

}
