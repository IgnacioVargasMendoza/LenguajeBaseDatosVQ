
package com.hospitalMilagro.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.List;
import lombok.Data;

/**
 *
 * @author Ignac
 */
@Data
@Entity
@Table(name ="FIDE_ROL_TB")
public class Rol implements Serializable{
    
        private static final long serialVersionUID = 1L;
        
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name = "ID_ROL")
        private Long idRol;
        @Column(name = "NOMBRE")
        private String nombreRol;
        @Column(name = "ACTIVO")
        private short activo;
        
        @ManyToMany(mappedBy = "roles")
        private List<Usuario> usuarios;
        
}
