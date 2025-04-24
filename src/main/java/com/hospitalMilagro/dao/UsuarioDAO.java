package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Usuario;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface UsuarioDAO extends CrudRepository<Usuario, Long> {
    
    /*
    * Aqui estaran la definicion de los procedimientos almacenados y funciones
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
    
    @Procedure(procedureName = "FIDE_LISTAR_USUARIOS_SP" , refCursor = true, outputParameterName = "LISTA_USUARIOS")
    List<Usuario> listaUsuarios();
 
    /**
     * Método para autenticar un usuario mediante procedimiento almacenado
     * @param nombre Nombre del usuario
     * @param contrasena Contraseña del usuario
     */
    @Procedure(name = "autenticarUsuario", procedureName = "FIDE_AUTENTICAR_USUARIO_SP")
    void autenticarUsuario(
        @Param("p_nombre") String nombre,
        @Param("p_contrasena") String contrasena,
        @Param("p_usuario_id") Object usuarioId,
        @Param("p_existe") Object existe
    );
    
}

