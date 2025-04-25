package com.hospitalMilagro.serviceImpl;

import com.hospitalMilagro.dao.DireccionDAO;
import com.hospitalMilagro.domain.Direccion;
import com.hospitalMilagro.service.DireccionService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.jdbc.core.JdbcTemplate;

@Service
public class DireccionServiceImpl implements DireccionService {

    @Autowired
    private DireccionDAO direccionDAO;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Override
    @Transactional(readOnly=true)
    public List<Direccion> listaDirecciones() {
        List<Direccion> listaDirecciones = direccionDAO.listaDirecciones();
        
        // Completar con nombres de países, cantones y distritos
        for (Direccion direccion : listaDirecciones) {
            completarNombresDireccion(direccion);
        }
        
        return listaDirecciones;
    }
    
    private void completarNombresDireccion(Direccion direccion) {
        // Obtener nombre del país
        String sqlPais = "SELECT NOMBRE FROM FIDE_PAISES_TB WHERE ID_PAIS = ?";
        List<String> nombresPais = jdbcTemplate.queryForList(sqlPais, String.class, direccion.getIdPais());
        if (!nombresPais.isEmpty()) {
            direccion.setNombrePais(nombresPais.get(0));
        }
        
        // Obtener nombre del cantón
        String sqlCanton = "SELECT NOMBRE FROM FIDE_CANTONES_TB WHERE ID_CANTON = ?";
        List<String> nombresCanton = jdbcTemplate.queryForList(sqlCanton, String.class, direccion.getIdCanton());
        if (!nombresCanton.isEmpty()) {
            direccion.setNombreCanton(nombresCanton.get(0));
        }
        
        // Obtener nombre del distrito
        String sqlDistrito = "SELECT NOMBRE FROM FIDE_DISTRITOS_TB WHERE ID_DISTRITO = ?";
        List<String> nombresDistrito = jdbcTemplate.queryForList(sqlDistrito, String.class, direccion.getIdDistrito());
        if (!nombresDistrito.isEmpty()) {
            direccion.setNombreDistrito(nombresDistrito.get(0));
        }
    }
} 