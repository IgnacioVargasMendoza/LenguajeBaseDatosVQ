--Procedimiento para actualizar estado de citas vencidas


CREATE OR REPLACE PROCEDURE actualizar_citas_vencidas AS
  -- Cursor explícito para citas pendientes vencidas
  CURSOR c_citas_vencidas IS
    SELECT c.ID_CITA
    FROM FIDE_CITAS_TB c
    JOIN FIDE_ESTADOS_CITAS_TB e ON c.ID_ESTADO_CITA = e.ID_ESTADO_CITA
    WHERE c.FECHA < SYSDATE
    AND e.NOMBRE_ESTADO = 'PENDIENTE';
    
  v_id_estado_vencido NUMBER;
BEGIN
  -- Obtener ID para estado "VENCIDO" (cursor implícito)
  SELECT ID_ESTADO_CITA INTO v_id_estado_vencido
  FROM FIDE_ESTADOS_CITAS_TB
  WHERE NOMBRE_ESTADO = 'VENCIDA';
  
  -- Procesar citas vencidas con cursor explícito
  FOR r_cita IN c_citas_vencidas LOOP
    UPDATE FIDE_CITAS_TB
    SET ID_ESTADO_CITA = v_id_estado_vencido,
        LAST_UPDATE = SYSDATE,
        LAST_UPDATE_BY = USER
    WHERE ID_CITA = r_cita.ID_CITA;
    
    -- Registrar en historial (cursor implícito)
    INSERT INTO FIDE_HISTORIAL_CITAS_TB (
      ID_HISTORIAL, ID_CITA, FECHA_CAMBIO, 
      ID_ESTADO_ANTERIOR, ID_ESTADO_NUEVO, 
      OBSERVACIONES, ACTIVO
    ) VALUES (
      SEQ_HISTORIAL.NEXTVAL, r_cita.ID_CITA, SYSDATE,
      (SELECT ID_ESTADO_CITA FROM FIDE_ESTADOS_CITAS_TB WHERE NOMBRE_ESTADO = 'PENDIENTE'),
      v_id_estado_vencido,
      'Actualización automática por vencimiento', 1
    );
  END LOOP;
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Se actualizaron ' || c_citas_vencidas%ROWCOUNT || ' citas vencidas');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END actualizar_citas_vencidas;
/



--Procedimiento para generar reporte de medicamentos

CREATE OR REPLACE PROCEDURE generar_reporte_medicamentos(
  p_min_stock NUMBER DEFAULT 10
) AS
  -- Cursor explícito para medicamentos con stock bajo
  CURSOR c_medicamentos_bajo_stock IS
    SELECT m.ID_MEDICAMENTO, m.NOMBRE, i.CANTIDAD
    FROM FIDE_MEDICAMENTOS_TB m
    JOIN FIDE_INVENTARIO_MEDICAMENTOS_TB i ON m.ID_MEDICAMENTO = i.ID_MEDICAMENTO
    WHERE i.CANTIDAD <= p_min_stock
    ORDER BY i.CANTIDAD, m.NOMBRE;
    
  v_total_medicamentos NUMBER;
  v_promedio_stock NUMBER;
BEGIN
  -- Obtener estadísticas (cursores implícitos)
  SELECT COUNT(*) INTO v_total_medicamentos
  FROM FIDE_MEDICAMENTOS_TB
  WHERE ACTIVO = 1;
  
  SELECT AVG(CANTIDAD) INTO v_promedio_stock
  FROM FIDE_INVENTARIO_MEDICAMENTOS_TB;
  
  -- Encabezado del reporte
  DBMS_OUTPUT.PUT_LINE('REPORTE DE INVENTARIO DE MEDICAMENTOS');
  DBMS_OUTPUT.PUT_LINE('Fecha: ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY'));
  DBMS_OUTPUT.PUT_LINE('----------------------------------------');
  DBMS_OUTPUT.PUT_LINE('Total medicamentos: ' || v_total_medicamentos);
  DBMS_OUTPUT.PUT_LINE('Promedio stock: ' || ROUND(v_promedio_stock, 2));
  DBMS_OUTPUT.PUT_LINE('Medicamentos con stock bajo (<= ' || p_min_stock || '):');
  
  -- Procesar medicamentos con stock bajo (cursor explícito)
  FOR r_med IN c_medicamentos_bajo_stock LOOP
    DBMS_OUTPUT.PUT_LINE(
      RPAD(r_med.NOMBRE, 40) || 
      RPAD('Stock: ' || r_med.CANTIDAD, 15) ||
      CASE 
        WHEN r_med.CANTIDAD <= 3 THEN 'URGENTE'
        WHEN r_med.CANTIDAD <= 5 THEN 'ALERTA'
        ELSE 'BAJO'
      END
    );
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('Total medicamentos con stock bajo: ' || c_medicamentos_bajo_stock%ROWCOUNT);
END generar_reporte_medicamentos;
/


