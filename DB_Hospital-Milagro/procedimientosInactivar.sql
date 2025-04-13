---procedimientos inactivar

-- 1. Procedimiento para desactivar especialidad
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_ESPECIALIDAD_TB_SP(
    p_id_especialidad fide_especialidades_tb.nombre%TYPE
) AS
BEGIN
    UPDATE FIDE_ESPECIALIDADES_TB
    SET ACTIVO = 0
    WHERE ID_ESPECIALIDAD = p_id_especialidad;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_ESPECIALIDAD_TB_SP;
/

-- 2. Procedimiento para desactivar subespecialidad
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_SUBESPECIALIDAD_TB_SP(
    p_id_subespecialidad fide_subespecialidad_tb.id_subespecialidad%TYPE
) AS
BEGIN
    UPDATE FIDE_SUBESPECIALIDAD_TB
    SET ACTIVO = 0
    WHERE ID_SUBESPECIALIDAD = p_id_subespecialidad;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_SUBESPECIALIDAD_TB_SP;
/

-- 3. Procedimiento para desactivar servicio
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_SERVICIO_TB_SP(
    p_id_servicio fide_servicio_tb.id_servicio%TYPE
) AS
BEGIN
    UPDATE FIDE_SERVICIO_TB
    SET ACTIVO = 0
    WHERE ID_SERVICIO = p_id_servicio;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_SERVICIO_TB_SP;
/

-- 4. Procedimiento para desactivar procedimiento
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_PROCEDIMIENTO_TB_SP(
    p_id_procedimiento fide_procedimientos_tb.id_procedimiento%TYPE
) AS
BEGIN
    UPDATE FIDE_PROCEDIMIENTOS_TB
    SET ACTIVO = 0
    WHERE ID_PROCEDIMIENTO = p_id_procedimiento;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_PROCEDIMIENTO_TB_SP;
/

-- 5. Procedimiento para desactivar servicio-especialidad
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_SERVICIO_ESPECIALIDAD_TB_SP(
    p_id_servicio fide_servicio_especialidad_tb.id_servicio%TYPE,
    p_id_especialidad fide_servicio_especialidad_tb.id_especialidad%TYPE
) AS
BEGIN
    DELETE FROM FIDE_SERVICIO_ESPECIALIDAD_TB
    WHERE ID_SERVICIO = p_id_servicio
    AND ID_ESPECIALIDAD = p_id_especialidad;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_SERVICIO_ESPECIALIDAD_TB_SP;
/
-- 1. Procedimiento para desactivar tratamiento
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_TRATAMIENTO_TB_SP(
    p_id_tratamiento fide_tratamientos_tb.id_tratamiento%TYPE
) AS
BEGIN
    UPDATE FIDE_TRATAMIENTOS_TB
    SET ACTIVO = 0
    WHERE ID_TRATAMIENTO = p_id_tratamiento;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_TRATAMIENTO_TB_SP;
/

-- 2. Procedimiento para desactivar estado cita
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_ESTADO_CITA_TB_SP(
    p_id_estado_cita fide_estados_citas_tb.id_estado_cita%TYPE
) AS
BEGIN
    UPDATE FIDE_ESTADOS_CITAS_TB
    SET ACTIVO = 0
    WHERE ID_ESTADO_CITA = p_id_estado_cita;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_ESTADO_CITA_TB_SP;
/

-- 3. Procedimiento para desactivar cita
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_CITA_TB_SP(
    p_id_cita fide_citas_tb.id_cita%TYPE
) AS
BEGIN
    UPDATE FIDE_CITAS_TB
    SET ACTIVO = 0
    WHERE ID_CITA = p_id_cita;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_CITA_TB_SP;
/

-- 4. Procedimiento para desactivar costo cita
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_COSTO_CITA_TB_SP(
    p_id_costo fide_costos_cita_tb.id_costo%TYPE
) AS
BEGIN
    UPDATE FIDE_COSTOS_CITA_TB
    SET ACTIVO = 0
    WHERE ID_COSTO = p_id_costo;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_COSTO_CITA_TB_SP;
/

