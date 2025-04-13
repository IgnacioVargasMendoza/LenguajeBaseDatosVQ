--cursor para todos los usuarios activos

CREATE OR REPLACE PACKAGE CURSORES_USUARIOS AS
    CURSOR c_usuarios_activos RETURN FIDE_USUARIOS_TB%ROWTYPE;
    PROCEDURE abrir_usuarios_activos;
    PROCEDURE cerrar_usuarios_activos;
END CURSORES_USUARIOS;
/

CREATE OR REPLACE PACKAGE BODY CURSORES_USUARIOS AS
    v_cursor_usuarios_activos SYS_REFCURSOR;
    
    CURSOR c_usuarios_activos RETURN FIDE_USUARIOS_TB%ROWTYPE IS
        SELECT * FROM FIDE_USUARIOS_TB WHERE ACTIVO = 1;
    
    PROCEDURE abrir_usuarios_activos IS
    BEGIN
        OPEN v_cursor_usuarios_activos FOR
        SELECT * FROM FIDE_USUARIOS_TB WHERE ACTIVO = 1;
    END;
    
    PROCEDURE cerrar_usuarios_activos IS
    BEGIN
        IF v_cursor_usuarios_activos%ISOPEN THEN
            CLOSE v_cursor_usuarios_activos;
        END IF;
    END;
END CURSORES_USUARIOS;
/

--cursor para doctores con especialidad

CREATE OR REPLACE PACKAGE CURSORES_DOCTORES AS
    CURSOR c_doctores_especialidad(p_id_especialidad NUMBER) RETURN FIDE_DOCTORES_TB%ROWTYPE;
    PROCEDURE abrir_doctores_especialidad(p_id_especialidad NUMBER);
    PROCEDURE cerrar_doctores_especialidad;
END CURSORES_DOCTORES;
/

CREATE OR REPLACE PACKAGE BODY CURSORES_DOCTORES AS
    v_cursor_doctores SYS_REFCURSOR;
    
    CURSOR c_doctores_especialidad(p_id_especialidad NUMBER) RETURN FIDE_DOCTORES_TB%ROWTYPE IS
        SELECT d.* 
        FROM FIDE_DOCTORES_TB d
        JOIN FIDE_DOCTORES_ESPECIALIDADES_TB de ON d.ID_DOCTOR = de.ID_DOCTOR
        WHERE de.ID_ESPECIALIDAD = p_id_especialidad AND d.ACTIVO = 1;
    
    PROCEDURE abrir_doctores_especialidad(p_id_especialidad NUMBER) IS
    BEGIN
        OPEN v_cursor_doctores FOR
        SELECT d.*, u.NOMBRE, u.PRIMER_APELLIDO, e.NOMBRE AS ESPECIALIDAD
        FROM FIDE_DOCTORES_TB d
        JOIN FIDE_USUARIOS_TB u ON d.ID_USUARIO = u.ID_USUARIO
        JOIN FIDE_DOCTORES_ESPECIALIDADES_TB de ON d.ID_DOCTOR = de.ID_DOCTOR
        JOIN FIDE_ESPECIALIDADES_TB e ON de.ID_ESPECIALIDAD = e.ID_ESPECIALIDAD
        WHERE de.ID_ESPECIALIDAD = p_id_especialidad AND d.ACTIVO = 1;
    END;
    
    PROCEDURE cerrar_doctores_especialidad IS
    BEGIN
        IF v_cursor_doctores%ISOPEN THEN
            CLOSE v_cursor_doctores;
        END IF;
    END;
END CURSORES_DOCTORES;
/

--cursor para citas con fecha

CREATE OR REPLACE PACKAGE CURSORES_CITAS AS
    CURSOR c_citas_fecha(p_fecha DATE) RETURN FIDE_CITAS_TB%ROWTYPE;
    PROCEDURE abrir_citas_fecha(p_fecha DATE);
    PROCEDURE cerrar_citas_fecha;
END CURSORES_CITAS;
/

