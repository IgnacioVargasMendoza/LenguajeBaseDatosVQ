package com.hospitalMilagro.service;

import com.hospitalMilagro.domain.Usuario;
import java.util.List;

 
/*
    Definicion de los metodos que se utilizaran en la BD
*/

public interface UsuarioService {
    
    public void insertarUsuario(Usuario usuario);
    
    public List<Usuario> listaUsuarios();
    
    /**
     * Método para autenticar un usuario con su nombre y contraseña
     * @param nombre El nombre del usuario
     * @param contrasena La contraseña del usuario
     * @return El usuario autenticado o null si las credenciales son inválidas
     */
    public Usuario autenticarUsuario(String nombre, String contrasena);
    
    
//    public Usuario obtenerUsuario(Long idUsuario);
    
//    public void actualizarUsuario(Usuario usuario);
    
//    public void eliminarUsuario(Long idUsuario);
}