-- 5. Procedimiento para desactivar cita-tratamiento
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_CITA_TRATAMIENTO_TB_SP(
    p_id_cita fide_citas_tratamientos_tb.id_cita%TYPE,
    p_id_tratamiento fide_citas_tratamientos_tb.id_tratamiento%TYPE
) AS
BEGIN
    DELETE FROM FIDE_CITAS_TRATAMIENTOS_TB
    WHERE ID_CITA = p_id_cita
    AND ID_TRATAMIENTO = p_id_tratamiento;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_CITA_TRATAMIENTO_TB_SP;
/




-- 1. Procedimiento para desactivar medicamento
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_MEDICAMENTO_TB_SP(
    p_id_medicamento fide_medicamentos_tb.id_medicamento%TYPE
) AS
BEGIN
    UPDATE FIDE_MEDICAMENTOS_TB
    SET ACTIVO = 0
    WHERE ID_MEDICAMENTO = p_id_medicamento;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_MEDICAMENTO_TB_SP;
/

-- 2. Procedimiento para desactivar inventario
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_INVENTARIO_TB_SP(
    p_id_inventario fide_inventario_medicamentos_tb.id_inventario%TYPE
) AS
BEGIN
    UPDATE FIDE_INVENTARIO_MEDICAMENTOS_TB
    SET ACTIVO = 0
    WHERE ID_INVENTARIO = p_id_inventario;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_INVENTARIO_TB_SP;
/

-- 3. Procedimiento para desactivar factura
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_FACTURA_TB_SP(
    p_id_factura fide_facturas_tb.id_factura%TYPE
) AS
BEGIN
    UPDATE FIDE_FACTURAS_TB
    SET ACTIVO = 0
    WHERE ID_FACTURA = p_id_factura;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_FACTURA_TB_SP;
/

-- 4. Procedimiento para desactivar tratamiento-procedimiento
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_TRATAMIENTO_PROCEDIMIENTO_TB_SP(
    p_id_tratamiento fide_tratamientos_procedimientos_tb.id_tratamiento%TYPE,
    p_id_procedimiento fide_tratamientos_procedimientos_tb.id_procedimiento%TYPE
) AS
BEGIN
    DELETE FROM FIDE_TRATAMIENTOS_PROCEDIMIENTOS_TB
    WHERE ID_TRATAMIENTO = p_id_tratamiento
    AND ID_PROCEDIMIENTO = p_id_procedimiento;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_TRATAMIENTO_PROCEDIMIENTO_TB_SP;
/

-- 5. Procedimiento para desactivar tratamiento-medicamento
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_TRATAMIENTO_MEDICAMENTO_TB_SP(
    p_id_medicamento fide_tratamientos_medicamentos_tb.id_medicamento%TYPE,
    p_id_tratamiento fide_tratamientos_medicamentos_tb.id_tratamiento%TYPE
) AS
BEGIN
    DELETE FROM FIDE_TRATAMIENTOS_MEDICAMENTOS_TB
    WHERE ID_TRATAMIENTO = p_id_tratamiento
    AND ID_MEDICAMENTO = p_id_medicamento;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_TRATAMIENTO_MEDICAMENTO_TB_SP;
/

-- 1. Procedimiento para desactivar país
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_PAIS_TB_SP(
    p_id_pais fide_paises_tb.id_pais%TYPE
) AS
BEGIN
    UPDATE FIDE_PAISES_TB
    SET ACTIVO = 0
    WHERE ID_PAIS = p_id_pais;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_PAIS_TB_SP;
/
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_PROVINCIA_TB_SP(
    p_id_provincia fide_provincias_tb.id_provincia%TYPE
) AS
BEGIN
    UPDATE FIDE_PROVINCIAS_TB
    SET ACTIVO = 0
    WHERE ID_PROVINCIA = p_id_provincia;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_PROVINCIA_TB_SP;
/
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_CANTON_TB_SP(
    p_id_canton fide_cantones_tb.id_canton%TYPE
) AS
BEGIN
    UPDATE FIDE_CANTONES_TB
    SET ACTIVO = 0
    WHERE ID_CANTON = p_id_canton;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_CANTON_TB_SP;
/

-- 3. Procedimiento para desactivar distrito
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_DISTRITO_TB_SP(
    p_id_distrito fide_distritos_tb.id_distrito%TYPE
) AS
BEGIN
    UPDATE FIDE_DISTRITOS_TB
    SET ACTIVO = 0
    WHERE ID_DISTRITO = p_id_distrito;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_DISTRITO_TB_SP;
/

