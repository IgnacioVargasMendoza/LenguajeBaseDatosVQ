
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
@Table(name = "FIDE_TRATAMIENTOS_MEDICAMENTOS_TB")
public class TratamientosMedicamentos implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @ManyToOne
    @JoinColumn(name = "ID_MEDICAMENTO", nullable = false)
    private Medicamentos medicamento;

    @Id
    @ManyToOne
    @JoinColumn(name = "ID_TRATAMIENTO", nullable = false)
    private Tratamientos tratamiento;

}
