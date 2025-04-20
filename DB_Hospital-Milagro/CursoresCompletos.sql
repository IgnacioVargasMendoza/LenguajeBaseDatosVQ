--IMPLICITOS



-- 1. Actualizar contraseñas temporales para usuarios inactivos
CREATE OR REPLACE PROCEDURE reset_pass_inactivos AS
BEGIN
    UPDATE FIDE_USUARIOS_TB 
    SET CONTRASENA = 'Temp_' || TO_CHAR(SYSDATE, 'YYYYMMDD')
    WHERE ACTIVO = 0;
    DBMS_OUTPUT.PUT_LINE('Contraseñas actualizadas: ' || SQL%ROWCOUNT);
END;
/

-- 2. Eliminar usuarios sin roles asignados
CREATE OR REPLACE PROCEDURE eliminar_usuarios_sin_rol AS
BEGIN
    DELETE FROM FIDE_USUARIOS_TB 
    WHERE ID_USUARIO NOT IN (SELECT ID_USUARIO FROM FIDE_USUARIO_ROL_TB);
    DBMS_OUTPUT.PUT_LINE('Usuarios eliminados: ' || SQL%ROWCOUNT);
END;
/




-- 3. Actualizar licencias temporales para doctores nuevos
CREATE OR REPLACE PROCEDURE actualizar_licencias_temp AS
BEGIN
    UPDATE FIDE_DOCTORES_TB 
    SET NUMEROL_ICENCIA = 'TEMP_' || ID_DOCTOR
    WHERE NUMEROL_ICENCIA IS NULL;
END;
/

-- 4. Desactivar doctores sin citas en los últimos 6 meses
CREATE OR REPLACE PROCEDURE desactivar_doctores_inactivos AS
BEGIN
    UPDATE FIDE_DOCTORES_TB 
    SET ACTIVO = 0
    WHERE ID_DOCTOR NOT IN (
        SELECT DISTINCT ID_DOCTOR FROM FIDE_CITAS_TB 
        WHERE FECHA > ADD_MONTHS(SYSDATE, -6)
    );
END;
/



-- 5. Asignar dirección genérica a pacientes sin dirección
CREATE OR REPLACE PROCEDURE asignar_direccion_default AS
BEGIN
    UPDATE FIDE_PACIENTES_TB 
    SET DIRECCION = 'Dirección no especificada'
    WHERE DIRECCION IS NULL;
END;
/

-- 6. Actualizar teléfonos en formato estándar
CREATE OR REPLACE PROCEDURE estandarizar_telefonos AS
BEGIN
    UPDATE FIDE_PACIENTES_TB 
    SET TELEFONO = REGEXP_REPLACE(TELEFONO, '[^0-9]', '')
    WHERE TELEFONO IS NOT NULL;
END;
/



-- 7. Cancelar citas pendientes con más de 30 días
CREATE OR REPLACE PROCEDURE cancelar_citas_antiguas AS
BEGIN
    UPDATE FIDE_CITAS_TB 
    SET ID_ESTADO_CITA = 3 -- Cancelado
    WHERE FECHA < SYSDATE - 30
    AND ID_ESTADO_CITA = 1; -- Pendiente
END;
/

-- 8. Generar notificaciones para citas próximas
CREATE OR REPLACE PROCEDURE notificar_citas_proximas AS
BEGIN
    INSERT INTO FIDE_NOTIFICACIONES_TB (
        ID_NOTIFICACION, MENSAJE, TIPO, ID_USUARIO, 
        CREATION_DATE, CREATED_BY, LAST_UPDATE, 
        LAST_UPDATE_BY, ACCION, ACTIVO
    )
    SELECT 
        SEQ_NOTIF.NEXTVAL, 
        'Cita programada para ' || TO_CHAR(c.FECHA, 'DD/MM/YYYY'), 
        'RECORDATORIO', 
        p.ID_USUARIO,
        SYSDATE, 
        'SISTEMA', 
        SYSDATE, 
        'SISTEMA', 
        'INSERT', 
        1
    FROM FIDE_CITAS_TB c
    JOIN FIDE_PACIENTES_TB p ON c.ID_PACIENTE = p.ID_PACIENTE
    WHERE c.FECHA BETWEEN SYSDATE AND SYSDATE + 2;