CREATE OR REPLACE PACKAGE BODY CURSORES_CITAS AS
    v_cursor_citas SYS_REFCURSOR;
    
    CURSOR c_citas_fecha(p_fecha DATE) RETURN FIDE_CITAS_TB%ROWTYPE IS
        SELECT * FROM FIDE_CITAS_TB 
        WHERE TRUNC(FECHA) = TRUNC(p_fecha) AND ACTIVO = 1;
    
    PROCEDURE abrir_citas_fecha(p_fecha DATE) IS
    BEGIN
        OPEN v_cursor_citas FOR
        SELECT c.*, 
               p.NOMBRE AS NOMBRE_PACIENTE,
               d.NOMBRE AS NOMBRE_DOCTOR,
               e.NOMBRE_ESTADO
        FROM FIDE_CITAS_TB c
        JOIN FIDE_PACIENTES_TB pa ON c.ID_PACIENTE = pa.ID_PACIENTE
        JOIN FIDE_USUARIOS_TB p ON pa.ID_USUARIO = p.ID_USUARIO
        JOIN FIDE_DOCTORES_TB doc ON c.ID_DOCTOR = doc.ID_DOCTOR
        JOIN FIDE_USUARIOS_TB d ON doc.ID_USUARIO = d.ID_USUARIO
        JOIN FIDE_ESTADOS_CITAS_TB e ON c.ID_ESTADO_CITA = e.ID_ESTADO_CITA
        WHERE TRUNC(c.FECHA) = TRUNC(p_fecha) AND c.ACTIVO = 1;
    END;
    
    PROCEDURE cerrar_citas_fecha IS
    BEGIN
        IF v_cursor_citas%ISOPEN THEN
            CLOSE v_cursor_citas;
        END IF;
    END;
END CURSORES_CITAS;
/


--cursor para pacientes con tratamientos activos

CREATE OR REPLACE PACKAGE CURSORES_PACIENTES AS
    CURSOR c_pacientes_tratamientos RETURN FIDE_PACIENTES_TB%ROWTYPE;
    PROCEDURE abrir_pacientes_tratamientos;
    PROCEDURE cerrar_pacientes_tratamientos;
END CURSORES_PACIENTES;
/

CREATE OR REPLACE PACKAGE BODY CURSORES_PACIENTES AS
    v_cursor_pacientes SYS_REFCURSOR;
    
    CURSOR c_pacientes_tratamientos RETURN FIDE_PACIENTES_TB%ROWTYPE IS
        SELECT DISTINCT p.*
        FROM FIDE_PACIENTES_TB p
        JOIN FIDE_TRATAMIENTOS_TB t ON p.ID_PACIENTE = t.ID_PACIENTE
        WHERE t.ACTIVO = 1 AND p.ACTIVO = 1;
    
    PROCEDURE abrir_pacientes_tratamientos IS
    BEGIN
        OPEN v_cursor_pacientes FOR
        SELECT p.*, u.NOMBRE, u.PRIMER_APELLIDO, COUNT(t.ID_TRATAMIENTO) AS TOTAL_TRATAMIENTOS
        FROM FIDE_PACIENTES_TB p
        JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
        LEFT JOIN FIDE_TRATAMIENTOS_TB t ON p.ID_PACIENTE = t.ID_PACIENTE AND t.ACTIVO = 1
        WHERE p.ACTIVO = 1
        GROUP BY p.ID_PACIENTE, p.FECHA_NACIMIENTO, p.NUMERO_SEGURO, p.DIRECCION, 
                 p.TELEFONO, p.ID_USUARIO, p.ID_DIRECCION, p.ACTIVO, 
                 u.NOMBRE, u.PRIMER_APELLIDO;
    END;
    
    PROCEDURE cerrar_pacientes_tratamientos IS
    BEGIN
        IF v_cursor_pacientes%ISOPEN THEN
            CLOSE v_cursor_pacientes;
        END IF;
    END;
END CURSORES_PACIENTES;
/

--cursor para medicamentos con stock bajo

CREATE OR REPLACE PACKAGE CURSORES_MEDICAMENTOS AS
    CURSOR c_medicamentos_stock_bajo(p_minimo NUMBER) RETURN FIDE_MEDICAMENTOS_TB%ROWTYPE;
    PROCEDURE abrir_medicamentos_stock_bajo(p_minimo NUMBER);
    PROCEDURE cerrar_medicamentos_stock_bajo;
END CURSORES_MEDICAMENTOS;
/

