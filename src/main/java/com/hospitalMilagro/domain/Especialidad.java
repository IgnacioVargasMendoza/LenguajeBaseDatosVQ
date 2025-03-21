package com.hospitalMilagro.domain;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.List;
import lombok.Data;

/**
 *
 * @author tanyr
 */
@Data
@Entity
@Table(name = "FIDE_ESPECIALIDADES_TB")
public class Especialidad {
    

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_ESPECIALIDAD", nullable = false)
    private Long idEspecialidad;

    @Column(name = "NOMBRE", nullable = false, length = 50)
    private String nombre;

    @Column(name = "DESCRIPCION", length = 2000)
    private String descripcion;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;

    // Relación con DoctorEspecialidad (muchos a muchos con Doctor)
    @ManyToMany(mappedBy = "especialidades", 
            cascade = CascadeType.ALL)
    private List<Doctores> doctores;

    // Relación con ServicioEspecialidad (muchos a muchos con Servicio)
    @OneToMany(mappedBy = "especialidad", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ServicioEspecialidad> servicios;

    // Relación con Subespecialidad (uno a muchos)
    @OneToMany(mappedBy = "especialidad", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<SubEspecialidad> subespecialidades;
}

