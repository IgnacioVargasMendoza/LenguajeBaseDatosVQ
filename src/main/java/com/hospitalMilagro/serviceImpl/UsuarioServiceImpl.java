package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.UsuarioDAO;
import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.UsuarioService;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
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

    @Override
    @Transactional(readOnly = true)
    public List<Usuario> listaUsuarios() {
        List listaUsuarios = usuarioDao.listaUsuarios();
        return listaUsuarios;
    }


}
