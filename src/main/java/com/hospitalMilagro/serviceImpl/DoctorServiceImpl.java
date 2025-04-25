package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.DoctorDAO;
import com.hospitalMilagro.domain.Direccion;
import com.hospitalMilagro.domain.Doctor;
import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.DireccionService;
import com.hospitalMilagro.service.DoctorService;
import com.hospitalMilagro.service.UsuarioService;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DoctorServiceImpl implements DoctorService{

    @Autowired
    private DoctorDAO doctorDAO;
    
    @Autowired
    private DireccionService direccionService;
    
    @Autowired
    private UsuarioService usuarioService;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Override
    @Transactional(readOnly=true)
    public List<Doctor> listaDoctores(){
        List<Doctor> listaDoctores = doctorDAO.listaDoctores();
        
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
        
        // Completamos la información de cada doctor
        for (Doctor doctor : listaDoctores) {
            // Agregar información de dirección
            if (doctor.getIdDireccion() != null && mapaDirecciones.containsKey(doctor.getIdDireccion())) {
                Direccion dir = mapaDirecciones.get(doctor.getIdDireccion());
                doctor.setDireccionCompleta(dir.getNombrePais() + ", " + dir.getNombreCanton() + ", " + dir.getNombreDistrito());
            }
            
            // Agregar información de usuario
            if (doctor.getIdUsuario() != null && mapaUsuarios.containsKey(doctor.getIdUsuario())) {
                doctor.setNombreUsuario(mapaUsuarios.get(doctor.getIdUsuario()));
            }
        }
        
        return listaDoctores;
    }
    
    @Override
    @Transactional
    public void registrarDoctor(Doctor doctor) {
        doctorDAO.registrarDoctor(
            doctor.getTelefono(),
            doctor.getNumLicencia(),
            doctor.getIdUsuario(),
            doctor.getIdDireccion()
        );
    }
}
