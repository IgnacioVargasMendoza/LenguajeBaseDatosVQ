package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Usuario;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface UsuarioDAO extends CrudRepository<Usuario, Long> {
    
    /*
    * Aqui estaran la definicion de los procedimientos almacenados, funcion y triggers
    * de la tabla usuarios en la base de datos
    * Ejemplo -> @Procedure(procedureName = "MY_PROCEDURE_WITH_RETURN")
    */
    @Procedure(procedureName = "FIDE_CREAR_USUARIO_SP")
    void insertUsuario(
        @Param("p_nombre") String nombre,
        @Param("p_primer_apellido") String primerApellido,
        @Param("p_segundo_apellido") String segundoApellido,
        @Param("p_correo") String correo,
        @Param("p_contrasena") String contrasena
    );

    
//    @Procedure(procedureName = "Obtener_Usuario")
//    Usuario obtenerUsuario(@Param("p_id_usuario") Long idUsuario);
//
//    @Procedure(procedureName = "Update_Usuario")
//    void updateUsuario(
//        @Param("p_id_usuario") Long idUsuario,
//        @Param("p_nombre") String nombre,
//        @Param("p_primer_apellido") String primerApellido,
//        @Param("p_segundo_apellido") String segundoApellido,
//        @Param("p_correo") String correo,
//        @Param("p_contrasena") String contrasena,
//        @Param("p_activo") Byte activo
//    );
//
//    @Procedure(procedureName = "Delete_Usuario")
//    void deleteUsuario(@Param("p_id_usuario") Long idUsuario);

}

