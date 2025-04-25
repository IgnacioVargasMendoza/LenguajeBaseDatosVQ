create or replace PACKAGE BODY FIDE_HOSPITAL_MILAGRO_PKG AS
PROCEDURE FIDE_CREAR_USUARIO_SP(
    p_nombre FIDE_USUARIOS_TB.NOMBRE%TYPE,
    p_primer_apellido fide_usuarios_tb.primer_apellido%TYPE,
    p_segundo_apellido fide_usuarios_tb.segundo_apellido%TYPE,
    p_correo FIDE_USUARIOS_TB.CORREO%TYPE,
    p_contrasena FIDE_USUARIOS_TB.CONTRASENA%TYPE
) AS
BEGIN
    INSERT INTO FIDE_USUARIOS_TB (
         NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO, CORREO, CONTRASENA
    ) VALUES (
    p_nombre, p_primer_apellido, p_segundo_apellido, p_correo, p_contrasena     
    );
    COMMIT;
END FIDE_CREAR_USUARIO_SP;
PROCEDURE FIDE_REGISTRAR_PAIS_SP(
    p_nombre fide_paises_tb.nombre%TYPE
) AS
BEGIN
    INSERT INTO FIDE_PAISES_TB (
       NOMBRE
    ) VALUES (
         p_nombre
    );
    COMMIT;
END FIDE_REGISTRAR_PAIS_SP;
PROCEDURE FIDE_REGISTRAR_PROVINCIA_SP (
    p_nombre   fide_provincias_tb.nombre%TYPE,
    p_id_pais  fide_provincias_tb.id_pais%TYPE
) AS
BEGIN
    INSERT INTO FIDE_PROVINCIAS_TB (
        NOMBRE,
        ID_PAIS
    ) VALUES (
        p_nombre,
        p_id_pais
    );
    COMMIT;
END FIDE_REGISTRAR_PROVINCIA_SP;
PROCEDURE FIDE_REGISTRAR_CANTON_SP(
    p_nombre fide_cantones_tb.nombre%TYPE,
    p_id_provincia fide_cantones_tb.id_provincia%TYPE
) AS
BEGIN
    INSERT INTO FIDE_CANTONES_TB (
         NOMBRE, ID_PROVINCIA
    ) VALUES (
         p_nombre, p_id_provincia
    );
    COMMIT;
END FIDE_REGISTRAR_CANTON_SP;
PROCEDURE FIDE_REGISTRAR_DISTRITO_SP(
    p_nombre fide_distritos_tb.nombre%TYPE,
    p_id_canton fide_distritos_tb.id_canton%TYPE
) AS
BEGIN
    INSERT INTO FIDE_DISTRITOS_TB (
    NOMBRE, ID_CANTON
    ) VALUES (
   p_nombre, p_id_canton
    );
    COMMIT;
END FIDE_REGISTRAR_DISTRITO_SP;
PROCEDURE FIDE_REGISTRAR_DIRECCION_SP(
    p_id_pais fide_direccion_tb.id_pais%TYPE,
    p_id_provincia fide_direccion_tb.id_provincia%TYPE,
    p_id_canton fide_direccion_tb.id_canton%TYPE,
    p_id_distrito fide_direccion_tb.id_distrito%TYPE
) AS
BEGIN
    INSERT INTO FIDE_DIRECCION_TB (
  ID_PAIS,ID_PROVINCIA, ID_CANTON, ID_DISTRITO
    ) VALUES (
      p_id_pais, p_id_provincia, p_id_canton, p_id_distrito
    );
    COMMIT;
END FIDE_REGISTRAR_DIRECCION_SP;
PROCEDURE FIDE_REGISTRAR_PACIENTE_SP(
    p_fecha_nacimiento fide_pacientes_tb.fecha_nacimiento%TYPE,
    p_numero_seguro fide_pacientes_tb.numero_seguro%TYPE,
    p_direccion fide_pacientes_tb.direccion%TYPE,
    p_telefono fide_pacientes_tb.telefono%TYPE,
    p_id_usuario fide_pacientes_tb.id_usuario%TYPE,
    p_id_direccion fide_pacientes_tb.id_direccion%TYPE
) AS
BEGIN
    INSERT INTO FIDE_PACIENTES_TB (
         FECHA_NACIMIENTO, NUMERO_SEGURO, DIRECCION, TELEFONO, ID_USUARIO, ID_DIRECCION
    ) VALUES (
         p_fecha_nacimiento, p_numero_seguro, p_direccion, p_telefono, p_id_usuario, p_id_direccion   
    );
    COMMIT;
