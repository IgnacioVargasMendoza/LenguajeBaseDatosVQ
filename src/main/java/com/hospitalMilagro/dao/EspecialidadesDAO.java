package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Especialidades;
import java.util.List;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface EspecialidadesDAO extends CrudRepository<Especialidades, Long>{
    
    @Procedure(procedureName="FIDE_AGREGAR_ESPECIALIDAD_SP")
    void insertarEspecialidad(
        @Param("p_nombre") String nombre,
        @Param("p_descripcion") String descripcion
    );
    
    @Procedure(procedureName = "FIDE_LISTAR_ESPECIALIDADES_SP" , refCursor = true, outputParameterName = "LISTA_ESPECIALIDADES")
    List<Especialidades> listaEspecialidades();
    
}