END;
/



-- 9. Aplicar recargo a facturas vencidas
CREATE OR REPLACE PROCEDURE aplicar_recargo_mora AS
BEGIN
    UPDATE FIDE_FACTURAS_TB 
    SET MONTO_TOTAL = MONTO_TOTAL * 1.05 -- 5% recargo
    WHERE FECHA_VENCIMIENTO < SYSDATE
    AND ESTADO_PAGO = 'PENDIENTE';
END;
/

-- 10. Cerrar facturas pagadas hace más de 2 años
CREATE OR REPLACE PROCEDURE archivar_facturas_antiguas AS
BEGIN
    UPDATE FIDE_FACTURAS_TB 
    SET ACTIVO = 0
    WHERE ESTADO_PAGO = 'PAGADO'
    AND FECHA_EMISION < ADD_MONTHS(SYSDATE, -24);
END;
/


-- 11. Actualizar precios de medicamentos con aumento del 3%
CREATE OR REPLACE PROCEDURE actualizar_precios_medicamentos AS
BEGIN
    UPDATE FIDE_MEDICAMENTOS_TB 
    SET PRECIO = PRECIO * 1.03;
END;
/

-- 12. Desactivar medicamentos sin stock
CREATE OR REPLACE PROCEDURE desactivar_medicamentos_sin_stock AS
BEGIN
    UPDATE FIDE_MEDICAMENTOS_TB 
    SET ACTIVO = 0
    WHERE ID_MEDICAMENTO IN (
        SELECT ID_MEDICAMENTO FROM FIDE_INVENTARIO_MEDICAMENTOS_TB 
        WHERE CANTIDAD = 0
    );
END;
/


-- 13. Normalizar nombres de países a mayúsculas
CREATE OR REPLACE PROCEDURE normalizar_nombres_paises AS
BEGIN
    UPDATE FIDE_PAISES_TB 
    SET NOMBRE = UPPER(NOMBRE);
END;
/

-- 14. Eliminar distritos sin direcciones asociadas
CREATE OR REPLACE PROCEDURE eliminar_distritos_no_usados AS
BEGIN
    DELETE FROM FIDE_DISTRITOS_TB 
    WHERE ID_DISTRITO NOT IN (
        SELECT ID_DISTRITO FROM FIDE_DIRECCION_TB
    );
END;
/


-- 15. Agregar prefijo a especialidades médicas
CREATE OR REPLACE PROCEDURE prefijar_especialidades AS
BEGIN
    UPDATE FIDE_ESPECIALIDADES_TB 
    SET NOMBRE = 'MED-' || NOMBRE;
END;
/

-- 16. Actualizar descripciones vacías
CREATE OR REPLACE PROCEDURE actualizar_descripciones_vacias AS
BEGIN
    UPDATE FIDE_ESPECIALIDADES_TB 
    SET DESCRIPCION = 'Descripción no disponible'
    WHERE DESCRIPCION IS NULL;
END;
/


-- 17. Finalizar tratamientos antiguos
CREATE OR REPLACE PROCEDURE finalizar_tratamientos_antiguos AS
BEGIN
    UPDATE FIDE_TRATAMIENTOS_TB 
    SET ACTIVO = 0
    WHERE FECHA_FIN < SYSDATE;
END;
/

-- 18. Asignar observación a tratamientos sin descripción
CREATE OR REPLACE PROCEDURE completar_descripciones_tratamientos AS
BEGIN
    UPDATE FIDE_TRATAMIENTOS_TB 
    SET DESCRIPCION = 'Tratamiento general'
    WHERE DESCRIPCION IS NULL;
END;
/



-- 19. Eliminar notificaciones antiguas
CREATE OR REPLACE PROCEDURE purgar_notificaciones_antiguas AS
BEGIN
    DELETE FROM FIDE_NOTIFICACIONES_TB 
    WHERE CREATION_DATE < ADD_MONTHS(SYSDATE, -6);