END FIDE_REGISTRAR_PACIENTE_SP;
PROCEDURE FIDE_CREAR_TRATAMIENTO_SP(
    p_descripcion fide_tratamientos_tb.descripcion%TYPE,
    p_fecha_inicio fide_tratamientos_tb.fecha_inicio%TYPE,
    p_fecha_fin fide_tratamientos_tb.fecha_fin%TYPE,
    p_id_paciente fide_tratamientos_tb.id_paciente%TYPE
) AS
BEGIN
    INSERT INTO FIDE_TRATAMIENTOS_TB (
      DESCRIPCION, FECHA_INICIO, FECHA_FIN, ID_PACIENTE
    ) VALUES (
        p_descripcion, p_fecha_inicio, p_fecha_fin, p_id_paciente
    );
    COMMIT;
END  FIDE_CREAR_TRATAMIENTO_SP;
PROCEDURE FIDE_AGREGAR_ESPECIALIDAD_SP(
    p_nombre fide_especialidades_tb.nombre%TYPE,
    p_descripcion fide_especialidades_tb.descripcion%TYPE
) AS
BEGIN
    INSERT INTO FIDE_ESPECIALIDADES_TB (
         NOMBRE, DESCRIPCION
    ) VALUES (
  p_nombre, p_descripcion
    );
    COMMIT;
END  FIDE_AGREGAR_ESPECIALIDAD_SP;
PROCEDURE FIDE_AGREGAR_SUBESPECIALIDAD_SP(
    p_nombre fide_subespecialidad_tb.nombre%TYPE,
    p_descripcion fide_subespecialidad_tb.descripcion%TYPE,
    p_id_especialidad fide_subespecialidad_tb.id_especialidad%TYPE
) AS
BEGIN
    INSERT INTO FIDE_SUBESPECIALIDAD_TB (
       NOMBRE, DESCRIPCION, ID_ESPECIALIDAD
    ) VALUES (
        p_nombre, p_descripcion, p_id_especialidad
    );
    COMMIT;
END FIDE_AGREGAR_SUBESPECIALIDAD_SP;
PROCEDURE FIDE_AGREGAR_SERVICIO_SP(
    p_nombre fide_servicio_tb.nombre%TYPE,
    p_descripcion fide_servicio_tb.descripcion%TYPE
) AS
BEGIN
    INSERT INTO FIDE_SERVICIO_TB (
         NOMBRE, DESCRIPCION
    ) VALUES (
       p_nombre, p_descripcion   
    );
    COMMIT;
END FIDE_AGREGAR_SERVICIO_SP;
 PROCEDURE FIDE_ASOCIAR_SERVICIO_ESPECIALIDAD_SP(
    p_id_servicio fide_servicio_especialidad_tb.id_servicio%TYPE,
    p_id_especialidad fide_servicio_especialidad_tb.id_especialidad%TYPE
) AS
BEGIN
    INSERT INTO FIDE_SERVICIO_ESPECIALIDAD_TB (
        ID_SERVICIO, ID_ESPECIALIDAD
    ) VALUES (
        p_id_servicio, p_id_especialidad
    );
    COMMIT;
END FIDE_ASOCIAR_SERVICIO_ESPECIALIDAD_SP;
PROCEDURE FIDE_AGREGAR_PROCEDIMIENTO_SP(
    p_nombre_procedimiento fide_procedimientos_tb.nombre_procedimiento%TYPE,
    p_descripcion fide_procedimientos_tb.descripcion%TYPE,
    p_tipo_procedimiento fide_procedimientos_tb.tipo_procedimiento%TYPE,
    p_riesgo fide_procedimientos_tb.riesgo%TYPE
) AS
BEGIN
    INSERT INTO FIDE_PROCEDIMIENTOS_TB (
       NOMBRE_PROCEDIMIENTO,  DESCRIPCION, TIPO_PROCEDIMIENTO, RIESGO
    ) VALUES (
     p_nombre_procedimiento,  p_descripcion, p_tipo_procedimiento, p_riesgo
    );
    COMMIT;
