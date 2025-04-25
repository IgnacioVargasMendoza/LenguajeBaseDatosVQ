package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Direccion;
import java.util.List;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DireccionDAO extends CrudRepository<Direccion, Long>{
    
    @Procedure(procedureName = "FIDE_LISTAR_DIRECCIONES_SP", refCursor = true, outputParameterName = "LISTA_DIRECCIONES")
    List<Direccion> listaDirecciones();
} 