--Procedimiento para transferir inventario entre ubicaciones

CREATE OR REPLACE PROCEDURE transferir_inventario(
  p_id_medicamento NUMBER,
  p_cantidad NUMBER,
  p_origen NUMBER,
  p_destino NUMBER
) AS
  -- Variables para validación
  v_stock_origen NUMBER;
  v_existe_destino NUMBER := 0;
  
  -- Cursor explícito para registro de inventario destino
  CURSOR c_inventario_destino IS
    SELECT ID_INVENTARIO, CANTIDAD
    FROM FIDE_INVENTARIO_MEDICAMENTOS_TB
    WHERE ID_MEDICAMENTO = p_id_medicamento
    AND ID_UBICACION = p_destino;
    
  r_destino c_inventario_destino%ROWTYPE;
BEGIN
  -- Validar stock en origen (cursor implícito)
  SELECT CANTIDAD INTO v_stock_origen
  FROM FIDE_INVENTARIO_MEDICAMENTOS_TB
  WHERE ID_MEDICAMENTO = p_id_medicamento
  AND ID_UBICACION = p_origen;
  
  IF v_stock_origen < p_cantidad THEN
    RAISE_APPLICATION_ERROR(-20001, 'Stock insuficiente en ubicación origen');
  END IF;
  
  -- Verificar si existe registro en destino (cursor explícito)
  OPEN c_inventario_destino;
  FETCH c_inventario_destino INTO r_destino;
  v_existe_destino := c_inventario_destino%ROWCOUNT;
  CLOSE c_inventario_destino;
  
  -- Actualizar origen (cursor implícito)
  UPDATE FIDE_INVENTARIO_MEDICAMENTOS_TB
  SET CANTIDAD = CANTIDAD - p_cantidad,
      LAST_UPDATE = SYSDATE,
      LAST_UPDATE_BY = USER
  WHERE ID_MEDICAMENTO = p_id_medicamento
  AND ID_UBICACION = p_origen;
  
  -- Actualizar o insertar destino
  IF v_existe_destino > 0 THEN
    UPDATE FIDE_INVENTARIO_MEDICAMENTOS_TB
    SET CANTIDAD = CANTIDAD + p_cantidad,
        LAST_UPDATE = SYSDATE,
        LAST_UPDATE_BY = USER
    WHERE ID_INVENTARIO = r_destino.ID_INVENTARIO;
  ELSE
    INSERT INTO FIDE_INVENTARIO_MEDICAMENTOS_TB (
      ID_INVENTARIO, ID_MEDICAMENTO, ID_UBICACION,
      CANTIDAD, CREATION_DATE, CREATED_BY,
      LAST_UPDATE, LAST_UPDATE_BY, ACCION, ACTIVO
    ) VALUES (
      SEQ_INVENTARIO.NEXTVAL, p_id_medicamento, p_destino,
      p_cantidad, SYSDATE, USER,
      SYSDATE, USER, 'TRANSFERENCIA', 1
    );
  END IF;
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Transferencia realizada con éxito');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: No se encontró el medicamento en la ubicación origen');
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END transferir_inventario;
/


--Procedimiento para consolidar tratamientos por paciente

CREATE OR REPLACE PROCEDURE consolidar_tratamientos_paciente(
  p_id_paciente NUMBER
) AS
  -- Cursor explícito para tratamientos activos del paciente
  CURSOR c_tratamientos IS
    SELECT t.ID_TRATAMIENTO, t.DESCRIPCION, t.FECHA_INICIO, t.FECHA_FIN
    FROM FIDE_TRATAMIENTOS_TB t
    WHERE t.ID_PACIENTE = p_id_paciente
    AND t.ACTIVO = 1
    ORDER BY t.FECHA_INICIO DESC;
    
  -- Cursor explícito anidado para procedimientos de cada tratamiento
  CURSOR c_procedimientos(p_id_tratamiento NUMBER) IS
    SELECT p.NOMBRE_PROCEDIMIENTO
    FROM FIDE_PROCEDIMIENTOS_TB p
    JOIN FIDE_TRATAMIENTOS_PROCEDIMIENTOS_TB tp ON p.ID_PROCEDIMIENTO = tp.ID_PROCEDIMIENTO
    WHERE tp.ID_TRATAMIENTO = p_id_tratamiento;
    
  -- Cursor explícito anidado para medicamentos de cada tratamiento
  CURSOR c_medicamentos(p_id_tratamiento NUMBER) IS
    SELECT m.NOMBRE, tm.DOSIS
    FROM FIDE_MEDICAMENTOS_TB m
    JOIN FIDE_TRATAMIENTOS_MEDICAMENTOS_TB tm ON m.ID_MEDICAMENTO = tm.ID_MEDICAMENTO
    WHERE tm.ID_TRATAMIENTO = p_id_tratamiento;
    
  v_nombre_paciente VARCHAR2(150);