CREATE OR REPLACE PACKAGE BODY CURSORES_MEDICAMENTOS AS
    v_cursor_medicamentos SYS_REFCURSOR;
    
    CURSOR c_medicamentos_stock_bajo(p_minimo NUMBER) RETURN FIDE_MEDICAMENTOS_TB%ROWTYPE IS
        SELECT m.*
        FROM FIDE_MEDICAMENTOS_TB m
        JOIN FIDE_INVENTARIO_MEDICAMENTOS_TB i ON m.ID_MEDICAMENTO = i.ID_MEDICAMENTO
        WHERE i.CANTIDAD <= p_minimo AND m.ACTIVO = 1;
    
    PROCEDURE abrir_medicamentos_stock_bajo(p_minimo NUMBER) IS
    BEGIN
        OPEN v_cursor_medicamentos FOR
        SELECT m.*, i.CANTIDAD AS STOCK_ACTUAL
        FROM FIDE_MEDICAMENTOS_TB m
        JOIN FIDE_INVENTARIO_MEDICAMENTOS_TB i ON m.ID_MEDICAMENTO = i.ID_MEDICAMENTO
        WHERE i.CANTIDAD <= p_minimo AND m.ACTIVO = 1;
    END;
    
    PROCEDURE cerrar_medicamentos_stock_bajo IS
    BEGIN
        IF v_cursor_medicamentos%ISOPEN THEN
            CLOSE v_cursor_medicamentos;
        END IF;
    END;
END CURSORES_MEDICAMENTOS;
/


--cursor para facturas pendientes de pago

CREATE OR REPLACE PACKAGE CURSORES_FACTURAS AS
    CURSOR c_facturas_pendientes RETURN FIDE_FACTURAS_TB%ROWTYPE;
    PROCEDURE abrir_facturas_pendientes;
    PROCEDURE cerrar_facturas_pendientes;
END CURSORES_FACTURAS;
/

CREATE OR REPLACE PACKAGE BODY CURSORES_FACTURAS AS
    v_cursor_facturas SYS_REFCURSOR;
    
    CURSOR c_facturas_pendientes RETURN FIDE_FACTURAS_TB%ROWTYPE IS
        SELECT * FROM FIDE_FACTURAS_TB 
        WHERE ESTADO_PAGO = 'PENDIENTE' AND ACTIVO = 1;
    
    PROCEDURE abrir_facturas_pendientes IS
    BEGIN
        OPEN v_cursor_facturas FOR
        SELECT f.*, u.NOMBRE || ' ' || u.PRIMER_APELLIDO AS NOMBRE_PACIENTE
        FROM FIDE_FACTURAS_TB f
        JOIN FIDE_PACIENTES_TB p ON f.ID_PACIENTE = p.ID_PACIENTE
        JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
        WHERE f.ESTADO_PAGO = 'PENDIENTE' AND f.ACTIVO = 1;
    END;
    
    PROCEDURE cerrar_facturas_pendientes IS
    BEGIN
        IF v_cursor_facturas%ISOPEN THEN
            CLOSE v_cursor_facturas;
        END IF;
    END;
END CURSORES_FACTURAS;
/


--ejemplos de uso de los cursores


DECLARE
    v_doctor FIDE_DOCTORES_TB%ROWTYPE;
    v_cita FIDE_CITAS_TB%ROWTYPE;
    v_medicamento FIDE_MEDICAMENTOS_TB%ROWTYPE;
BEGIN
    -- Ejemplo 1: Obtener doctores por especialidad
    DBMS_OUTPUT.PUT_LINE('Doctores de Cardiología:');
    FOR doc_rec IN CURSORES_DOCTORES.c_doctores_especialidad(1) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || doc_rec.ID_DOCTOR || ', Licencia: ' || doc_rec.NUMEROL_ICENCIA);
    END LOOP;
    
    -- Ejemplo 2: Obtener citas para hoy
    DBMS_OUTPUT.PUT_LINE('Citas para hoy:');
    CURSORES_CITAS.abrir_citas_fecha(SYSDATE);
    LOOP
        FETCH CURSORES_CITAS.v_cursor_citas INTO v_cita;
        EXIT WHEN CURSORES_CITAS.v_cursor_citas%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Cita ID: ' || v_cita.ID_CITA || ', Hora: ' || v_cita.HORA_CITA);
    END LOOP;
    CURSORES_CITAS.cerrar_citas_fecha;
    
    -- Ejemplo 3: Medicamentos con stock bajo
    DBMS_OUTPUT.PUT_LINE('Medicamentos con stock bajo:');
    CURSORES_MEDICAMENTOS.abrir_medicamentos_stock_bajo(10);
    LOOP
        FETCH CURSORES_MEDICAMENTOS.v_cursor_medicamentos INTO v_medicamento;
        EXIT WHEN CURSORES_MEDICAMENTOS.v_cursor_medicamentos%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Medicamento: ' || v_medicamento.NOMBRE || ', ID: ' || v_medicamento.ID_MEDICAMENTO);
    END LOOP;
    CURSORES_MEDICAMENTOS.cerrar_medicamentos_stock_bajo;
