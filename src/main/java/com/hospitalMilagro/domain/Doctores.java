package com.hospitalMilagro.domain;

import static com.fasterxml.jackson.databind.util.ClassUtil.name;
import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;

/**
 *
 * @author tanyr
 */
@Data
@Entity
@Table(name = "FIDE_DOCTORES_TB")
public class Doctores implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_DOCTOR", 
            nullable = false)
    private Long idDoctor;

    @Column(name = "TELEFONO", 
            length = 15)
    private String telefono;

    @Column(name = "NUMEROLICENCIA", 
            length = 50, 
            nullable = false,
            unique = true)
    private String numeroLicencia;

    @Column(name = "ID_USUARIO",
            nullable = false, 
            unique = true)
    private Long idUsuario;

    @Column(name = "ACTIVO", 
            nullable = false)
    private short activo;
    
    @ManyToOne
    @JoinColumn(name = "ID_DIRECCION",
            referencedColumnName = "ID_DIRECCION",
            insertable=true,
            updatable=true
            )
    private Direccion direccion;
    
    //Relacion con la tabla usuario 1:1
    @OneToOne
    @JoinColumn(
            name = "ID_USUARIO",
            referencedColumnName = "ID_USUARIO",
            insertable = false,
            updatable = false
    )
    private Usuario usuario;
    
    @OneToMany(mappedBy="doctor")
    private List<Disponibilidad> disponibilidades;
    
    @ManyToMany
    @JoinTable(name = "FIDE_DOCTORES_ESPECIALIDADES_TB",
            joinColumns = @JoinColumn(name="ID_DOCTOR", referencedColumnName="ID_DOCTOR"),
            inverseJoinColumns = @JoinColumn(name ="ID_ESPECIALIDAD", referencedColumnName = "ID_ESPECIALIDAD"))
    private List<Especialidad> especialidades;

}
