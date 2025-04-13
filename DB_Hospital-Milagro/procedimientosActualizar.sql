---procedimientos_actualizar

-- 1. Procedimiento para actualizar FIDE_ESPECIALIDADES_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_ESPECIALIDAD_TB_SP(
    p_id_especialidad fide_especialidades_tb.nombre%TYPE, 
    p_nombre fide_especialidades_tb.nombre%TYPE,
    p_descripcion fide_especialidades_tb.descripcion%TYPE
) AS
BEGIN
    UPDATE FIDE_ESPECIALIDADES_TB
    SET NOMBRE = p_nombre,
        DESCRIPCION = p_descripcion,
        ID_ESPECIALIDAD =  p_id_especialidad
    WHERE ID_ESPECIALIDAD = p_id_especialidad;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END  FIDE_ACTUALIZAR_ESPECIALIDAD_TB_SP;
/
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_SUBESPECIALIDAD_TB_SP(
    p_id_subespecialidad fide_subespecialidad_tb.id_subespecialidad%TYPE,
    p_nombre fide_subespecialidad_tb.nombre%TYPE,
    p_descripcion fide_subespecialidad_tb.descripcion%TYPE,
    p_id_especialidad fide_subespecialidad_tb.id_especialidad%TYPE
) AS
BEGIN
    UPDATE FIDE_SUBESPECIALIDAD_TB
    SET NOMBRE = p_nombre,
        DESCRIPCION = p_descripcion,
        ID_ESPECIALIDAD = p_id_especialidad,
        ID_SUBESPECIALIDAD = p_id_subespecialidad
    WHERE ID_SUBESPECIALIDAD = p_id_subespecialidad;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_SUBESPECIALIDAD_TB_SP;
/

-- 3. Procedimiento para actualizar FIDE_SERVICIO_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_SERVICIO_TB_SP(
    p_id_servicio fide_servicio_tb.id_servicio%TYPE,
    p_nombre fide_servicio_tb.nombre%TYPE,
    p_descripcion fide_servicio_tb.descripcion%TYPE
) AS
BEGIN
    UPDATE FIDE_SERVICIO_TB
    SET NOMBRE = p_nombre,
        DESCRIPCION = p_descripcion,
        ID_SERVICIO = p_id_servicio
    WHERE ID_SERVICIO = p_id_servicio;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_SERVICIO_TB_SP;
/

-- 4. Procedimiento para actualizar FIDE_PROCEDIMIENTOS_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_PROCEDIMIENTO_TB_SP(
    p_id_procedimiento fide_procedimientos_tb.id_procedimiento%TYPE,
    p_nombre_procedimiento fide_procedimientos_tb.nombre_procedimiento%TYPE,
    p_descripcion fide_procedimientos_tb.descripcion%TYPE,
    p_tipo_procedimiento fide_procedimientos_tb.tipo_procedimiento%TYPE,
    p_riesgo fide_procedimientos_tb.riesgo%TYPE
) AS
BEGIN
    UPDATE FIDE_PROCEDIMIENTOS_TB
    SET NOMBRE_PROCEDIMIENTO = p_nombre_procedimiento,
        DESCRIPCION = p_descripcion,
        TIPO_PROCEDIMIENTO = p_tipo_procedimiento,
        RIESGO = p_riesgo,
        ID_PROCEDIMIENTO = p_id_procedimiento
    WHERE ID_PROCEDIMIENTO = p_id_procedimiento;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_PROCEDIMIENTO_TB_SP;
/

CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_TRATAMIENTO_TB_SP(
    p_id_tratamiento fide_tratamientos_tb.id_tratamiento%TYPE,
    p_descripcion fide_tratamientos_tb.descripcion%TYPE,
    p_fecha_inicio fide_tratamientos_tb.fecha_inicio%TYPE,
    p_fecha_fin fide_tratamientos_tb.fecha_fin%TYPE,
    p_id_paciente fide_tratamientos_tb.id_paciente%TYPE
) AS
BEGIN
    UPDATE FIDE_TRATAMIENTOS_TB
    SET DESCRIPCION = p_descripcion,
        FECHA_INICIO = p_fecha_inicio,
        FECHA_FIN = p_fecha_fin,
        ID_PACIENTE = p_id_paciente
    WHERE ID_TRATAMIENTO = p_id_tratamiento;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_TRATAMIENTO_TB_SP;
/

-- 2. Procedimiento para actualizar FIDE_ESTADOS_CITAS_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_ESTADO_CITA_TB_SP(
    p_id_estado_cita fide_estados_citas_tb.id_estado_cita%TYPE,
    p_nombre_estado fide_estados_citas_tb.nombre_estado%TYPE
) AS
BEGIN
    UPDATE FIDE_ESTADOS_CITAS_TB
    SET NOMBRE_ESTADO = p_nombre_estado
    WHERE ID_ESTADO_CITA = p_id_estado_cita;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_ESTADO_CITA_TB_SP;
