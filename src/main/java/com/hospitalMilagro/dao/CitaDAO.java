package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.Cita;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CitaDAO extends JpaRepository<Cita, Long> {
    
    @Query(value = "{ call FIDE_LISTAR_CITAS_SP() }", nativeQuery = true)
    List<Cita> listarCitas();
    
    @Query(value = "{ call FIDE_LISTAR_CITAS_POR_PACIENTE_SP(:idPaciente) }", nativeQuery = true)
    List<Cita> listarCitasPorPaciente(@Param("idPaciente") Long idPaciente);
    
    @Query(value = "{ call FIDE_LISTAR_CITAS_POR_DOCTOR_SP(:idDoctor) }", nativeQuery = true)
    List<Cita> listarCitasPorDoctor(@Param("idDoctor") Long idDoctor);
    
    @Query(value = "{ call FIDE_LISTAR_CITAS_POR_FECHA_SP(:fecha) }", nativeQuery = true)
    List<Cita> listarCitasPorFecha(@Param("fecha") String fecha);
    
    @Query(value = "{ call FIDE_REGISTRAR_CITA_SP(:idPaciente, :idDoctor, :fechaCita, :horaCita, :motivo, :idEstadoCita) }", nativeQuery = true)
    void registrarCita(
            @Param("idPaciente") Long idPaciente,
            @Param("idDoctor") Long idDoctor,
            @Param("fechaCita") String fechaCita,
            @Param("horaCita") String horaCita,
            @Param("motivo") String motivo,
            @Param("idEstadoCita") Long idEstadoCita);
    
    @Query(value = "{ call FIDE_ACTUALIZAR_CITA_SP(:idCita, :idPaciente, :idDoctor, :fechaCita, :horaCita, :motivo, :idEstadoCita) }", nativeQuery = true)
    void actualizarCita(
            @Param("idCita") Long idCita,
            @Param("idPaciente") Long idPaciente,
            @Param("idDoctor") Long idDoctor,
            @Param("fechaCita") String fechaCita,
            @Param("horaCita") String horaCita,
            @Param("motivo") String motivo,
            @Param("idEstadoCita") Long idEstadoCita);
    
    @Query(value = "{ call FIDE_ELIMINAR_CITA_SP(:idCita) }", nativeQuery = true)
    void eliminarCita(@Param("idCita") Long idCita);
} 