END;
/







--cursor para historial medico de paciente

CREATE OR REPLACE PACKAGE CURSORES_HISTORIAL AS
    CURSOR c_historial_completo(p_id_paciente NUMBER) IS
        SELECT c.ID_CITA, c.FECHA, e.NOMBRE_ESTADO AS ESTADO, 
               d.NOMBRE AS DOCTOR, t.DESCRIPCION AS TRATAMIENTO
        FROM FIDE_CITAS_TB c
        JOIN FIDE_ESTADOS_CITAS_TB e ON c.ID_ESTADO_CITA = e.ID_ESTADO_CITA
        JOIN FIDE_DOCTORES_TB doc ON c.ID_DOCTOR = doc.ID_DOCTOR
        JOIN FIDE_USUARIOS_TB d ON doc.ID_USUARIO = d.ID_USUARIO
        LEFT JOIN FIDE_CITAS_TRATAMIENTOS_TB ct ON c.ID_CITA = ct.ID_CITA
        LEFT JOIN FIDE_TRATAMIENTOS_TB t ON ct.ID_TRATAMIENTO = t.ID_TRATAMIENTO
        WHERE c.ID_PACIENTE = p_id_paciente
        ORDER BY c.FECHA DESC;
END CURSORES_HISTORIAL;
/



--cursor para disponibilidad semanal de doctor

CREATE OR REPLACE PACKAGE CURSORES_DISPONIBILIDAD AS
    CURSOR c_disponibilidad_semanal(p_id_doctor NUMBER) IS
        SELECT DIA, TO_CHAR(HORA_INICIO, 'HH24:MI') AS HORA_INICIO, 
               TO_CHAR(HORA_FIN, 'HH24:MI') AS HORA_FIN
        FROM FIDE_DISPONIBILIDAD_TB
        WHERE ID_DOCTOR = p_id_doctor
        ORDER BY 
            CASE DIA
                WHEN 'LUNES' THEN 1
                WHEN 'MARTES' THEN 2
                WHEN 'MIÉRCOLES' THEN 3
                WHEN 'JUEVES' THEN 4
                WHEN 'VIERNES' THEN 5
                WHEN 'SÁBADO' THEN 6
                WHEN 'DOMINGO' THEN 7
            END, HORA_INICIO;
END CURSORES_DISPONIBILIDAD;
/

--cursor para obtener un usuario en especifico

CREATE OR REPLACE FUNCTION obtener_usuario(p_id_usuario NUMBER) 
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT * FROM FIDE_USUARIOS_TB 
  WHERE ID_USUARIO = p_id_usuario;
  
  RETURN v_cursor;
END;
/


--cursor para todos los doctores activos

CREATE OR REPLACE FUNCTION obtener_doctores_activos 
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT d.*, u.NOMBRE, u.PRIMER_APELLIDO 
  FROM FIDE_DOCTORES_TB d
  JOIN FIDE_USUARIOS_TB u ON d.ID_USUARIO = u.ID_USUARIO
  WHERE d.ACTIVO = 1;
  
  RETURN v_cursor;
END;
/

--cursor para paciente econ datos enteros

CREATE OR REPLACE FUNCTION obtener_paciente_completo(p_id_paciente NUMBER) 
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT p.*, u.*, dir.* 
  FROM FIDE_PACIENTES_TB p
  JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
  JOIN FIDE_DIRECCION_TB dir ON p.ID_DIRECCION = dir.ID_DIRECCION
  WHERE p.ID_PACIENTE = p_id_paciente;
  
  RETURN v_cursor;
