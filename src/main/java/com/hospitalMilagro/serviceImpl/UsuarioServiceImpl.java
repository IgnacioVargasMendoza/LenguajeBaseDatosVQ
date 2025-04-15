package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.UsuarioDAO;
import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.UsuarioService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsuarioServiceImpl implements UsuarioService {
    
    @Autowired
    private UsuarioDAO usuarioDao;

    @Override
    @Transactional
    public void insertarUsuario(Usuario usuario) {
        usuarioDao.insertUsuario(
            usuario.getNombre(),
            usuario.getPrimerApellido(),
            usuario.getSegundoApellido(),
            usuario.getCorreo(),
            usuario.getContrasena()
        );
    }

    /*
    @Override
    public Usuario obtenerUsuario(Long idUsuario) {
        return usuarioDao.obtenerUsuario(idUsuario);
    }

    @Override
    @Transactional
    public void actualizarUsuario(Usuario usuario) {
        // Obtener la fecha actual
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fechaActual = now.format(formatter);
        
        // Actualizar campos de auditoría
        usuario.setLastUpdate(fechaActual);
        usuario.setLastUpdateBy("SYSTEM");
        usuario.setAccion("UPDATE");
        
        // Llamar al procedimiento almacenado
        usuarioDao.updateUsuario(
            usuario.getIdUsuario(),
            usuario.getNombre(),
            usuario.getPrimerApellido(),
            usuario.getSegundoApellido(),
            usuario.getCorreo(),
            usuario.getContrasena(),
            usuario.getActivo()
        );
    }

    @Override
    @Transactional
    public void eliminarUsuario(Long idUsuario) {
        usuarioDao.deleteUsuario(idUsuario);
    }*/
}
