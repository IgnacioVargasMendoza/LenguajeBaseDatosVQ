-- 1. Función para autenticación (login)
CREATE OR REPLACE FUNCTION AUTENTICAR_USUARIO(
    p_correo IN VARCHAR2,
    p_contrasena IN VARCHAR2
) RETURN NUMBER
AS
    v_id_usuario NUMBER;
    v_activo NUMBER;
BEGIN
    SELECT ID_USUARIO, ACTIVO INTO v_id_usuario, v_activo
    FROM FIDE_USUARIOS_TB
    WHERE CORREO = p_correo
    AND CONTRASENA = p_contrasena;
    
    IF v_activo = 1 THEN
        RETURN v_id_usuario;
    ELSE
        RETURN -1; -- Usuario inactivo
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Credenciales incorrectas
    WHEN OTHERS THEN
        RETURN -2; -- Error inesperado
END AUTENTICAR_USUARIO;
/

-- 2. Función para verificar si un correo ya existe
CREATE OR REPLACE FUNCTION CORREO_EXISTE(
    p_correo IN VARCHAR2
) RETURN NUMBER
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM FIDE_USUARIOS_TB
    WHERE CORREO = p_correo;
    
    RETURN v_count;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END CORREO_EXISTE;
/

-- 3. Función para obtener el rol de un usuario
CREATE OR REPLACE FUNCTION OBTENER_ROL_USUARIO(
    p_id_usuario IN NUMBER
) RETURN VARCHAR2
AS
    v_rol VARCHAR2(50);
BEGIN
    SELECT r.NOMBRE INTO v_rol
    FROM FIDE_ROL_TB r
    JOIN FIDE_USUARIO_ROL_TB ur ON r.ID_ROL = ur.ID_ROL
    WHERE ur.ID_USUARIO = p_id_usuario
    AND r.ACTIVO = 1;
    
    RETURN v_rol;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Sin rol asignado';
    WHEN OTHERS THEN
        RETURN 'Error al obtener rol';
END OBTENER_ROL_USUARIO;
/


-- 4. Función para contar pacientes por doctor
CREATE OR REPLACE FUNCTION CONTAR_PACIENTES_POR_DOCTOR(
    p_id_doctor IN NUMBER
) RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT COUNT(DISTINCT c.ID_PACIENTE) INTO v_total
    FROM FIDE_CITAS_TB c
    WHERE c.ID_DOCTOR = p_id_doctor
    AND c.ACTIVO = 1;
    
    RETURN v_total;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END CONTAR_PACIENTES_POR_DOCTOR;
/

-- 5. Función para obtener información básica de doctor
CREATE OR REPLACE FUNCTION OBTENER_INFO_DOCTOR(
    p_id_doctor IN NUMBER
) RETURN VARCHAR2
AS
    v_info VARCHAR2(500);
BEGIN
    SELECT 'Dr. ' || u.NOMBRE || ' ' || u.PRIMER_APELLIDO || 
           ', Especialidad: ' || e.NOMBRE || 
           ', Licencia: ' || d.NUMEROL_ICENCIA
    INTO v_info
    FROM FIDE_DOCTORES_TB d
    JOIN FIDE_USUARIOS_TB u ON d.ID_USUARIO = u.ID_USUARIO
    JOIN FIDE_DOCTORES_ESPECIALIDADES_TB de ON d.ID_DOCTOR = de.ID_DOCTOR
    JOIN FIDE_ESPECIALIDADES_TB e ON de.ID_ESPECIALIDAD = e.ID_ESPECIALIDAD
    WHERE d.ID_DOCTOR = p_id_doctor
    AND d.ACTIVO = 1
    AND ROWNUM = 1;
    
    RETURN v_info;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Doctor no encontrado';
    WHEN OTHERS THEN
        RETURN 'Error al obtener información';
END OBTENER_INFO_DOCTOR;
/

-- 6. Función para verificar si un paciente tiene seguro
CREATE OR REPLACE FUNCTION PACIENTE_TIENE_SEGURO(
    p_id_paciente IN NUMBER
) RETURN NUMBER
AS
    v_seguro VARCHAR2(50);
BEGIN
    SELECT NUMERO_SEGURO INTO v_seguro
    FROM FIDE_PACIENTES_TB
    WHERE ID_PACIENTE = p_id_paciente
    AND ACTIVO = 1;
    
    IF v_seguro IS NOT NULL THEN
        RETURN 1; -- Tiene seguro
    ELSE
        RETURN 0; -- No tiene seguro
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN -1; -- Paciente no encontrado
    WHEN OTHERS THEN
        RETURN -2; -- Error