BEGIN
  -- Obtener nombre del paciente (cursor implícito)
  SELECT u.NOMBRE || ' ' || u.PRIMER_APELLIDO INTO v_nombre_paciente
  FROM FIDE_PACIENTES_TB p
  JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
  WHERE p.ID_PACIENTE = p_id_paciente;
  
  DBMS_OUTPUT.PUT_LINE('REPORTE CONSOLIDADO DE TRATAMIENTOS');
  DBMS_OUTPUT.PUT_LINE('Paciente: ' || v_nombre_paciente);
  DBMS_OUTPUT.PUT_LINE('========================================');
  
  -- Recorrer tratamientos (cursor principal)
  FOR r_trat IN c_tratamientos LOOP
    DBMS_OUTPUT.PUT_LINE('TRATAMIENTO #' || r_trat.ID_TRATAMIENTO);
    DBMS_OUTPUT.PUT_LINE('Descripción: ' || r_trat.DESCRIPCION);
    DBMS_OUTPUT.PUT_LINE('Período: ' || TO_CHAR(r_trat.FECHA_INICIO, 'DD/MM/YYYY') || 
                         ' - ' || NVL(TO_CHAR(r_trat.FECHA_FIN, 'DD/MM/YYYY'), 'En curso'));
    
    -- Listar procedimientos (cursor anidado)
    DBMS_OUTPUT.PUT_LINE('Procedimientos:');
    FOR r_proc IN c_procedimientos(r_trat.ID_TRATAMIENTO) LOOP
      DBMS_OUTPUT.PUT_LINE(' - ' || r_proc.NOMBRE_PROCEDIMIENTO);
    END LOOP;
    
    -- Listar medicamentos (cursor anidado)
    DBMS_OUTPUT.PUT_LINE('Medicamentos:');
    FOR r_med IN c_medicamentos(r_trat.ID_TRATAMIENTO) LOOP
      DBMS_OUTPUT.PUT_LINE(' - ' || r_med.NOMBRE || ' (Dosis: ' || r_med.DOSIS || ')');
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('Total tratamientos activos: ' || c_tratamientos%ROWCOUNT);
END consolidar_tratamientos_paciente;
/


--Procedimiento para migrar datos históricos


CREATE OR REPLACE PROCEDURE migrar_historial_citas_antiguas(
  p_anio NUMBER
) AS
  -- Cursor explícito para citas antiguas
  CURSOR c_citas_antiguas IS
    SELECT c.ID_CITA, c.FECHA, c.ID_ESTADO_CITA, c.ID_DOCTOR, c.ID_PACIENTE
    FROM FIDE_CITAS_TB c
    WHERE EXTRACT(YEAR FROM c.FECHA) < p_anio
    AND c.ACTIVO = 1;
    
  -- Contadores
  v_total_migradas NUMBER := 0;
  v_total_errores NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando migración de citas anteriores a ' || p_anio);
  
  -- Procesar cada cita antigua
  FOR r_cita IN c_citas_antiguas LOOP
    BEGIN
      -- Insertar en tabla histórica (cursor implícito)
      INSERT INTO FIDE_HISTORIAL_CITAS_TB (
        ID_HISTORIAL, ID_CITA, FECHA_CAMBIO,
        ID_ESTADO_ANTERIOR, ID_ESTADO_NUEVO,
        OBSERVACIONES, ACTIVO
      ) VALUES (
        SEQ_HISTORIAL.NEXTVAL, r_cita.ID_CITA, SYSDATE,
        r_cita.ID_ESTADO_CITA, r_cita.ID_ESTADO_CITA,
        'Migración histórica de datos', 1
      );
      
      -- Marcar como inactiva en tabla original (cursor implícito)
      UPDATE FIDE_CITAS_TB
      SET ACTIVO = 0,
          LAST_UPDATE = SYSDATE,
          LAST_UPDATE_BY = USER,
          ACCION = 'MIGRADO A HISTÓRICO'
      WHERE ID_CITA = r_cita.ID_CITA;
      
      v_total_migradas := v_total_migradas + 1;
      
      -- Commit cada 100 registros
      IF MOD(v_total_migradas, 100) = 0 THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Migradas ' || v_total_migradas || ' citas...');
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        v_total_errores := v_total_errores + 1;
        DBMS_OUTPUT.PUT_LINE('Error migrando cita ' || r_cita.ID_CITA || ': ' || SQLERRM);
    END;
  END LOOP;
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Migración completada');
  DBMS_OUTPUT.PUT_LINE('Total citas migradas: ' || v_total_migradas);
  DBMS_OUTPUT.PUT_LINE('Total errores: ' || v_total_errores);
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error en migración: ' || SQLERRM);
END migrar_historial_citas_antiguas;
/