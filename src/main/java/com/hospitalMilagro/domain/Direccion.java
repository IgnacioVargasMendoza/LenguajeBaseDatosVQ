
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
@Table(name = "FIDE_DIRECCION_TB")
public class Direccion implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_DIRECCION", nullable = false)
    private Long idDireccion;

    @Column(name = "PAIS", length = 30, nullable = false)
    private String pais;

    @Column(name = "CANTON", length = 30, nullable = false)
    private String canton;

    @Column(name = "DISTRITO", length = 30, nullable = false)
    private String distrito;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;

}