/

-- 3. Procedimiento para actualizar FIDE_CITAS_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_CITA_TB_SP(
    p_id_cita fide_citas_tb.id_cita%TYPE,
    p_fecha fide_citas_tb.fecha%TYPE,
    p_hora_cita fide_citas_tb.hora_cita%TYPE,
    p_id_estado_cita fide_citas_tb.id_estado_cita%TYPE,
    p_id_doctor  fide_citas_tb.id_doctor%TYPE,
    p_id_paciente  fide_citas_tb.id_paciente%TYPE
) AS
BEGIN
    UPDATE FIDE_CITAS_TB
    SET FECHA = p_fecha,
        HORA_CITA = p_hora_cita,
        ID_ESTADO_CITA = p_id_estado_cita,
        ID_DOCTOR = p_id_doctor,
        ID_PACIENTE = p_id_paciente
    WHERE ID_CITA = p_id_cita;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_CITA_TB_SP;
/

-- 4. Procedimiento para actualizar FIDE_COSTOS_CITA_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_COSTO_CITA_TB_SP(
    p_id_costo fide_costos_cita_tb.id_costo%TYPE,
    p_id_cita fide_costos_cita_tb.id_cita%TYPE,
    p_monto fide_costos_cita_tb.monto%TYPE,
    p_descripcion fide_costos_cita_tb.descripcion%TYPE
) AS
BEGIN
    UPDATE FIDE_COSTOS_CITA_TB
    SET ID_CITA = p_id_cita,
        MONTO = p_monto,
        DESCRIPCION = p_descripcion
    WHERE ID_COSTO = p_id_costo;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_COSTO_CITA_TB_SP;
/

-- 1. Procedimiento para actualizar FIDE_MEDICAMENTOS_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_MEDICAMENTO_TB_SP(
    p_id_medicamento fide_medicamentos_tb.id_medicamento%TYPE,
    p_nombre fide_medicamentos_tb.nombre%TYPE,
    p_descripcion  fide_medicamentos_tb.descripcion%TYPE,
    p_precio fide_medicamentos_tb.precio%TYPE
) AS
BEGIN
    UPDATE FIDE_MEDICAMENTOS_TB
    SET NOMBRE = p_nombre,
        DESCRIPCION = p_descripcion,
        PRECIO = p_precio
    WHERE ID_MEDICAMENTO = p_id_medicamento;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_MEDICAMENTO_TB_SP;
/

-- 2. Procedimiento para actualizar FIDE_INVENTARIO_MEDICAMENTOS_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_INVENTARIO_MEDICAMENTOS_TB_SP(
    p_id_inventario fide_inventario_medicamentos_tb.id_inventario%TYPE,
    p_id_medicamento fide_inventario_medicamentos_tb.id_medicamento%TYPE,
    p_cantidad fide_inventario_medicamentos_tb.cantidad%TYPE,
    p_observaciones fide_inventario_medicamentos_tb.observaciones%TYPE
) AS
BEGIN
    UPDATE FIDE_INVENTARIO_MEDICAMENTOS_TB
    SET ID_MEDICAMENTO = p_id_medicamento,
        CANTIDAD = p_cantidad,
        OBSERVACIONES = p_observaciones
    WHERE ID_INVENTARIO = p_id_inventario;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_INVENTARIO_MEDICAMENTOS_TB_SP;
/

-- 3. Procedimiento para actualizar FIDE_FACTURAS_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_FACTURA_TB_SP(
    p_id_factura fide_facturas_tb.id_factura%TYPE,
    p_numero_factura fide_facturas_tb.numero_factura%TYPE,
    p_fecha_emision fide_facturas_tb.fecha_emision%TYPE,
    p_fecha_vencimiento fide_facturas_tb.fecha_vencimiento%TYPE,
    p_monto_total fide_facturas_tb.monto_total%TYPE,
    p_estado_pago fide_facturas_tb.estado_pago%TYPE,
    p_id_paciente fide_facturas_tb.id_paciente%TYPE
) AS
BEGIN
    UPDATE FIDE_FACTURAS_TB
    SET NUMERO_FACTURA = p_numero_factura,
        FECHA_EMISION = p_fecha_emision,
        FECHA_VENCIMIENTO = p_fecha_vencimiento,
        MONTO_TOTAL = p_monto_total,
        ESTADO_PAGO = p_estado_pago,
        ID_PACIENTE = p_id_paciente
    WHERE ID_FACTURA = p_id_factura;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_FACTURA_TB_SP;
/