END;
/

--cursor para citas de un doctor con fecha especifica

CREATE OR REPLACE FUNCTION obtener_citas_doctor_fecha(
  p_id_doctor NUMBER, 
  p_fecha DATE
) RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT c.*, p.NOMBRE AS NOMBRE_PACIENTE, ec.NOMBRE_ESTADO
  FROM FIDE_CITAS_TB c
  JOIN FIDE_PACIENTES_TB pa ON c.ID_PACIENTE = pa.ID_PACIENTE
  JOIN FIDE_USUARIOS_TB p ON pa.ID_USUARIO = p.ID_USUARIO
  JOIN FIDE_ESTADOS_CITAS_TB ec ON c.ID_ESTADO_CITA = ec.ID_ESTADO_CITA
  WHERE c.ID_DOCTOR = p_id_doctor
  AND TRUNC(c.FECHA) = TRUNC(p_fecha);
  
  RETURN v_cursor;
END;
/

--facturas pendientes de pagar


CREATE OR REPLACE FUNCTION obtener_facturas_pendientes 
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT f.*, u.NOMBRE || ' ' || u.PRIMER_APELLIDO AS PACIENTE
  FROM FIDE_FACTURAS_TB f
  JOIN FIDE_PACIENTES_TB p ON f.ID_PACIENTE = p.ID_PACIENTE
  JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
  WHERE f.ESTADO_PAGO = 'PENDIENTE';
  
  RETURN v_cursor;
END;
/


--disponibilidad de un doctor

CREATE OR REPLACE FUNCTION obtener_disponibilidad_doctor(p_id_doctor NUMBER) 
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT DIA, TO_CHAR(HORA_INICIO, 'HH24:MI') AS HORA_INICIO, 
         TO_CHAR(HORA_FIN, 'HH24:MI') AS HORA_FIN
  FROM FIDE_DISPONIBILIDAD_TB
  WHERE ID_DOCTOR = p_id_doctor
  ORDER BY 
    CASE DIA
      WHEN 'LUNES' THEN 1
      WHEN 'MARTES' THEN 2
      WHEN 'MIÉRCOLES' THEN 3
      WHEN 'JUEVES' THEN 4
      WHEN 'VIERNES' THEN 5
      WHEN 'SÁBADO' THEN 6
      WHEN 'DOMINGO' THEN 7
    END, HORA_INICIO;
  
  RETURN v_cursor;
END;
/


--cursor para costos de una cita

CREATE OR REPLACE FUNCTION obtener_costos_cita(p_id_cita NUMBER) 
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT DESCRIPCION, MONTO
  FROM FIDE_COSTOS_CITA_TB
  WHERE ID_CITA = p_id_cita;
  
  RETURN v_cursor;
END;
/


---pacientes con tratamientos activos

CREATE OR REPLACE FUNCTION obtener_pacientes_tratamientos_activos 
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT DISTINCT p.*, u.NOMBRE, u.PRIMER_APELLIDO
  FROM FIDE_PACIENTES_TB p
  JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
  JOIN FIDE_TRATAMIENTOS_TB t ON p.ID_PACIENTE = t.ID_PACIENTE
  WHERE t.ACTIVO = 1;
  
  RETURN v_cursor;
END;
/


--obtener disponibilidad de doctores segun su especialidad

CREATE OR REPLACE FUNCTION obtener_disponibilidad_especialidad(p_id_especialidad NUMBER)
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT d.ID_DOCTOR,
         u.NOMBRE || ' ' || u.PRIMER_APELLIDO AS DOCTOR,
         dis.DIA,
         TO_CHAR(dis.HORA_INICIO, 'HH24:MI') AS HORA_INICIO,
         TO_CHAR(dis.HORA_FIN, 'HH24:MI') AS HORA_FIN
  FROM FIDE_DOCTORES_TB d
  JOIN FIDE_USUARIOS_TB u ON d.ID_USUARIO = u.ID_USUARIO
  JOIN FIDE_DISPONIBILIDAD_TB dis ON d.ID_DOCTOR = dis.ID_DOCTOR
  JOIN FIDE_DOCTORES_ESPECIALIDADES_TB de ON d.ID_DOCTOR = de.ID_DOCTOR
  WHERE de.ID_ESPECIALIDAD = p_id_especialidad
  AND dis.ACTIVO = 1
  ORDER BY d.ID_DOCTOR, 
    CASE dis.DIA
      WHEN 'LUNES' THEN 1
      WHEN 'MARTES' THEN 2
      WHEN 'MIÉRCOLES' THEN 3
      WHEN 'JUEVES' THEN 4
      WHEN 'VIERNES' THEN 5
      WHEN 'SÁBADO' THEN 6
      WHEN 'DOMINGO' THEN 7
    END, dis.HORA_INICIO;
  
  RETURN v_cursor;