-- 4. Procedimiento para desactivar dirección
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_DIRECCION_TB_SP(
    p_id_direccion fide_direccion_tb.id_direccion%TYPE
) AS
BEGIN
    UPDATE FIDE_DIRECCION_TB
    SET ACTIVO = 0
    WHERE ID_DIRECCION = p_id_direccion;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_DIRECCION_TB_SP;
/

-- 5. Procedimiento para desactivar disponibilidad
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_DISPONIBILIDAD_TB_SP(
    p_id_disponibilidad fide_disponibilidad_tb.id_disponibilidad%TYPE
) AS
BEGIN
    UPDATE FIDE_DISPONIBILIDAD_TB
    SET ACTIVO = 0
    WHERE ID_DISPONIBILIDAD = p_id_disponibilidad;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_DISPONIBILIDAD_TB_SP;
/

-- 1. Procedimiento para desactivar usuario
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_USUARIO_TB_SP(
    p_id_usuario fide_usuarios_tb.id_usuario%TYPE
) AS
BEGIN
    UPDATE FIDE_USUARIOS_TB
    SET ACTIVO = 0
    WHERE ID_USUARIO = p_id_usuario;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_USUARIO_TB_SP;
/

-- 2. Procedimiento para desactivar rol
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_ROL_TB_SP(
    p_id_rol fide_rol_tb.id_rol%TYPE
) AS
BEGIN
    UPDATE FIDE_ROL_TB
    SET ACTIVO = 0
    WHERE ID_ROL = p_id_rol;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_ROL_TB_SP;
/

-- 3. Procedimiento para desactivar doctor
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_DOCTOR_TB_SP(
    p_id_doctor fide_doctores_tb.id_doctor%TYPE
) AS
BEGIN
    UPDATE FIDE_DOCTORES_TB
    SET ACTIVO = 0
    WHERE ID_DOCTOR = p_id_doctor;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_DOCTOR_TB_SP;
/

-- 4. Procedimiento para desactivar paciente
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_PACIENTE_TB_SP(
    p_id_paciente fide_pacientes_tb.id_paciente%TYPE
) AS
BEGIN
    UPDATE FIDE_PACIENTES_TB
    SET ACTIVO = 0
    WHERE ID_PACIENTE = p_id_paciente;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_PACIENTE_TB_SP;
/

-- 5. Procedimiento para desactivar notificación
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_NOTIFICACION_TB_SP(
    p_id_notificacion fide_notificaciones_tb.id_notificacion%TYPE
) AS
BEGIN
    UPDATE FIDE_NOTIFICACIONES_TB
    SET ACTIVO = 0
    WHERE ID_NOTIFICACION = p_id_notificacion;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_NOTIFICACION_TB_SP;
/

-- 1. Procedimiento para desactivar usuario-rol
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_USUARIO_ROL_TB_SP(
    p_id_rol fide_usuario_rol_tb.id_usuario%TYPE,
    p_id_usuario fide_usuario_rol_tb.id_rol%TYPE
) AS
BEGIN
    DELETE FROM FIDE_USUARIO_ROL_TB
    WHERE ID_USUARIO = p_id_usuario
    AND ID_ROL = p_id_rol;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_USUARIO_ROL_TB_SP;
/

-- 2. Procedimiento para desactivar doctor-especialidad
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_DOCTOR_ESPECIALIDAD_TB_SP(
    p_id_especialidad fide_doctores_especialidades_tb.id_especialidad%TYPE,
    p_id_doctor fide_doctores_especialidades_tb.id_doctor%TYPE
) AS
BEGIN
    DELETE FROM FIDE_DOCTORES_ESPECIALIDADES_TB
    WHERE ID_DOCTOR = p_id_doctor
    AND ID_ESPECIALIDAD = p_id_especialidad;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_DOCTOR_ESPECIALIDAD_TB_SP;
/

-- 3. Procedimiento para desactivar historial cita
CREATE OR REPLACE PROCEDURE FIDE_DESACTIVAR_HISTORIAL_CITA_TB_SP(
    p_id_historial fide_historial_citas_tb.id_historial%TYPE
) AS
BEGIN
    UPDATE FIDE_HISTORIAL_CITAS_TB
    SET ACTIVO = 0
    WHERE ID_HISTORIAL = p_id_historial;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_DESACTIVAR_HISTORIAL_CITA_TB_SP;
/