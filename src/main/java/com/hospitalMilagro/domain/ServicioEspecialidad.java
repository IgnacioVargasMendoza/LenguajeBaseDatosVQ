package com.hospitalMilagro.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

/**
 *
 * @author tanyr
 */
@Data
@Entity
@Table(name = "FIDE_SERVICIO_ESPECIALIDAD_TB")
public class ServicioEspecialidad {

    @ManyToOne
    @JoinColumn(name = "ID_SERVICIO", nullable = false)
    private Servicio servicio;

    @ManyToOne
    @JoinColumn(name = "ID_ESPECIALIDAD", nullable = false)
    private Especialidades especialidad;
}