END;
/

-- 20. Marcar como inactivas notificaciones leídas
CREATE OR REPLACE PROCEDURE desactivar_notificaciones_leidas AS
BEGIN
    UPDATE FIDE_NOTIFICACIONES_TB 
    SET ACTIVO = 0
    WHERE TIPO = 'LEIDA';
END;
/



--EXPLICITOS


-- 21. Listar doctores y sus especialidades
CREATE OR REPLACE PROCEDURE reporte_doctores_especialidades AS
    CURSOR c_doctores IS
        SELECT d.ID_DOCTOR, u.NOMBRE, u.PRIMER_APELLIDO, e.NOMBRE AS ESPECIALIDAD
        FROM FIDE_DOCTORES_TB d
        JOIN FIDE_USUARIOS_TB u ON d.ID_USUARIO = u.ID_USUARIO
        JOIN FIDE_DOCTORES_ESPECIALIDADES_TB de ON d.ID_DOCTOR = de.ID_DOCTOR
        JOIN FIDE_ESPECIALIDADES_TB e ON de.ID_ESPECIALIDAD = e.ID_ESPECIALIDAD;
BEGIN
    FOR r IN c_doctores LOOP
        DBMS_OUTPUT.PUT_LINE(
            r.NOMBRE || ' ' || r.PRIMER_APELLIDO || 
            ' - Especialidad: ' || r.ESPECIALIDAD
        );
    END LOOP;
END;
/

-- 22. Mostrar pacientes con tratamientos activos
CREATE OR REPLACE PROCEDURE reporte_pacientes_tratamientos AS
    CURSOR c_pacientes IS
        SELECT p.ID_PACIENTE, u.NOMBRE, u.PRIMER_APELLIDO, COUNT(t.ID_TRATAMIENTO) AS TOTAL
        FROM FIDE_PACIENTES_TB p
        JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
        LEFT JOIN FIDE_TRATAMIENTOS_TB t ON p.ID_PACIENTE = t.ID_PACIENTE
        WHERE t.ACTIVO = 1 OR t.ID_TRATAMIENTO IS NULL
        GROUP BY p.ID_PACIENTE, u.NOMBRE, u.PRIMER_APELLIDO;
BEGIN
    FOR r IN c_pacientes LOOP
        DBMS_OUTPUT.PUT_LINE(
            r.NOMBRE || ' ' || r.PRIMER_APELLIDO || 
            ': ' || r.TOTAL || ' tratamientos activos'
        );
    END LOOP;
END;
/



-- 23. Verificar inventario bajo de medicamentos
CREATE OR REPLACE PROCEDURE verificar_inventario_bajo AS
    CURSOR c_medicamentos IS
        SELECT m.NOMBRE, i.CANTIDAD
        FROM FIDE_MEDICAMENTOS_TB m
        JOIN FIDE_INVENTARIO_MEDICAMENTOS_TB i ON m.ID_MEDICAMENTO = i.ID_MEDICAMENTO
        WHERE i.CANTIDAD < 5;
BEGIN
    FOR r IN c_medicamentos LOOP
        DBMS_OUTPUT.PUT_LINE(
            'ALERTA: ' || r.NOMBRE || ' tiene solo ' || 
            r.CANTIDAD || ' unidades en stock'
        );
    END LOOP;
END;
/

-- 24. Validar direcciones incompletas
CREATE OR REPLACE PROCEDURE validar_direcciones AS
    CURSOR c_direcciones IS
        SELECT d.ID_DIRECCION, p.NOMBRE AS PAIS, c.NOMBRE AS CANTON
        FROM FIDE_DIRECCION_TB d
        JOIN FIDE_PAISES_TB p ON d.ID_PAIS = p.ID_PAIS
        JOIN FIDE_CANTONES_TB c ON d.ID_CANTON = c.ID_CANTON
        WHERE d.ID_DISTRITO IS NULL;
