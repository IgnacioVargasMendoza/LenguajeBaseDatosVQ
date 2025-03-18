package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Rol;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author Ignac
 */
public interface RolDAO extends JpaRepository<Rol, Long>{
    /*
    * Aqui estaran la definicion de los procedimientos almacenados, funcion y triggers
    * de la tabla Rol en la base de datos
    * Ejemplo -> @Procedure(procedureName = "MY_PROCEDURE_WITH_RETURN")
    */
}