-- 1. Procedimiento para actualizar FIDE_PAISES_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_PAIS_TB_SP(
    p_id_pais fide_paises_tb.id_pais%TYPE,
    p_nombre fide_paises_tb.nombre%TYPE
) AS
BEGIN
    UPDATE FIDE_PAISES_TB
    SET NOMBRE = p_nombre
    WHERE ID_PAIS = p_id_pais;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_PAIS_TB_SP;
/
-- 2. Procedimiento para actualizar FIDE_PROVINCIAS_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_PROVINCIA_TB_SP(
    p_id_provincia fide_provincias_tb.id_provincia%TYPE,
    p_nombre   fide_provincias_tb.nombre%TYPE,
    p_id_pais  fide_provincias_tb.id_pais%TYPE
) AS
BEGIN
    UPDATE FIDE_PROVINCIAS_TB
    SET NOMBRE = p_nombre,
        ID_PAIS = p_id_pais
    WHERE ID_PROVINCIA = p_id_provincia;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_PROVINCIA_TB_SP;
/
-- 2. Procedimiento para actualizar FIDE_CANTONES_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_CANTON_TB_SP(
    p_id_canton fide_cantones_tb.id_canton%TYPE,
    p_nombre fide_cantones_tb.nombre%TYPE,
    p_id_provincia fide_cantones_tb.id_provincia%TYPE
) AS
BEGIN
    UPDATE FIDE_CANTONES_TB
    SET NOMBRE = p_nombre,
        ID_provincia = p_id_provincia
    WHERE ID_CANTON = p_id_canton;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_CANTON_TB_SP;
/

-- 3. Procedimiento para actualizar FIDE_DISTRITOS_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_DISTRITO_TB_SP(
    p_id_distrito fide_distritos_tb.id_distrito%TYPE,
    p_nombre fide_distritos_tb.nombre%TYPE,
    p_id_canton fide_distritos_tb.id_canton%TYPE
) AS
BEGIN
    UPDATE FIDE_DISTRITOS_TB
    SET NOMBRE = p_nombre,
        ID_CANTON = p_id_canton
    WHERE ID_DISTRITO = p_id_distrito;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_DISTRITO_TB_SP;
/

-- 4. Procedimiento para actualizar FIDE_DIRECCION_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_DIRECCION_TB_SP(
    p_id_direccion fide_direccion_tb.id_direccion%TYPE,
    p_id_pais fide_direccion_tb.id_direccion%TYPE,
    p_id_provincia fide_direccion_tb.id_provincia%TYPE,
    p_id_canton fide_direccion_tb.id_canton%TYPE,
    p_id_distrito fide_direccion_tb.id_distrito%TYPE
) AS
BEGIN
    UPDATE FIDE_DIRECCION_TB
    SET ID_PAIS = p_id_pais,
        ID_CANTON = p_id_canton,
        ID_DISTRITO = p_id_distrito
    WHERE ID_DIRECCION = p_id_direccion;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_DIRECCION_TB_SP;
/

-- 5. Procedimiento para actualizar FIDE_DISPONIBILIDAD_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_DISPONIBILIDAD_TB_SP(
    p_id_disponibilidad fide_disponibilidad_tb.id_disponibilidad%TYPE,
    p_dia fide_disponibilidad_tb.dia%TYPE,
    p_hora_inicio fide_disponibilidad_tb.hora_inicio%TYPE,
    p_hora_fin fide_disponibilidad_tb.hora_fin%TYPE,
    p_id_doctor fide_disponibilidad_tb.id_doctor%TYPE
) AS
BEGIN
    UPDATE FIDE_DISPONIBILIDAD_TB
    SET DIA = p_dia,
        HORA_INICIO = p_hora_inicio,
        HORA_FIN = p_hora_fin,
        ID_DOCTOR = p_id_doctor
    WHERE ID_DISPONIBILIDAD = p_id_disponibilidad;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_DISPONIBILIDAD_TB_SP;
/

-- 1. Procedimiento para actualizar FIDE_USUARIOS_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_USUARIO_TB_SP(
    p_id_usuario fide_usuarios_tb.id_usuario%TYPE,
    p_nombre FIDE_USUARIOS_TB.NOMBRE%TYPE,
    p_primer_apellido fide_usuarios_tb.primer_apellido%TYPE,
    p_segundo_apellido fide_usuarios_tb.segundo_apellido%TYPE,
    p_correo FIDE_USUARIOS_TB.CORREO%TYPE,
    p_contrasena FIDE_USUARIOS_TB.CONTRASENA%TYPE
) AS
BEGIN
    UPDATE FIDE_USUARIOS_TB
    SET NOMBRE = p_nombre,
        PRIMER_APELLIDO = p_primer_apellido,
        SEGUNDO_APELLIDO = p_segundo_apellido,
        CORREO = p_correo,
        CONTRASENA = p_contrasena
    WHERE ID_USUARIO = p_id_usuario;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_USUARIO_TB_SP;
