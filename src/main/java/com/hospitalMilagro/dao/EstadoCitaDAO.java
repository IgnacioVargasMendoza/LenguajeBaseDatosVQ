package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.EstadoCita;
import java.util.List;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EstadoCitaDAO extends CrudRepository<EstadoCita, Long> {
    
    @Procedure(procedureName = "FIDE_LISTAR_ESTADOS_CITAS_SP", refCursor = true, outputParameterName = "LISTA_ESTADOS_CITAS")
    List<EstadoCita> listaEstadosCita();
} 