BEGIN
    FOR r IN c_direcciones LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Dirección ID ' || r.ID_DIRECCION || 
            ' en ' || r.CANTON || ', ' || r.PAIS || ' no tiene distrito'
        );
    END LOOP;
END;
/


-- 25. Calcular promedio de citas por paciente
CREATE OR REPLACE PROCEDURE estadisticas_citas_paciente AS
    CURSOR c_pacientes IS
        SELECT p.ID_PACIENTE, u.NOMBRE, COUNT(c.ID_CITA) AS TOTAL_CITAS
        FROM FIDE_PACIENTES_TB p
        JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
        LEFT JOIN FIDE_CITAS_TB c ON p.ID_PACIENTE = c.ID_PACIENTE
        GROUP BY p.ID_PACIENTE, u.NOMBRE;
    v_promedio NUMBER;
BEGIN
    SELECT AVG(TOTAL_CITAS) INTO v_promedio
    FROM (
        SELECT COUNT(ID_CITA) AS TOTAL_CITAS
        FROM FIDE_CITAS_TB
        GROUP BY ID_PACIENTE
    );
    
    DBMS_OUTPUT.PUT_LINE('Promedio de citas por paciente: ' || v_promedio);
    
    FOR r IN c_pacientes LOOP
        IF r.TOTAL_CITAS > v_promedio THEN
            DBMS_OUTPUT.PUT_LINE(
                r.NOMBRE || ' supera el promedio con ' || 
                r.TOTAL_CITAS || ' citas'
            );
        END IF;
    END LOOP;
END;
/

-- 26. Top 5 medicamentos más utilizados
CREATE OR REPLACE PROCEDURE top_medicamentos_usados AS
    CURSOR c_medicamentos IS
        SELECT m.NOMBRE, COUNT(tm.ID_TRATAMIENTO) AS USOS
        FROM FIDE_MEDICAMENTOS_TB m
        JOIN FIDE_TRATAMIENTOS_MEDICAMENTOS_TB tm ON m.ID_MEDICAMENTO = tm.ID_MEDICAMENTO
        GROUP BY m.NOMBRE
        ORDER BY USOS DESC
        FETCH FIRST 5 ROWS ONLY;
BEGIN
    DBMS_OUTPUT.PUT_LINE('TOP 5 MEDICAMENTOS MÁS USADOS');
    DBMS_OUTPUT.PUT_LINE('------------------------------');
    FOR r IN c_medicamentos LOOP
        DBMS_OUTPUT.PUT_LINE(r.NOMBRE || ': ' || r.USOS || ' usos');
    END LOOP;
END;
/


-- 27. Reasignar pacientes a doctores con menos carga
CREATE OR REPLACE PROCEDURE balancear_carga_doctores AS
    CURSOR c_doctores IS
        SELECT d.ID_DOCTOR, COUNT(c.ID_CITA) AS CITAS
        FROM FIDE_DOCTORES_TB d
        LEFT JOIN FIDE_CITAS_TB c ON d.ID_DOCTOR = c.ID_DOCTOR
        WHERE c.FECHA > ADD_MONTHS(SYSDATE, -1)
        GROUP BY d.ID_DOCTOR
        ORDER BY CITAS;
    v_min_citas NUMBER;
    v_max_citas NUMBER;
BEGIN
    SELECT MIN(CITAS), MAX(CITAS) INTO v_min_citas, v_max_citas
    FROM (
        SELECT COUNT(ID_CITA) AS CITAS
        FROM FIDE_CITAS_TB
        WHERE FECHA > ADD_MONTHS(SYSDATE, -1)
        GROUP BY ID_DOCTOR
    );
    
    DBMS_OUTPUT.PUT_LINE('Citas mínimas: ' || v_min_citas || ', máximas: ' || v_max_citas);
    
    FOR r IN c_doctores LOOP
        IF r.CITAS > v_min_citas + 5 THEN
            DBMS_OUTPUT.PUT_LINE(
                'Doctor ID ' || r.ID_DOCTOR || 
                ' tiene ' || r.CITAS || ' citas (necesita reducción)'
            );
        END IF;
    END LOOP;
