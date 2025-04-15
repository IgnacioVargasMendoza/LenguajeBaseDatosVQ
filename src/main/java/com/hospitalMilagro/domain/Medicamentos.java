package com.hospitalMilagro.domain;

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
@Table(name = "FIDE_MEDICAMENTOS_TB")
public class Medicamentos implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_MEDICAMENTO", nullable = false)
    private Long idMedicamento;

    @Column(name = "NOMBRE_MEDICAMENTO", length = 20, nullable = false)
    private String nombreMedicamento;

    @Column(name = "DESCRIPTION", length = 50, nullable = false)
    private String descripcion;
    
    @ManyToMany(mappedBy="medicamentos")
    private List<Tratamientos> tratamientos;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;

}