END FIDE_AGREGAR_PROCEDIMIENTO_SP;
PROCEDURE FIDE_AGREGAR_PROCEDIMIENTO_TRATAMIENTO_SP(
    p_id_tratamiento fide_tratamientos_procedimientos_tb.id_tratamiento%TYPE,
    p_id_procedimiento fide_tratamientos_procedimientos_tb.id_procedimiento%TYPE
) AS
BEGIN
    INSERT INTO FIDE_TRATAMIENTOS_PROCEDIMIENTOS_TB (
        ID_TRATAMIENTO, ID_PROCEDIMIENTO
    ) VALUES (
        p_id_tratamiento, p_id_procedimiento
    );
    COMMIT;
END FIDE_AGREGAR_PROCEDIMIENTO_TRATAMIENTO_SP;

PROCEDURE FIDE_AGREGAR_ESTADO_CITA_SP(
    p_nombre_estado fide_estados_citas_tb.nombre_estado%TYPE
) AS
BEGIN
    INSERT INTO FIDE_ESTADOS_CITAS_TB (
        NOMBRE_ESTADO
    ) VALUES (
        p_nombre_estado
    );
    COMMIT;
END FIDE_AGREGAR_ESTADO_CITA_SP;
PROCEDURE FIDE_REGISTRAR_DOCTOR_SP(
    p_telefono fide_doctores_tb.telefono%TYPE,
    p_numero_licencia fide_doctores_tb.numerol_licencia%TYPE,
    p_id_usuario fide_doctores_tb.id_usuario%TYPE,
    p_id_direccion fide_doctores_tb.id_direccion%TYPE
) AS
BEGIN
    INSERT INTO FIDE_DOCTORES_TB (
      TELEFONO, NUMEROL_LICENCIA, ID_USUARIO, ID_DIRECCION
    ) VALUES (
 p_telefono, p_numero_licencia, p_id_usuario, p_id_direccion
    );
    COMMIT;
