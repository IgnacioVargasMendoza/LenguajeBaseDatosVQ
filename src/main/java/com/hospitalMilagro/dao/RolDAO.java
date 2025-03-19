package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Rol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

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
    
    @Procedure(procedureName = "Insert_Rol")
    void insertRol(
        @Param("p_id_rol") Long idRol,
        @Param("p_nombre") String nombre,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Obtener_Rol")
    void obtenerRol(
        @Param("p_id_rol") Long idRol,
        @Param("p_nombre") String nombre,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Update_Rol")
    void updateRol(
        @Param("p_id_rol") Long idRol,
        @Param("p_nombre") String nombre,
        @Param("p_activo") Integer activo
    );

    @Procedure(procedureName = "Delete_Rol")
    void deleteRol(@Param("p_id_rol") Long idRol);
}



