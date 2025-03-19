
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Ignac
 */
public interface UsuarioDAO extends JpaRepository<Usuario, Long> {
    
    /*
    * Aqui estaran la definicion de los procedimientos almacenados, funcion y triggers
    * de la tabla usuarios en la base de datos
    * Ejemplo -> @Procedure(procedureName = "MY_PROCEDURE_WITH_RETURN")
    */
  @Procedure(procedureName = "Insert_Usuario")
    void insertUsuario(
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_nombre") String nombre,
        @Param("p_primer_apellido") String primerApellido,
        @Param("p_segundo_apellido") String segundoApellido,
        @Param("p_correo") String correo,
        @Param("p_contrasena") String contrasena,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Usuario")
    void obtenerUsuario(
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_nombre") String nombre,
        @Param("p_primer_apellido") String primerApellido,
        @Param("p_segundo_apellido") String segundoApellido,
        @Param("p_correo") String correo,
        @Param("p_contrasena") String contrasena,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Usuario")
    void updateUsuario(
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_nombre") String nombre,
        @Param("p_primer_apellido") String primerApellido,
        @Param("p_segundo_apellido") String segundoApellido,
        @Param("p_correo") String correo,
        @Param("p_contrasena") String contrasena,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Usuario")
    void deleteUsuario(@Param("p_id_usuario") Long idUsuario);
}

