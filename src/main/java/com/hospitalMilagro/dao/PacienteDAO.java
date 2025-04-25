package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Paciente;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface PacienteDAO extends CrudRepository<Paciente, Long> {
    
    @Procedure(procedureName = "FIDE_LISTAR_PACIENTES_SP", refCursor = true, outputParameterName = "LISTA_PACIENTES")
    List<Paciente> listaPacientes();
    
    @Procedure(procedureName = "FIDE_REGISTRAR_PACIENTE_SP")
    void registrarPaciente(
        @Param("p_fecha_nacimiento") Date fechaNacimiento,
        @Param("p_numero_seguro") String numeroSeguro,
        @Param("p_telefono") String telefono,
        @Param("p_id_usuario") Long idUsuario,
        @Param("p_id_direccion") Long idDireccion
    );
} 