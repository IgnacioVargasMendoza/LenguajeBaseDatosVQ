package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.UsuarioDAO;
import com.hospitalMilagro.domain.Usuario;
import com.hospitalMilagro.service.UsuarioService;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.sql.Types;

@Service
public class UsuarioServiceImpl implements UsuarioService {
    
    @Autowired
    private UsuarioDAO usuarioDao;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;

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
    
    @Override
    @Transactional(readOnly = true)
    public Usuario autenticarUsuario(String nombre, String contrasena) {
        try {
            // Configurar la llamada a procedimiento almacenado
            SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                    .withProcedureName("FIDE_AUTENTICAR_USUARIO_SP")
                    .declareParameters(
                            new SqlParameter("p_nombre", Types.VARCHAR),
                            new SqlParameter("p_contrasena", Types.VARCHAR),
                            new SqlOutParameter("p_usuario_id", Types.NUMERIC),
                            new SqlOutParameter("p_existe", Types.NUMERIC)
                    );
            
            // Parámetros de entrada
            Map<String, Object> inParams = new HashMap<>();
            inParams.put("p_nombre", nombre);
            inParams.put("p_contrasena", contrasena);
            
            // Ejecutar el procedimiento
            Map<String, Object> result = jdbcCall.execute(inParams);
            
            // Obtener los resultados
            Object usuarioIdObj = result.get("p_usuario_id");
            Object existeObj = result.get("p_existe");
            
            Integer existe = (existeObj != null) ? ((Number)existeObj).intValue() : 0;
            
            if (existe != null && existe == 1 && usuarioIdObj != null) {
                Long usuarioId = ((Number)usuarioIdObj).longValue();
                // Si el usuario existe, buscar por ID
                return usuarioDao.findById(usuarioId).orElse(null);
            }
        } catch (Exception e) {
            System.err.println("Error al autenticar usuario: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
}