END PACIENTE_TIENE_SEGURO;
/


-- 7. Función para contar citas por estado
CREATE OR REPLACE FUNCTION CONTAR_CITAS_POR_ESTADO(
    p_id_estado IN NUMBER
) RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_total
    FROM FIDE_CITAS_TB
    WHERE ID_ESTADO_CITA = p_id_estado
    AND ACTIVO = 1;
    
    RETURN v_total;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END CONTAR_CITAS_POR_ESTADO;
/

-- 8. Función para calcular duración promedio de tratamientos
CREATE OR REPLACE FUNCTION CALCULAR_DURACION_PROMEDIO_TRATAMIENTOS
RETURN NUMBER
AS
    v_promedio NUMBER;
BEGIN
    SELECT AVG(FECHA_FIN - FECHA_INICIO) INTO v_promedio
    FROM FIDE_TRATAMIENTOS_TB
    WHERE FECHA_FIN IS NOT NULL
    AND ACTIVO = 1;
    
    RETURN NVL(v_promedio, 0);
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END CALCULAR_DURACION_PROMEDIO_TRATAMIENTOS;
/

-- 9. Función para obtener próximo horario disponible de doctor
CREATE OR REPLACE FUNCTION OBTENER_PROXIMO_HORARIO_DISPONIBLE(
    p_id_doctor IN NUMBER,
    p_fecha IN DATE
) RETURN DATE
AS
    v_horario DATE;
BEGIN
    SELECT MIN(d.HORA_INICIO) INTO v_horario
    FROM FIDE_DISPONIBILIDAD_TB d
    LEFT JOIN FIDE_CITAS_TB c ON d.ID_DOCTOR = c.ID_DOCTOR 
        AND TRUNC(d.HORA_INICIO) = TRUNC(p_fecha)
        AND c.ACTIVO = 1
    WHERE d.ID_DOCTOR = p_id_doctor
    AND TRUNC(d.HORA_INICIO) = TRUNC(p_fecha)
    AND d.ACTIVO = 1
    AND c.ID_CITA IS NULL;
    
    RETURN v_horario;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN NULL;
END OBTENER_PROXIMO_HORARIO_DISPONIBLE;
/


-- 10. Función para verificar disponibilidad de medicamento
CREATE OR REPLACE FUNCTION VERIFICAR_DISPONIBILIDAD_MEDICAMENTO(
    p_id_medicamento IN NUMBER
) RETURN NUMBER
AS
    v_cantidad NUMBER;
BEGIN
    SELECT CANTIDAD INTO v_cantidad
    FROM FIDE_INVENTARIO_MEDICAMENTOS_TB
    WHERE ID_MEDICAMENTO = p_id_medicamento
    AND ACTIVO = 1;
    
    RETURN v_cantidad;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1;
END VERIFICAR_DISPONIBILIDAD_MEDICAMENTO;
/

-- 11. Función para calcular valor total del inventario
CREATE OR REPLACE FUNCTION CALCULAR_VALOR_TOTAL_INVENTARIO
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT SUM(m.PRECIO * i.CANTIDAD) INTO v_total
    FROM FIDE_MEDICAMENTOS_TB m
    JOIN FIDE_INVENTARIO_MEDICAMENTOS_TB i ON m.ID_MEDICAMENTO = i.ID_MEDICAMENTO
    WHERE m.ACTIVO = 1
    AND i.ACTIVO = 1;
    
    RETURN NVL(v_total, 0);
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END CALCULAR_VALOR_TOTAL_INVENTARIO;
/

-- 12. Función para obtener medicamentos en riesgo de agotarse
CREATE OR REPLACE FUNCTION MEDICAMENTOS_BAJO_STOCK(
    p_minimo IN NUMBER
) RETURN SYS_REFCURSOR
AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT m.NOMBRE, i.CANTIDAD
    FROM FIDE_MEDICAMENTOS_TB m
    JOIN FIDE_INVENTARIO_MEDICAMENTOS_TB i ON m.ID_MEDICAMENTO = i.ID_MEDICAMENTO
    WHERE i.CANTIDAD <= p_minimo
    AND m.ACTIVO = 1
    AND i.ACTIVO = 1
    ORDER BY i.CANTIDAD ASC;
    
    RETURN v_cursor;
EXCEPTION
    WHEN OTHERS THEN
        -- Retornar un cursor vacío en caso de error
        OPEN v_cursor FOR 
        SELECT NULL AS NOMBRE, NULL AS CANTIDAD FROM DUAL WHERE 1=0;
        RETURN v_cursor;
END MEDICAMENTOS_BAJO_STOCK;
/