END;
/



-- 28. Buscar pacientes por nombre (con parámetro)
CREATE OR REPLACE PROCEDURE buscar_paciente(p_nombre IN VARCHAR2) AS
    CURSOR c_pacientes IS
        SELECT p.ID_PACIENTE, u.NOMBRE, u.PRIMER_APELLIDO
        FROM FIDE_PACIENTES_TB p
        JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
        WHERE UPPER(u.NOMBRE) LIKE '%' || UPPER(p_nombre) || '%';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Resultados para: ' || p_nombre);
    FOR r IN c_pacientes LOOP
        DBMS_OUTPUT.PUT_LINE(
            r.ID_PACIENTE || ': ' || 
            r.NOMBRE || ' ' || r.PRIMER_APELLIDO
        );
    END LOOP;
END;
/

-- 29. Generar reporte de citas por rango de fechas
CREATE OR REPLACE PROCEDURE reporte_citas_rango(
    p_fecha_inicio IN DATE,
    p_fecha_fin IN DATE
) AS
    CURSOR c_citas IS
        SELECT c.ID_CITA, u.NOMBRE AS PACIENTE, d.ID_DOCTOR, c.FECHA
        FROM FIDE_CITAS_TB c
        JOIN FIDE_PACIENTES_TB p ON c.ID_PACIENTE = p.ID_PACIENTE
        JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
        JOIN FIDE_DOCTORES_TB d ON c.ID_DOCTOR = d.ID_DOCTOR
        WHERE c.FECHA BETWEEN p_fecha_inicio AND p_fecha_fin;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Citas entre ' || p_fecha_inicio || ' y ' || p_fecha_fin);
    FOR r IN c_citas LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Cita #' || r.ID_CITA || ': ' || 
            r.PACIENTE || ' con Doctor ID ' || 
            r.ID_DOCTOR || ' el ' || r.FECHA
        );
    END LOOP;
END;
/



-- 30. Transferir pacientes entre doctores
CREATE OR REPLACE PROCEDURE transferir_pacientes(
    p_doctor_origen IN NUMBER,
    p_doctor_destino IN NUMBER
) AS
    CURSOR c_citas IS
        SELECT ID_CITA FROM FIDE_CITAS_TB
        WHERE ID_DOCTOR = p_doctor_origen
        AND FECHA > SYSDATE;
BEGIN
    FOR r IN c_citas LOOP
        UPDATE FIDE_CITAS_TB 
        SET ID_DOCTOR = p_doctor_destino
        WHERE ID_CITA = r.ID_CITA;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Citas transferidas: ' || c_citas%ROWCOUNT);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--31. Reasignar Citas de un Paciente a Otro Doctor

CREATE OR REPLACE PROCEDURE reasignar_citas_paciente(
    p_id_paciente IN NUMBER,
    p_nuevo_doctor IN NUMBER
) AS
    CURSOR c_citas IS
        SELECT ID_CITA FROM FIDE_CITAS_TB
        WHERE ID_PACIENTE = p_id_paciente
        AND FECHA > SYSDATE;
BEGIN
    FOR r IN c_citas LOOP
        UPDATE FIDE_CITAS_TB 
        SET ID_DOCTOR = p_nuevo_doctor
        WHERE ID_CITA = r.ID_CITA;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Citas reasignadas: ' || c_citas%ROWCOUNT);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


--32. Listar Medicamentos con Stock Crítico (<5 unidades)

CREATE OR REPLACE PROCEDURE listar_medicamentos_stock_critico AS
    CURSOR c_medicamentos IS
        SELECT m.NOMBRE, i.CANTIDAD
        FROM FIDE_MEDICAMENTOS_TB m
        JOIN FIDE_INVENTARIO_MEDICAMENTOS_TB i ON m.ID_MEDICAMENTO = i.ID_MEDICAMENTO
        WHERE i.CANTIDAD < 5
        ORDER BY i.CANTIDAD;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== MEDICAMENTOS CON STOCK CRÍTICO ===');
    FOR r IN c_medicamentos LOOP
        DBMS_OUTPUT.PUT_LINE(r.NOMBRE || ' - Stock: ' || r.CANTIDAD);
    END LOOP;
