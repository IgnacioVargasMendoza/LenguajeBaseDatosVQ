package com.hospitalMilagro.service;

import com.hospitalMilagro.domain.Usuario;
import java.util.List;

 
/*
    Definicion de los metodos que se utilizaran en la BD
*/

public interface UsuarioService {
    
    public void insertarUsuario(Usuario usuario);
    
    public List<Usuario> listaUsuarios();
    
    
    public Usuario autenticarUsuario(String nombre, String contrasena);
    
    
//    public Usuario obtenerUsuario(Long idUsuario);
    
//    public void actualizarUsuario(Usuario usuario);
    
//    public void eliminarUsuario(Long idUsuario);
}
