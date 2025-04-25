---FUNCIONA
CREATE OR REPLACE PROCEDURE FIDE_CREAR_USUARIO_SP(
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

/
CREATE OR REPLACE PROCEDURE FIDE_REGISTRAR_PAIS_SP(
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
/
CREATE OR REPLACE PROCEDURE FIDE_REGISTRAR_PROVINCIA_SP (
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
/

CREATE OR REPLACE PROCEDURE FIDE_REGISTRAR_CANTON_SP(
    p_nombre fide_cantones_tb.nombre%TYPE,
    p_id_pais fide_paises_tb.id_pais%TYPE
) AS
BEGIN
    INSERT INTO FIDE_CANTONES_TB (
         NOMBRE, ID_PAIS
    ) VALUES (
         p_nombre, p_id_pais
    );
    COMMIT;
END FIDE_REGISTRAR_CANTON_SP;
/
CREATE OR REPLACE PROCEDURE FIDE_REGISTRAR_DISTRITO_SP(
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
/

CREATE OR REPLACE PROCEDURE FIDE_REGISTRAR_DIRECCION_SP(
    p_id_pais fide_paises_tb.id_pais%TYPE,
    p_id_canton fide_cantones_tb.id_canton%TYPE,
    p_id_distrito fide_distritos_tb.id_distrito%TYPE
) AS
BEGIN
    INSERT INTO FIDE_DIRECCION_TB (
  ID_PAIS, ID_CANTON, ID_DISTRITO
    ) VALUES (
      p_id_pais, p_id_canton, p_id_distrito
    );
    COMMIT;
END FIDE_REGISTRAR_DIRECCION_SP;
/
CREATE OR REPLACE PROCEDURE FIDE_REGISTRAR_PACIENTE_SP(
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
/
CREATE OR REPLACE PROCEDURE FIDE_CREAR_TRATAMIENTO_SP(
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
/
--Funciona
CREATE OR REPLACE PROCEDURE FIDE_AGREGAR_ESPECIALIDAD_SP(
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
/
--Funciona
CREATE OR REPLACE PROCEDURE FIDE_AGREGAR_SUBESPECIALIDAD_SP(
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
/
--Funciona
CREATE OR REPLACE PROCEDURE FIDE_AGREGAR_SERVICIO_SP(
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

/
CREATE OR REPLACE PROCEDURE FIDE_ASOCIAR_SERVICIO_ESPECIALIDAD_SP(
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
--Funciona
/
CREATE OR REPLACE PROCEDURE FIDE_AGREGAR_PROCEDIMIENTO_SP(
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

/
CREATE OR REPLACE PROCEDURE FIDE_AGREGAR_PROCEDIMIENTO_TRATAMIENTO_SP(
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
/

--Funciona
CREATE OR REPLACE PROCEDURE FIDE_AGREGAR_ESTADO_CITA_SP(
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

/
---FUNCIONA
CREATE OR REPLACE PROCEDURE FIDE_REGISTRAR_DOCTOR_SP(
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

/
CREATE OR REPLACE PROCEDURE FIDE_PROGRAMAR_CITA_SP(
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
/
----FUNCIONA
CREATE OR REPLACE PROCEDURE FIDE_ASOCIAR_CITA_TRATAMIENTO_SP(
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
/
--Funciona
CREATE OR REPLACE PROCEDURE FIDE_REGISTRAR_MEDICAMENTO_SP(
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

/

-- FUNCIONA
CREATE OR REPLACE PROCEDURE FIDE_AGREGAR_TRATAMIENTOS_MEDICAMENTOS_TB_SP(
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

/
--Funciona
CREATE OR REPLACE PROCEDURE FIDE_AGREGAR_INVENTARIO_MEDICAMENTO_SP(
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
END FIDE_AGREGAR_INVENTARIO_MEDICAMENTO_SP;
/
--Funciona
CREATE OR REPLACE PROCEDURE FIDE_REGISTRAR_COSTO_CITA_SP(
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

/
---funciona
CREATE OR REPLACE PROCEDURE FIDE_GENERAR_FACTURA_SP(
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
/

CREATE OR REPLACE PROCEDURE FIDE_AGREGAR_DISPONIBILIDAD_SP(
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
/
---FUNCIONA
CREATE OR REPLACE PROCEDURE FIDE_CREAR_ROL_SP(
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
/
--FUNCIONA
CREATE OR REPLACE PROCEDURE FIDE_ASIGNAR_ROL_USUARIO_SP(
    p_id_rol fide_rol_tb.id_rol%TYPE,
    p_id_usuario fide_usuarios_tb.id_usuario%TYPE
) AS
BEGIN
    INSERT INTO FIDE_USUARIO_ROL_TB (
        ID_ROL, ID_USUARIO
    ) VALUES (
        p_id_rol, p_id_usuario
    );
    COMMIT;
END FIDE_ASIGNAR_ROL_USUARIO_SP;
/
CREATE OR REPLACE PROCEDURE FIDE_ENVIAR_NOTIFICACION_SP(
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
/
-- FUNCIONA
CREATE OR REPLACE PROCEDURE FIDE_ASIGNAR_ESPECIALIDAD_DOCTOR_SP(
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
/
CREATE OR REPLACE PROCEDURE FIDE_REGISTRAR_HISTORIAL_CITA_SP(
    p_id_cita fide_historial_citas_tb.id_cita%TYPE,
    p_fecha_cambio fide_historial_citas_tb.fecha_cambio%TYPE,
    p_id_estado_anterior fide_historial_citas_tb.id_estado_anterior%TYPE,
    p_id_estado_nuevo fide_historial_citas_tb.id_estado_nuevo%TYPE,
    p_observaciones fide_historial_citas_tb.observaciones%TYPE
) AS
BEGIN
    INSERT INTO FIDE_HISTORIAL_CITAS_TB (
     ID_CITA, FECHA_CAMBIO, ID_ESTADO_ANTERIOR, ID_ESTADO_NUEVO, OBSERVACIONES
    ) VALUES (
         p_id_cita, p_fecha_cambio, p_id_estado_anterior, p_id_estado_nuevo, p_observaciones
    );
    COMMIT;
END FIDE_REGISTRAR_HISTORIAL_CITA_SP;
/

--CREAR CITA
CREATE OR REPLACE PROCEDURE FIDE_CREAR_CITA_SP(
    p_fecha FIDE_CITAS_TB.FECHA%TYPE,
    p_hora_cita FIDE_CITAS_TB.HORA_CITA%TYPE,
    p_estado_cita FIDE_CITAS_TB.ID_ESTADO_CITA%TYPE,
    p_doctor FIDE_CITAS_TB.ID_DOCTOR%TYPE,
    p_paciente FIDE_CITAS_TB.ID_PACIENTE%TYPE
    
) AS
BEGIN
    INSERT INTO FIDE_CITAS_TB (
         FECHA, HORA_CITA, ID_ESTADO_CITA, ID_DOCTOR, ID_PACIENTE
    ) VALUES (
    p_fecha, p_hora_cita, p_estado_cita, p_doctor, p_paciente     
    );
    COMMIT;
END FIDE_CREAR_CITA_SP;
/



--PROCEDIMIENTO PARA AUTENTICAR UN USUARIO
CREATE OR REPLACE PROCEDURE FIDE_AUTENTICAR_USUARIO_SP(
    p_nombre fide_usuarios_tb.nombre%TYPE,
    p_contrasena fide_usuarios_tb.contrasena%TYPE,
    p_usuario_id OUT fide_usuarios_tb.id_usuario%TYPE,
    p_existe OUT NUMBER
) AS
BEGIN
    SELECT ID_USUARIO INTO p_usuario_id 
    FROM FIDE_USUARIOS_TB
    WHERE NOMBRE = p_nombre
    AND CONTRASENA = p_contrasena
    AND ACTIVO=1;
    
    p_existe:=1;
END FIDE_AUTENTICAR_USUARIO_SP;

