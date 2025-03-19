/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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

    @Column(name = "MENSAJE", length = 1000, nullable = false)
    private String mensaje;

    @Column(name = "TIPO", length = 20, nullable = false)
    private String tipo;

    @Column(name = "ACTIVO", nullable = false)
    private Short activo;

    @Column(name = "CREATED_BY", length = 100)
    private String createdBy;

    @Column(name = "CREATION_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;

    @Column(name = "LAST_UPDATE_BY", length = 100)
    private String lastUpdateBy;

    @Column(name = "LAST_UPDATE_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastUpdateDate;

}