END;
/


--obtener pacientes con facturas vencidas

CREATE OR REPLACE FUNCTION obtener_pacientes_facturas_vencidas
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT p.ID_PACIENTE,
         u.NOMBRE || ' ' || u.PRIMER_APELLIDO AS PACIENTE,
         COUNT(f.ID_FACTURA) AS FACTURAS_VENCIDAS,
         SUM(f.MONTO_TOTAL) AS TOTAL_ADEUDADO
  FROM FIDE_PACIENTES_TB p
  JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
  JOIN FIDE_FACTURAS_TB f ON p.ID_PACIENTE = f.ID_PACIENTE
  WHERE f.ESTADO_PAGO = 'PENDIENTE'
  AND f.FECHA_VENCIMIENTO < SYSDATE
  GROUP BY p.ID_PACIENTE, u.NOMBRE, u.PRIMER_APELLIDO
  ORDER BY TOTAL_ADEUDADO DESC;
  
  RETURN v_cursor;
END;
/


--obtener datos basicos de un doctor

CREATE OR REPLACE FUNCTION obtener_datos_doctor(p_id_doctor NUMBER)
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT d.ID_DOCTOR, u.NOMBRE, u.PRIMER_APELLIDO, d.NUMEROL_ICENCIA, d.TELEFONO
  FROM FIDE_DOCTORES_TB d
  JOIN FIDE_USUARIOS_TB u ON d.ID_USUARIO = u.ID_USUARIO
  WHERE d.ID_DOCTOR = p_id_doctor;
  
  RETURN v_cursor;
END;
/



--tipos de procedimientos disponibles

CREATE OR REPLACE FUNCTION listar_tipos_procedimientos
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT DISTINCT TIPO_PROCEDIMIENTO
  FROM FIDE_PROCEDIMIENTOS_TB
  WHERE ACTIVO = 1
  ORDER BY TIPO_PROCEDIMIENTO;
  
  RETURN v_cursor;
END;
/


--obtener informacion de contacto de doctores

CREATE OR REPLACE FUNCTION obtener_contacto_doctores
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT d.ID_DOCTOR, u.NOMBRE, u.PRIMER_APELLIDO, d.TELEFONO, u.CORREO
  FROM FIDE_DOCTORES_TB d
  JOIN FIDE_USUARIOS_TB u ON d.ID_USUARIO = u.ID_USUARIO
  WHERE d.ACTIVO = 1
  ORDER BY u.PRIMER_APELLIDO, u.NOMBRE;
  
  RETURN v_cursor;
END;
/


--obtener servicios de la clinica

CREATE OR REPLACE FUNCTION obtener_servicios_clinica
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT ID_SERVICIO, NOMBRE, DESCRIPCION
  FROM FIDE_SERVICIO_TB
  WHERE ACTIVO = 1
  ORDER BY NOMBRE;
  
  RETURN v_cursor;
END;
/


--listar medicamentos por precio

CREATE OR REPLACE FUNCTION listar_medicamentos_por_precio(p_precio_min NUMBER, p_precio_max NUMBER)
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT ID_MEDICAMENTO, NOMBRE, PRECIO
  FROM FIDE_MEDICAMENTOS_TB
  WHERE PRECIO BETWEEN p_precio_min AND p_precio_max
  AND ACTIVO = 1
  ORDER BY PRECIO, NOMBRE;
  
  RETURN v_cursor;
END;
/

--obtener citas proximas(hoy y mañana)