END;
/

--33. Generar Reporte de Facturas Pendientes por Paciente

CREATE OR REPLACE PROCEDURE reporte_facturas_pendientes AS
    CURSOR c_pacientes IS
        SELECT p.ID_PACIENTE, u.NOMBRE, u.PRIMER_APELLIDO, 
               COUNT(f.ID_FACTURA) AS FACTURAS_PENDIENTES,
               SUM(f.MONTO_TOTAL) AS TOTAL_DEUDA
        FROM FIDE_PACIENTES_TB p
        JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
        JOIN FIDE_FACTURAS_TB f ON p.ID_PACIENTE = f.ID_PACIENTE
        WHERE f.ESTADO_PAGO = 'PENDIENTE'
        GROUP BY p.ID_PACIENTE, u.NOMBRE, u.PRIMER_APELLIDO;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== FACTURAS PENDIENTES POR PACIENTE ===');
    FOR r IN c_pacientes LOOP
        DBMS_OUTPUT.PUT_LINE(
            r.NOMBRE || ' ' || r.PRIMER_APELLIDO || 
            ' - Facturas pendientes: ' || r.FACTURAS_PENDIENTES ||
            ', Deuda total: $' || r.TOTAL_DEUDA
        );
    END LOOP;
END;
/

-- 34. Calcular Promedio de Citas por Doctor

CREATE OR REPLACE PROCEDURE promedio_citas_doctor AS
    CURSOR c_doctores IS
        SELECT d.ID_DOCTOR, u.NOMBRE, u.PRIMER_APELLIDO, 
               COUNT(c.ID_CITA) AS TOTAL_CITAS
        FROM FIDE_DOCTORES_TB d
        JOIN FIDE_USUARIOS_TB u ON d.ID_USUARIO = u.ID_USUARIO
        LEFT JOIN FIDE_CITAS_TB c ON d.ID_DOCTOR = c.ID_DOCTOR
        WHERE c.FECHA > ADD_MONTHS(SYSDATE, -3)
        GROUP BY d.ID_DOCTOR, u.NOMBRE, u.PRIMER_APELLIDO;
    v_promedio NUMBER;
BEGIN
    SELECT AVG(TOTAL_CITAS) INTO v_promedio
    FROM (
        SELECT COUNT(ID_CITA) AS TOTAL_CITAS
        FROM FIDE_CITAS_TB
        WHERE FECHA > ADD_MONTHS(SYSDATE, -3)
        GROUP BY ID_DOCTOR
    );
    
    DBMS_OUTPUT.PUT_LINE('=== PROMEDIO DE CITAS POR DOCTOR (ÚLTIMOS 3 MESES) ===');
    DBMS_OUTPUT.PUT_LINE('Promedio general: ' || v_promedio);
    
    FOR r IN c_doctores LOOP
        IF r.TOTAL_CITAS > v_promedio THEN
            DBMS_OUTPUT.PUT_LINE(
                'Dr. ' || r.NOMBRE || ' ' || r.PRIMER_APELLIDO || 
                ' - Citass: ' || r.TOTAL_CITAS || ' (Sobre el promedio)'
            );
        END IF;
    END LOOP;
END;
/


--35. Buscar Citas por Fecha y Especialidad


