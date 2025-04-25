package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.PacienteDAO;
import com.hospitalMilagro.domain.Direccion;
import com.hospitalMilagro.domain.Paciente;
import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.DireccionService;
import com.hospitalMilagro.service.PacienteService;
import com.hospitalMilagro.service.UsuarioService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PacienteServiceImpl implements PacienteService {

    @Autowired
    private PacienteDAO pacienteDAO;
    
    @Autowired
    private DireccionService direccionService;
    
    @Autowired
    private UsuarioService usuarioService;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Override
    @Transactional(readOnly=true)
    public List<Paciente> listaPacientes() {
        List<Paciente> listaPacientes = pacienteDAO.listaPacientes();
        
        // Obtenemos las direcciones
        List<Direccion> direcciones = direccionService.listaDirecciones();
        Map<Long, Direccion> mapaDirecciones = new HashMap<>();
        for (Direccion dir : direcciones) {
            mapaDirecciones.put(dir.getIdDireccion(), dir);
        }
        
        // Obtenemos los usuarios
        List<Usuario> usuarios = usuarioService.listaUsuarios();
        Map<Long, String> mapaUsuarios = new HashMap<>();
        for (Usuario usr : usuarios) {
            mapaUsuarios.put(usr.getIdUsuario(), usr.getNombre() + " " + usr.getPrimerApellido() + " " + usr.getSegundoApellido());
        }
        
        // Completamos la información de cada paciente
        for (Paciente paciente : listaPacientes) {
            // Agregar información de dirección
            if (paciente.getIdDireccion() != null && mapaDirecciones.containsKey(paciente.getIdDireccion())) {
                Direccion dir = mapaDirecciones.get(paciente.getIdDireccion());
                paciente.setDireccionCompleta(dir.getNombrePais() + ", " + dir.getNombreCanton() + ", " + dir.getNombreDistrito());
            }
            
            // Agregar información de usuario
            if (paciente.getIdUsuario() != null && mapaUsuarios.containsKey(paciente.getIdUsuario())) {
                paciente.setNombreUsuario(mapaUsuarios.get(paciente.getIdUsuario()));
            }
        }
        
        return listaPacientes;
    }
    
    @Override
    @Transactional
    public void registrarPaciente(Paciente paciente) {
        // Usamos el jdbcTemplate para tener más control sobre los parámetros
        String procedimiento = "{call FIDE_REGISTRAR_PACIENTE_SP(?, ?, ?, ?, ?, ?)}";
        jdbcTemplate.update(procedimiento,
            paciente.getFechaNacimiento(),
            paciente.getNumeroSeguro(),
            paciente.getDireccion(), // Dirección textual
            paciente.getTelefono(),
            paciente.getIdUsuario(),
            paciente.getIdDireccion()
        );
    }
} 