END FIDE_REGISTRAR_DOCTOR_SP;
PROCEDURE FIDE_PROGRAMAR_CITA_SP(
    p_fecha fide_citas_tb.fecha%TYPE,
    p_hora_cita fide_citas_tb.hora_cita%TYPE,
    p_id_estado_cita fide_citas_tb.id_estado_cita%TYPE,
    p_id_doctor  fide_citas_tb.id_doctor%TYPE,
    p_id_paciente  fide_citas_tb.id_paciente%TYPE
) AS
BEGIN
    INSERT INTO FIDE_CITAS_TB (
         FECHA, HORA_CITA, ID_ESTADO_CITA, ID_DOCTOR, ID_PACIENTE
    ) VALUES (
         p_fecha, p_hora_cita, p_id_estado_cita, p_id_doctor, p_id_paciente
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_PROGRAMAR_CITA_SP;
PROCEDURE FIDE_ASOCIAR_CITA_TRATAMIENTO_SP(
    p_id_cita fide_citas_tratamientos_tb.id_cita%TYPE,
    p_id_tratamiento fide_citas_tratamientos_tb.id_tratamiento%TYPE
) AS
BEGIN
    INSERT INTO FIDE_CITAS_TRATAMIENTOS_TB (
        ID_CITA, ID_TRATAMIENTO
    ) VALUES (
        p_id_cita, p_id_tratamiento
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ASOCIAR_CITA_TRATAMIENTO_SP;
PROCEDURE FIDE_REGISTRAR_MEDICAMENTO_SP(
    p_nombre fide_medicamentos_tb.nombre%TYPE,
    p_descripcion  fide_medicamentos_tb.descripcion%TYPE,
    p_precio fide_medicamentos_tb.precio%TYPE
) AS
BEGIN
    INSERT INTO FIDE_MEDICAMENTOS_TB (
 NOMBRE, DESCRIPCION, PRECIO
    ) VALUES (
         p_nombre, p_descripcion, p_precio
    );
    COMMIT;
END FIDE_REGISTRAR_MEDICAMENTO_SP;
PROCEDURE FIDE_AGREGAR_TRATAMIENTOS_MEDICAMENTOS_TB_SP(
    p_id_medicamento fide_tratamientos_medicamentos_tb.id_medicamento%TYPE,
    p_id_tratamiento fide_tratamientos_medicamentos_tb.id_tratamiento%TYPE
) AS
BEGIN
    INSERT INTO FIDE_TRATAMIENTOS_MEDICAMENTOS_TB (
        ID_MEDICAMENTO, ID_TRATAMIENTO
    ) VALUES (
        p_id_medicamento, p_id_tratamiento
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_AGREGAR_TRATAMIENTOS_MEDICAMENTOS_TB_SP;
PROCEDURE FIDE_ACTUALIZAR_INVENTARIO_MEDICAMENTO_SP(
    p_id_medicamento fide_inventario_medicamentos_tb.id_medicamento%TYPE,
    p_cantidad fide_inventario_medicamentos_tb.cantidad%TYPE,
    p_observaciones fide_inventario_medicamentos_tb.observaciones%TYPE
) AS
BEGIN
    INSERT INTO FIDE_INVENTARIO_MEDICAMENTOS_TB (
         ID_MEDICAMENTO, CANTIDAD, OBSERVACIONES
    ) VALUES (
         p_id_medicamento, p_cantidad, p_observaciones
    );
    COMMIT;
END FIDE_ACTUALIZAR_INVENTARIO_MEDICAMENTO_SP;
PROCEDURE FIDE_REGISTRAR_COSTO_CITA_SP(
    p_id_cita fide_costos_cita_tb.id_cita%TYPE,
    p_monto fide_costos_cita_tb.monto%TYPE,
    p_descripcion fide_costos_cita_tb.descripcion%TYPE
) AS
BEGIN
    INSERT INTO FIDE_COSTOS_CITA_TB (
        ID_CITA, MONTO, DESCRIPCION
    ) VALUES (
       p_id_cita, p_monto, p_descripcion
    );
    COMMIT;
END  FIDE_REGISTRAR_COSTO_CITA_SP;
PROCEDURE FIDE_GENERAR_FACTURA_SP(
    p_numero_factura fide_facturas_tb.numero_factura%TYPE,
    p_fecha_emision fide_facturas_tb.fecha_emision%TYPE,
    p_fecha_vencimiento fide_facturas_tb.fecha_vencimiento%TYPE,
    p_monto_total fide_facturas_tb.monto_total%TYPE,
    p_estado_pago fide_facturas_tb.estado_pago%TYPE,
    p_id_paciente fide_facturas_tb.id_paciente%TYPE
) AS
BEGIN
    INSERT INTO FIDE_FACTURAS_TB (
        NUMERO_FACTURA, FECHA_EMISION, FECHA_VENCIMIENTO, MONTO_TOTAL, ESTADO_PAGO, ID_PACIENTE
    ) VALUES (
         p_numero_factura, p_fecha_emision, p_fecha_vencimiento, p_monto_total, p_estado_pago, p_id_paciente
    );
    COMMIT;
END FIDE_GENERAR_FACTURA_SP;
PROCEDURE FIDE_AGREGAR_DISPONIBILIDAD_SP(
    p_dia fide_disponibilidad_tb.dia%TYPE,
    p_hora_inicio fide_disponibilidad_tb.hora_inicio%TYPE,
    p_hora_fin fide_disponibilidad_tb.hora_fin%TYPE,
    p_id_doctor fide_disponibilidad_tb.id_doctor%TYPE
) AS
BEGIN
    INSERT INTO FIDE_DISPONIBILIDAD_TB (
 DIA, HORA_INICIO, HORA_FIN, ID_DOCTOR
    ) VALUES (
    p_dia, p_hora_inicio, p_hora_fin, p_id_doctor
    );
    COMMIT;
END FIDE_AGREGAR_DISPONIBILIDAD_SP;
PROCEDURE FIDE_CREAR_ROL_SP(
    p_nombre fide_rol_tb.nombre%TYPE
) AS
BEGIN
    INSERT INTO FIDE_ROL_TB (
         NOMBRE
    ) VALUES (
      p_nombre
    );
    COMMIT;
END FIDE_CREAR_ROL_SP;
PROCEDURE FIDE_ASIGNAR_ROL_USUARIO_SP(
    p_id_rol fide_usuario_rol_tb.id_usuario%TYPE,
    p_id_usuario fide_usuario_rol_tb.id_rol%TYPE
) AS
BEGIN
    INSERT INTO FIDE_USUARIO_ROL_TB (
        ID_ROL, ID_USUARIO
    ) VALUES (
        p_id_rol, p_id_usuario
    );
    COMMIT;
END FIDE_ASIGNAR_ROL_USUARIO_SP;
PROCEDURE FIDE_ENVIAR_NOTIFICACION_SP(
    p_mensaje fide_notificaciones_tb.mensaje%TYPE,
    p_tipo fide_notificaciones_tb.tipo%TYPE,
    p_fecha_envio fide_notificaciones_tb.fecha_envio%TYPE,
    p_id_usuario fide_notificaciones_tb.id_usuario%TYPE
) AS
BEGIN
    INSERT INTO FIDE_NOTIFICACIONES_TB (
        MENSAJE, TIPO, FECHA_ENVIO, ID_USUARIO
    ) VALUES (
        p_mensaje, p_tipo, p_fecha_envio, p_id_usuario
    );
    COMMIT;
END FIDE_ENVIAR_NOTIFICACION_SP;
PROCEDURE FIDE_ASIGNAR_ESPECIALIDAD_DOCTOR_SP(
    p_id_especialidad fide_doctores_especialidades_tb.id_especialidad%TYPE,
    p_id_doctor fide_doctores_especialidades_tb.id_doctor%TYPE
) AS
BEGIN
    INSERT INTO FIDE_DOCTORES_ESPECIALIDADES_TB (
        ID_ESPECIALIDAD, ID_DOCTOR
    ) VALUES (
        p_id_especialidad, p_id_doctor
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END FIDE_ASIGNAR_ESPECIALIDAD_DOCTOR_SP;
PROCEDURE FIDE_ACTUALIZAR_ESPECIALIDAD_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_SUBESPECIALIDAD_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_SERVICIO_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_PROCEDIMIENTO_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_TRATAMIENTO_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_ESTADO_CITA_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_CITA_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_COSTO_CITA_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_MEDICAMENTO_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_INVENTARIO_MEDICAMENTOS_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_FACTURA_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_PAIS_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_PROVINCIA_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_CANTON_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_DISTRITO_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_DIRECCION_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_DISPONIBILIDAD_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_USUARIO_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_ROL_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_DOCTOR_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_PACIENTE_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_NOTIFICACION_TB_SP(
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
PROCEDURE FIDE_ACTUALIZAR_HISTORIAL_CITA_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_ESPECIALIDAD_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_SUBESPECIALIDAD_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_SERVICIO_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_PROCEDIMIENTO_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_SERVICIO_ESPECIALIDAD_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_TRATAMIENTO_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_ESTADO_CITA_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_CITA_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_COSTO_CITA_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_CITA_TRATAMIENTO_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_MEDICAMENTO_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_INVENTARIO_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_FACTURA_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_TRATAMIENTO_PROCEDIMIENTO_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_TRATAMIENTO_MEDICAMENTO_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_PAIS_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_PROVINCIA_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_CANTON_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_DISTRITO_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_DIRECCION_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_DISPONIBILIDAD_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_USUARIO_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_ROL_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_DOCTOR_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_PACIENTE_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_NOTIFICACION_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_USUARIO_ROL_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_DOCTOR_ESPECIALIDAD_TB_SP(
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

PROCEDURE FIDE_DESACTIVAR_HISTORIAL_CITA_TB_SP(
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

END FIDE_HOSPITAL_MILAGRO_PKG;