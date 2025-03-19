/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hospitalMilagro.dao;

import com.hospitalMilagro.domain.HistorialTratamientos;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author tanyr
 */
public interface HistorialTratamientosDAO extends JpaRepository<HistorialTratamientos, Long> {
    
}
