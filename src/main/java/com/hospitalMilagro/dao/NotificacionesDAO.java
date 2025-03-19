/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Notificaciones;
import java.util.Date;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author tanyr
 */
public interface NotificacionesDAO extends JpaRepository<Notificaciones, Long> {
    
    @Procedure(procedureName = "Insert_Notificacion")
    void insertNotificacion(
        @Param("p_id_notificacion") Long idNotificacion,
        @Param("p_mensaje") String mensaje,
        @Param("p_tipo") String tipo,
        @Param("p_fecha_envio") Date fechaEnvio,
        @Param("p_activo") Integer activo,
        @Param("p_id_usuario") Long idUsuario
    );

    @Procedure(procedureName = "Obtener_Notificacion")
    void obtenerNotificacion(
        @Param("p_id_notificacion") Long idNotificacion,
        @Param("p_mensaje") String mensaje,
        @Param("p_tipo") String tipo,
        @Param("p_fecha_envio") Date fechaEnvio,
        @Param("p_activo") Integer activo,
        @Param("p_id_usuario") Long idUsuario
    );

    @Procedure(procedureName = "Update_Notificacion")
    void updateNotificacion(
        @Param("p_id_notificacion") Long idNotificacion,
        @Param("p_mensaje") String mensaje,
        @Param("p_tipo") String tipo,
        @Param("p_fecha_envio") Date fechaEnvio,
        @Param("p_activo") Integer activo,
        @Param("p_id_usuario") Long idUsuario
    );

    @Procedure(procedureName = "Delete_Notificacion")
    void deleteNotificacion(@Param("p_id_notificacion") Long idNotificacion);
}
    

