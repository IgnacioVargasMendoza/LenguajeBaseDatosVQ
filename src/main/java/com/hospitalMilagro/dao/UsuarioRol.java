
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRol extends JpaRepository<Usuario, Long> {
    /*
    * Aqui estaran la definicion de los procedimientos almacenados, funcion y triggers
    * de la tabla UsuarioRol en la base de datos
    * Ejemplo -> @Procedure(procedureName = "MY_PROCEDURE_WITH_RETURN")
    */
}