CREATE OR REPLACE FUNCTION obtener_citas_proximas
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT c.ID_CITA, 
         TO_CHAR(c.FECHA, 'DD/MM/YYYY') AS FECHA,
         c.HORA_CITA,
         u.NOMBRE || ' ' || u.PRIMER_APELLIDO AS PACIENTE,
         d.NOMBRE || ' ' || d.PRIMER_APELLIDO AS DOCTOR
  FROM FIDE_CITAS_TB c
  JOIN FIDE_PACIENTES_TB p ON c.ID_PACIENTE = p.ID_PACIENTE
  JOIN FIDE_USUARIOS_TB u ON p.ID_USUARIO = u.ID_USUARIO
  JOIN FIDE_DOCTORES_TB doc ON c.ID_DOCTOR = doc.ID_DOCTOR
  JOIN FIDE_USUARIOS_TB d ON doc.ID_USUARIO = d.ID_USUARIO
  WHERE TRUNC(c.FECHA) BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) + 1
  AND c.ACTIVO = 1
  ORDER BY c.FECHA, c.HORA_CITA;
  
  RETURN v_cursor;
END;
/


---listar usuarios por rol

CREATE OR REPLACE FUNCTION listar_usuarios_por_rol(p_id_rol NUMBER)
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT u.ID_USUARIO, u.NOMBRE, u.PRIMER_APELLIDO, u.CORREO
  FROM FIDE_USUARIOS_TB u
  JOIN FIDE_USUARIO_ROL_TB ur ON u.ID_USUARIO = ur.ID_USUARIO
  WHERE ur.ID_ROL = p_id_rol
  AND u.ACTIVO = 1
  ORDER BY u.PRIMER_APELLIDO, u.NOMBRE;
  
  RETURN v_cursor;
END;
/

---obtener resumen de inventario
CREATE OR REPLACE FUNCTION obtener_resumen_inventario
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT 
    COUNT(*) AS TOTAL_MEDICAMENTOS,
    SUM(i.CANTIDAD) AS TOTAL_UNIDADES,
    SUM(i.CANTIDAD * m.PRECIO) AS VALOR_TOTAL,
    MIN(i.CANTIDAD) AS MINIMO_STOCK,
    MAX(i.CANTIDAD) AS MAXIMO_STOCK
  FROM FIDE_MEDICAMENTOS_TB m
  JOIN FIDE_INVENTARIO_MEDICAMENTOS_TB i ON m.ID_MEDICAMENTO = i.ID_MEDICAMENTO
  WHERE m.ACTIVO = 1;
  
  RETURN v_cursor;
END;
/


--resumen de pagos por paciente
CREATE OR REPLACE FUNCTION obtener_resumen_pagos_paciente(p_id_paciente NUMBER)
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT 
    f.ID_FACTURA,
    f.NUMERO_FACTURA,
    TO_CHAR(f.FECHA_EMISION, 'DD/MM/YYYY') AS FECHA_EMISION,
    f.MONTO_TOTAL,
    f.ESTADO_PAGO,
    TO_CHAR(f.FECHA_VENCIMIENTO, 'DD/MM/YYYY') AS FECHA_VENCIMIENTO
  FROM FIDE_FACTURAS_TB f
  WHERE f.ID_PACIENTE = p_id_paciente
  ORDER BY f.FECHA_EMISION DESC;
  
  RETURN v_cursor;
END;
/


--estadisticas de atencion de doctor
CREATE OR REPLACE FUNCTION obtener_estadisticas_atencion_doctor(p_id_doctor NUMBER)
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT 
    TO_CHAR(c.FECHA, 'YYYY-MM') AS MES,
    COUNT(*) AS TOTAL_CITAS,
    SUM(CASE WHEN c.ID_ESTADO_CITA = 3 THEN 1 ELSE 0 END) AS CITAS_COMPLETADAS,
    ROUND(SUM(CASE WHEN c.ID_ESTADO_CITA = 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS PORCENTAJE_EXITO
  FROM FIDE_CITAS_TB c
  WHERE c.ID_DOCTOR = p_id_doctor
  AND c.FECHA >= ADD_MONTHS(SYSDATE, -6)
  GROUP BY TO_CHAR(c.FECHA, 'YYYY-MM')
  ORDER BY TO_CHAR(c.FECHA, 'YYYY-MM');
  
  RETURN v_cursor;
END;
/