CREATE OR REPLACE PROCEDURE buscar_citas_por_fecha_especialidad(
    p_fecha IN DATE,
    p_especialidad IN VARCHAR2
) AS
    CURSOR c_citas IS
        SELECT c.ID_CITA, u_pac.NOMBRE AS PACIENTE, u_doc.NOMBRE AS DOCTOR, c.HORA_CITA
        FROM FIDE_CITAS_TB c
        JOIN FIDE_PACIENTES_TB p ON c.ID_PACIENTE = p.ID_PACIENTE
        JOIN FIDE_USUARIOS_TB u_pac ON p.ID_USUARIO = u_pac.ID_USUARIO
        JOIN FIDE_DOCTORES_TB d ON c.ID_DOCTOR = d.ID_DOCTOR
        JOIN FIDE_USUARIOS_TB u_doc ON d.ID_USUARIO = u_doc.ID_USUARIO
        JOIN FIDE_DOCTORES_ESPECIALIDADES_TB de ON d.ID_DOCTOR = de.ID_DOCTOR
        JOIN FIDE_ESPECIALIDADES_TB e ON de.ID_ESPECIALIDAD = e.ID_ESPECIALIDAD
        WHERE TRUNC(c.FECHA) = TRUNC(p_fecha)
        AND UPPER(e.NOMBRE) LIKE '%' || UPPER(p_especialidad) || '%';
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== CITAS PARA ' || p_fecha || ' EN ' || p_especialidad || ' ===');
    FOR r IN c_citas LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Cita #' || r.ID_CITA || ': ' || 
            r.PACIENTE || ' con Dr. ' || r.DOCTOR || 
            ' a las ' || r.HORA_CITA
        );
    END LOOP;
END;
/


--36. Actualizar Precios de Medicamentos por Porcentaje

CREATE OR REPLACE PROCEDURE actualizar_precios_medicamentos_porcentaje(
    p_porcentaje IN NUMBER
) AS
    CURSOR c_medicamentos IS
        SELECT ID_MEDICAMENTO, PRECIO 
        FROM FIDE_MEDICAMENTOS_TB
        FOR UPDATE;
BEGIN
    FOR r IN c_medicamentos LOOP
        UPDATE FIDE_MEDICAMENTOS_TB
        SET PRECIO = PRECIO * (1 + (p_porcentaje/100))
        WHERE CURRENT OF c_medicamentos;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Precios actualizados: ' || c_medicamentos%ROWCOUNT);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


--37. Listar Tratamientos con sus Procedimientos

CREATE OR REPLACE PROCEDURE listar_tratamientos_procedimientos AS
    CURSOR c_tratamientos IS
        SELECT t.ID_TRATAMIENTO, p.NOMBRE AS PACIENTE, 
               LISTAGG(pr.NOMBRE_PROCEDIMIENTO, ', ') WITHIN GROUP (ORDER BY pr.NOMBRE_PROCEDIMIENTO) AS PROCEDIMIENTOS
        FROM FIDE_TRATAMIENTOS_TB t
        JOIN FIDE_PACIENTES_TB pa ON t.ID_PACIENTE = pa.ID_PACIENTE
        JOIN FIDE_USUARIOS_TB p ON pa.ID_USUARIO = p.ID_USUARIO
        LEFT JOIN FIDE_TRATAMIENTOS_PROCEDIMIENTOS_TB tp ON t.ID_TRATAMIENTO = tp.ID_TRATAMIENTO
        LEFT JOIN FIDE_PROCEDIMIENTOS_TB pr ON tp.ID_PROCEDIMIENTO = pr.ID_PROCEDIMIENTO
        GROUP BY t.ID_TRATAMIENTO, p.NOMBRE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TRATAMIENTOS Y SUS PROCEDIMIENTOS ===');
    FOR r IN c_tratamientos LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Tratamiento #' || r.ID_TRATAMIENTO || 
            ' - Paciente: ' || r.PACIENTE || 
            ' - Procedimientos: ' || r.PROCEDIMIENTOS
        );
    END LOOP;
END;
/

--38. Verificar Disponibilidad de Doctores

