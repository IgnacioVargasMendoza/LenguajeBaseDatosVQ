package com.hospitalMilagro.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

/**
 *
 * @author tanyr
 */
@Data
@Entity
@Table(name = "FIDE_SERVICIO_ESPECIALIDAD_TB")
public class ServicioEspecialidad implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @ManyToOne
    @JoinColumn(name = "ID_SERVICIO", nullable = false)
    private Servicio servicio;

    @Id
    @ManyToOne
    @JoinColumn(name = "ID_ESPECIALIDAD", nullable = false)
    private Especialidad especialidad;
}