/

-- 2. Procedimiento para actualizar FIDE_ROL_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_ROL_TB_SP(
    p_id_rol fide_rol_tb.id_rol%TYPE,
    p_nombre fide_rol_tb.nombre%TYPE
) AS
BEGIN
    UPDATE FIDE_ROL_TB
    SET NOMBRE = p_nombre
    WHERE ID_ROL = p_id_rol;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_ROL_TB_SP;
/

-- 3. Procedimiento para actualizar FIDE_DOCTORES_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_DOCTOR_TB_SP(
    p_id_doctor fide_doctores_tb.id_doctor%TYPE,
    p_telefono fide_doctores_tb.telefono%TYPE,
    p_numero_licencia fide_doctores_tb.numerol_licencia%TYPE,
    p_id_usuario fide_doctores_tb.id_usuario%TYPE,
    p_id_direccion fide_doctores_tb.id_direccion%TYPE
) AS
BEGIN
    UPDATE FIDE_DOCTORES_TB
    SET TELEFONO = p_telefono,
        NUMEROL_LICENCIA = p_numero_licencia,
        ID_USUARIO = p_id_usuario,
        ID_DIRECCION = p_id_direccion
    WHERE ID_DOCTOR = p_id_doctor;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_DOCTOR_TB_SP;
/

-- 4. Procedimiento para actualizar FIDE_PACIENTES_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_PACIENTE_TB_SP(
    p_id_paciente fide_pacientes_tb.id_paciente%TYPE,
    p_fecha_nacimiento fide_pacientes_tb.fecha_nacimiento%TYPE,
    p_numero_seguro fide_pacientes_tb.numero_seguro%TYPE,
    p_direccion fide_pacientes_tb.direccion%TYPE,
    p_telefono fide_pacientes_tb.telefono%TYPE,
    p_id_usuario fide_pacientes_tb.id_usuario%TYPE,
    p_id_direccion fide_pacientes_tb.id_direccion%TYPE
) AS
BEGIN
    UPDATE FIDE_PACIENTES_TB
    SET FECHA_NACIMIENTO = p_fecha_nacimiento,
        NUMERO_SEGURO = p_numero_seguro,
        DIRECCION = p_direccion,
        TELEFONO = p_telefono,
        ID_USUARIO = p_id_usuario,
        ID_DIRECCION = p_id_direccion
    WHERE ID_PACIENTE = p_id_paciente;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_PACIENTE_TB_SP;
/

-- 5. Procedimiento para actualizar FIDE_NOTIFICACIONES_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_NOTIFICACION_TB_SP(
    p_id_notificacion fide_notificaciones_tb.id_notificacion%TYPE,
    p_mensaje fide_notificaciones_tb.mensaje%TYPE,
    p_tipo fide_notificaciones_tb.tipo%TYPE,
    p_fecha_envio fide_notificaciones_tb.fecha_envio%TYPE,
    p_id_usuario fide_notificaciones_tb.id_usuario%TYPE
) AS
BEGIN
    UPDATE FIDE_NOTIFICACIONES_TB
    SET MENSAJE = p_mensaje,
        TIPO = p_tipo,
        FECHA_ENVIO = p_fecha_envio,
        ID_USUARIO = p_id_usuario
    WHERE ID_NOTIFICACION = p_id_notificacion;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_NOTIFICACION_TB_SP;
/

-- 1. Procedimiento para actualizar FIDE_HISTORIAL_CITAS_TB
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_HISTORIAL_CITA_TB_SP(
    p_id_historial fide_historial_citas_tb.id_historial%TYPE,
    p_id_cita fide_historial_citas_tb.id_cita%TYPE,
    p_fecha_cambio fide_historial_citas_tb.fecha_cambio%TYPE,
    p_id_estado_anterior fide_historial_citas_tb.id_estado_anterior%TYPE,
    p_id_estado_nuevo fide_historial_citas_tb.id_estado_nuevo%TYPE,
    p_observaciones fide_historial_citas_tb.observaciones%TYPE
) AS
BEGIN
    UPDATE FIDE_HISTORIAL_CITAS_TB
    SET ID_CITA = p_id_cita,
        FECHA_CAMBIO = p_fecha_cambio,
        ID_ESTADO_ANTERIOR = p_id_estado_anterior,
        ID_ESTADO_NUEVO = p_id_estado_nuevo,
        OBSERVACIONES = p_observaciones
    WHERE ID_HISTORIAL = p_id_historial;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ACTUALIZAR_HISTORIAL_CITA_TB_SP;
/