CREATE OR REPLACE PROCEDURE verificar_disponibilidad_doctores AS
    CURSOR c_doctores IS
        SELECT d.ID_DOCTOR, u.NOMBRE, u.PRIMER_APELLIDO, 
               COUNT(di.ID_DISPONIBILIDAD) AS HORARIOS_DISPONIBLES
        FROM FIDE_DOCTORES_TB d
        JOIN FIDE_USUARIOS_TB u ON d.ID_USUARIO = u.ID_USUARIO
        LEFT JOIN FIDE_DISPONIBILIDAD_TB di ON d.ID_DOCTOR = di.ID_DOCTOR
        WHERE di.ACTIVO = 1
        GROUP BY d.ID_DOCTOR, u.NOMBRE, u.PRIMER_APELLIDO;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== DISPONIBILIDAD DE DOCTORES ===');
    FOR r IN c_doctores LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Dr. ' || r.NOMBRE || ' ' || r.PRIMER_APELLIDO || 
            ' - Horarios disponibles: ' || r.HORARIOS_DISPONIBLES
        );
    END LOOP;
END;
/



--39. Generar Resumen Mensual de Citas

CREATE OR REPLACE PROCEDURE resumen_mensual_citas(
    p_mes IN NUMBER,
    p_anio IN NUMBER
) AS
    CURSOR c_resumen IS
        SELECT 
            TO_CHAR(c.FECHA, 'DD') AS DIA,
            COUNT(c.ID_CITA) AS TOTAL_CITAS,
            SUM(co.MONTO) AS INGRESOS
        FROM FIDE_CITAS_TB c
        LEFT JOIN FIDE_COSTOS_CITA_TB co ON c.ID_CITA = co.ID_CITA
        WHERE EXTRACT(MONTH FROM c.FECHA) = p_mes
        AND EXTRACT(YEAR FROM c.FECHA) = p_anio
        GROUP BY TO_CHAR(c.FECHA, 'DD')
        ORDER BY DIA;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== RESUMEN MENSUAL DE CITAS (' || p_mes || '/' || p_anio || ') ===');
    DBMS_OUTPUT.PUT_LINE('DÍA   CITAS   INGRESOS');
    DBMS_OUTPUT.PUT_LINE('-----------------------');
    FOR r IN c_resumen LOOP
        DBMS_OUTPUT.PUT_LINE(
            RPAD(r.DIA, 5) || ' ' ||
            RPAD(r.TOTAL_CITAS, 7) || ' ' ||
            '$' || r.INGRESOS
        );
    END LOOP;
END;
/


--40. Migrar Datos de Direcciones Antiguas


CREATE OR REPLACE PROCEDURE migrar_direcciones_antiguas AS
    CURSOR c_direcciones_viejas IS
        SELECT ID_DIRECCION, DIRECCION 
        FROM FIDE_PACIENTES_TB
        WHERE ID_DIRECCION IS NULL
        FOR UPDATE;
BEGIN
    FOR r IN c_direcciones_viejas LOOP
        INSERT INTO FIDE_DIRECCION_TB (
            ID_DIRECCION, ID_PAIS, ID_CANTON, ID_DISTRITO,
            CREATION_DATE, CREATED_BY, LAST_UPDATE, 
            LAST_UPDATE_BY, ACCION, ACTIVO
        ) VALUES (
            SEQ_DIRECCION.NEXTVAL, 1, 1, 1, -- IDs por defecto (ajustar según tu DB)
            SYSDATE, 'MIGRACION', SYSDATE, 
            'MIGRACION', 'INSERT', 1
        ) RETURNING ID_DIRECCION INTO v_nueva_direccion;
        
        UPDATE FIDE_PACIENTES_TB
        SET ID_DIRECCION = v_nueva_direccion
        WHERE CURRENT OF c_direcciones_viejas;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Direcciones migradas: ' || c_direcciones_viejas%ROWCOUNT);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--Taer los usuarios de la BD
CREATE OR REPLACE PROCEDURE FIDE_LISTAR_USUARIOS_SP(
    LISTA_USUARIOS OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN LISTA_USUARIOS FOR SELECT ID_USUARIO, NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO, 
                                CORREO, ACTIVO 
    FROM FIDE_USUARIOS_TB;
END;
var LISTA_USUARIOS REFCURSOR;
EXEC FIDE_LISTAR_USUARIOS_SP(:LISTA_USUARIOS);
PRINT LISTA_USUARIOS;


SELECT * FROM FIDE_USUARIOS_TB
/