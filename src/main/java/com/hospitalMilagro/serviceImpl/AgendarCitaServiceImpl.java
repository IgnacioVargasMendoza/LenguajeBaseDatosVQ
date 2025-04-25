package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.AgendarCitaDAO;
import com.hospitalMilagro.dao.EstadoCitaDAO;
import com.hospitalMilagro.domain.AgendarCita;
import com.hospitalMilagro.domain.Doctor;
import com.hospitalMilagro.domain.EstadoCita;
import com.hospitalMilagro.domain.Paciente;
import com.hospitalMilagro.service.AgendarCitaService;
import com.hospitalMilagro.service.DoctorService;
import com.hospitalMilagro.service.EstadoCitaService;
import com.hospitalMilagro.service.PacienteService;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AgendarCitaServiceImpl implements AgendarCitaService {
    
    private static final Logger logger = Logger.getLogger(AgendarCitaServiceImpl.class.getName());

    @Autowired
    private AgendarCitaDAO agendarCitaDao;
    
    @Autowired
    private DoctorService doctorService;
    
    @Autowired
    private PacienteService pacienteService;
    
    @Autowired
    private EstadoCitaService estadoCitaService;
    
    @Autowired
    private DataSource dataSource;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Override
    @Transactional
    public void registrarCita(AgendarCita cita) {
        Connection conn = null;
        CallableStatement cs = null;
        
        try {
            // Imprimir valores para depuración
            logger.info("Registrando cita con los siguientes valores:");
            logger.info("Fecha: " + cita.getFecha());
            logger.info("Hora: " + cita.getHoraCita());
            logger.info("Estado: " + cita.getIdEstadoCita());
            logger.info("Doctor: " + cita.getIdDoctor());
            logger.info("Paciente: " + cita.getIdPaciente());
            
            // Verificar que ningún valor sea nulo
            if (cita.getFecha() == null) {
                throw new IllegalArgumentException("La fecha de la cita no puede ser nula");
            }
            if (cita.getHoraCita() == null || cita.getHoraCita().isEmpty()) {
                throw new IllegalArgumentException("La hora de la cita no puede ser nula o vacía");
            }
            if (cita.getIdEstadoCita() == null) {
                throw new IllegalArgumentException("El estado de la cita no puede ser nulo");
            }
            if (cita.getIdDoctor() == null) {
                throw new IllegalArgumentException("El doctor no puede ser nulo");
            }
            if (cita.getIdPaciente() == null) {
                throw new IllegalArgumentException("El paciente no puede ser nulo");
            }
            
            // Formato para la fecha: el procedimiento espera DD/MM/YYYY
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            String fechaStr = dateFormat.format(cita.getFecha());
            logger.info("Fecha formateada: " + fechaStr);
            
            // Usar JDBC nativo para ejecutar el procedimiento almacenado
            conn = dataSource.getConnection();
            cs = conn.prepareCall("{call FIDE_PROGRAMAR_CITA_SP(?, ?, ?, ?, ?)}");
            
            // Establecer parámetros
            cs.setString(1, fechaStr);
            cs.setString(2, cita.getHoraCita());
            cs.setLong(3, cita.getIdEstadoCita());
            cs.setLong(4, cita.getIdDoctor());
            cs.setLong(5, cita.getIdPaciente());
            
            // Ejecutar procedimiento
            logger.info("Ejecutando procedimiento FIDE_PROGRAMAR_CITA_SP...");
            cs.execute();
            logger.info("¡Procedimiento ejecutado correctamente!");
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al registrar cita", e);
            e.printStackTrace();
            throw new RuntimeException("Error al registrar cita: " + e.getMessage(), e);
        } finally {
            try {
                // Cerrar recursos
                if (cs != null) {
                    cs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                logger.log(Level.WARNING, "Error al cerrar recursos", e);
            }
        }
    }
    
    @Override
    @Transactional(readOnly=true)
    public List<AgendarCita> listaCitas() {
        try {
            List<AgendarCita> citas = agendarCitaDao.listaCitas();
            logger.info("Se obtuvieron " + citas.size() + " citas");
            
            // Obtener doctores
            List<Doctor> doctores = doctorService.listaDoctores();
            Map<Long, Doctor> mapaDoctores = new HashMap<>();
            for (Doctor doctor : doctores) {
                mapaDoctores.put(doctor.getIdDoctor(), doctor);
            }
            
            // Obtener pacientes
            List<Paciente> pacientes = pacienteService.listaPacientes();
            Map<Long, Paciente> mapaPacientes = new HashMap<>();
            for (Paciente paciente : pacientes) {
                mapaPacientes.put(paciente.getIdPaciente(), paciente);
            }
            
            // Obtener estados de cita
            List<EstadoCita> estadosCita = estadoCitaService.listaEstadosCita();
            Map<Long, EstadoCita> mapaEstados = new HashMap<>();
            for (EstadoCita estado : estadosCita) {
                mapaEstados.put(estado.getIdEstadoCita(), estado);
            }
            
            // Agregar información adicional a las citas
            for (AgendarCita cita : citas) {
                // Info de doctor
                if (cita.getIdDoctor() != null && mapaDoctores.containsKey(cita.getIdDoctor())) {
                    Doctor doctor = mapaDoctores.get(cita.getIdDoctor());
                    cita.setNombreDoctor(doctor.getNombreUsuario());
                }
                
                // Info de paciente
                if (cita.getIdPaciente() != null && mapaPacientes.containsKey(cita.getIdPaciente())) {
                    Paciente paciente = mapaPacientes.get(cita.getIdPaciente());
                    cita.setNombrePaciente(paciente.getNombreUsuario());
                }
                
                // Info de estado
                if (cita.getIdEstadoCita() != null && mapaEstados.containsKey(cita.getIdEstadoCita())) {
                    EstadoCita estado = mapaEstados.get(cita.getIdEstadoCita());
                    cita.setNombreEstadoCita(estado.getNombreEstado());
                }
            }
            
            return citas;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al listar citas", e);
            e.printStackTrace();
            throw e;
        }
    }
}
