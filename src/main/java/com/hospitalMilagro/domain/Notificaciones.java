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
@Table(name = "FIDE_NOTIFICACIONES_TB")
public class Notificaciones implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_NOTIFICACION")
    private Long idNotificacion;

    @Column(name = "MENSAJE",
            length = 1000,
            nullable = false)
    private String mensaje;

    @Column(name = "TIPO", length = 20, nullable = false)
    private String tipo;

    @Column(name = "FECHA_ENVIO", length = 100)
    private Date fechaEnvio;
    
    @Column(name = "ACTIVO", nullable = false)
    private Short activo;
    
    @ManyToOne
    @JoinColumn(name = "ID_USUARIO",
            referencedColumnName = "ID_USUARIO",
            insertable=false,
            updatable=false,
            nullable=false)
    private Usuario usuario;

}
