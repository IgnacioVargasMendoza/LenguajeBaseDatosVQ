CREATE OR REPLACE PROCEDURE FIDE_USUARIOS_TB_INSERT_USUARIO_SP( --EL NOMBRE DE SER NOMBRETABLA_FUNCION_SP
    P_ID_USUARIO FIDE_USUARIOS_TB.ID_USUARIO%TYPE,
    P_NOMBRE FIDE_USUARIOS_TB.NOMBRE%TYPE,
    P_PRIMER_APELLIDO fide_usuarios_tb.primer_apellido%TYPE,
    P_SEGUNDO_APELLIDO fide_usuarios_tb.segundo_apellido%TYPE,
    P_CORREO FIDE_USUARIOS_TB.CORREO%TYPE,
    P_CONTRASENA FIDE_USUARIOS_TB.CONTRASENA%TYPE,
    P_ACTIVO FIDE_USUARIOS_TB.ACTIVO%TYPE
)
IS
BEGIN
    INSERT INTO FIDE_USUARIOS_TB (ID_USUARIO, NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO, CORREO, CONTRASENA, ACTIVO)
    VALUES (P_ID_USUARIO, P_NOMBRE, P_PRIMER_APELLIDO, P_SEGUNDO_APELLIDO, P_CORREO, P_CONTRASENA, P_ACTIVO);
    COMMIT;
END;

/
CREATE OR REPLACE PROCEDURE FIDE_USUARIOS_TB_UPDATE_USUARIO_SP(
    P_ID_USUARIO FIDE_USUARIOS_TB.ID_USUARIO%TYPE,
    P_NOMBRE FIDE_USUARIOS_TB.NOMBRE%TYPE,
    P_PRIMER_APELLIDO FIDE_USUARIOS_TB.PRIMER_APELLIDO%TYPE,
    P_SEGUNDO_APELLIDO FIDE_USUARIOS_TB.SEGUNDO_APELLIDO%TYPE,
    P_CORREO FIDE_USUARIOS_TB.CORREO%TYPE,
    P_CONTRASENA FIDE_USUARIOS_TB.CONTRASENA%TYPE,
    P_ACTIVO FIDE_USUARIOS_TB.ACTIVO%TYPE
)
IS
BEGIN
    UPDATE FIDE_USUARIOS_TB
    SET 
        NOMBRE = P_NOMBRE,
        PRIMER_APELLIDO = P_PRIMER_APELLIDO,
        SEGUNDO_APELLIDO = P_SEGUNDO_APELLIDO,
        CORREO = P_CORREO,
        CONTRASENA = P_CONTRASENA,
        ACTIVO = P_ACTIVO
    WHERE ID_USUARIO = P_ID_USUARIO;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_USUARIOS_TB_DELETE_USUARIO_SP(
    P_ID_USUARIO FIDE_USUARIOS_TB.ID_USUARIO%TYPE
)
IS
BEGIN
    UPDATE FIDE_USUARIOS_TB
    SET ACTIVO = 0
    WHERE ID_USUARIO = P_ID_USUARIO;
    COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE FIDE_ROL_TB_INSERT_ROL_SP(
    P_ID_ROL FIDE_ROL_TB.ID_ROL%TYPE,
    P_NOMBRE FIDE_ROL_TB.NOMBRE%TYPE,
    P_ACTIVO FIDE_ROL_TB.ACTIVO%TYPE
)
IS
BEGIN
    INSERT INTO FIDE_ROL_TB (ID_ROL, NOMBRE, ACTIVO)
    VALUES (P_ID_ROL, P_NOMBRE, P_ACTIVO);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_ROL_TB_UPDATE_ROL_SP(
    P_ID_ROL FIDE_ROL_TB.ID_ROL%TYPE,
    P_NOMBRE FIDE_ROL_TB.NOMBRE%TYPE,
    P_ACTIVO FIDE_ROL_TB.ACTIVO%TYPE
)
IS
BEGIN
    UPDATE FIDE_ROL_TB
    SET 
        NOMBRE = P_NOMBRE,
        ACTIVO = P_ACTIVO
    WHERE ID_ROL = P_ID_ROL;
    COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE FIDE_ROL_TB_DELETE_ROL_SP(
    P_ID_ROL FIDE_ROL_TB.ID_ROL%TYPE
)
IS
BEGIN
    UPDATE FIDE_ROL_TB
    SET ACTIVO = 0
    WHERE ID_ROL = P_ID_ROL;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_USUARIO_ROL_TB_INSERT_RELACION_SP(
    P_ID_ROL FIDE_USUARIO_ROL_TB.ID_ROL%TYPE,
    P_ID_USUARIO FIDE_USUARIO_ROL_TB.ID_USUARIO%TYPE
)
IS
BEGIN
    INSERT INTO FIDE_USUARIO_ROL_TB (ID_ROL, ID_USUARIO)
    VALUES (P_ID_ROL, P_ID_USUARIO);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_USUARIO_ROL_TB_DELETE_RELACION_SP(
    P_ID_ROL FIDE_USUARIO_ROL_TB.ID_ROL%TYPE,
    P_ID_USUARIO FIDE_USUARIO_ROL_TB.ID_USUARIO%TYPE
)
IS
BEGIN
    DELETE FROM FIDE_USUARIO_ROL_TB
    WHERE ID_ROL = P_ID_ROL AND ID_USUARIO = P_ID_USUARIO;
    COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE FIDE_DIRECCION_TB_INSERT_DIRECCION_SP(
    P_ID_DIRECCION FIDE_DIRECCION_TB.ID_DIRECCION%TYPE,
    P_PAIS FIDE_DIRECCION_TB.PAIS%TYPE,
    P_CANTON FIDE_DIRECCION_TB.CANTON%TYPE,
    P_DISTRITO FIDE_DIRECCION_TB.DISTRITO%TYPE,
    P_ACTIVO FIDE_DIRECCION_TB.ACTIVO%TYPE
)
IS
BEGIN
    INSERT INTO FIDE_DIRECCION_TB (ID_DIRECCION, PAIS, CANTON, DISTRITO, ACTIVO)
    VALUES (P_ID_DIRECCION, P_PAIS, P_CANTON, P_DISTRITO, P_ACTIVO);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_DIRECCION_TB_UPDATE_DIRECCION_SP(
    P_ID_DIRECCION FIDE_DIRECCION_TB.ID_DIRECCION%TYPE,
    P_PAIS FIDE_DIRECCION_TB.PAIS%TYPE,
    P_CANTON FIDE_DIRECCION_TB.CANTON%TYPE,
    P_DISTRITO FIDE_DIRECCION_TB.DISTRITO%TYPE,
    P_ACTIVO FIDE_DIRECCION_TB.ACTIVO%TYPE
)
IS
BEGIN
    UPDATE FIDE_DIRECCION_TB
    SET 
        PAIS = P_PAIS,
        CANTON = P_CANTON,
        DISTRITO = P_DISTRITO,
        ACTIVO = P_ACTIVO
    WHERE ID_DIRECCION = P_ID_DIRECCION;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_DIRECCION_TB_DELETE_DIRECCION_SP(
    P_ID_DIRECCION FIDE_DIRECCION_TB.ID_DIRECCION%TYPE
)
IS
BEGIN
    UPDATE FIDE_DIRECCION_TB
    SET ACTIVO = 0
    WHERE ID_DIRECCION = P_ID_DIRECCION;
    COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE FIDE_DOCTORES_TB_Insertar_Doctor_SP(
    p_id_doctor FIDE_Doctores_TB.ID_DOCTOR%TYPE,
    p_telefono FIDE_Doctores_TB.telefono%TYPE,
    p_numerolicencia FIDE_Doctores_TB.numerolicencia%TYPE,
    p_id_usuario FIDE_Doctores_TB.id_usuario%TYPE,
    p_id_direccion FIDE_Doctores_TB.id_direccion%TYPE,
    p_activo FIDE_Doctores_TB.activo%TYPE
) IS
BEGIN
    INSERT INTO FIDE_Doctores_TB (ID_DOCTOR, telefono, numerolicencia, id_usuario,id_direccion, activo)
    VALUES (p_id_doctor, p_telefono, p_numerolicencia, p_id_usuario,p_id_direccion, p_activo);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: El doctor ya existe en la base de datos.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un problema al insertar el doctor, Contacte a TI: ' || SQLERRM);
END;
/
CREATE OR REPLACE PROCEDURE FIDE_DOCTORES_TB_Actualizar_Doctor_SP(
    p_id_doctor FIDE_Doctores_TB.ID_DOCTOR%TYPE,
    p_telefono FIDE_Doctores_TB.telefono%TYPE,
    p_numerolicencia FIDE_Doctores_TB.numerolicencia%TYPE,
    p_id_usuario FIDE_Doctores_TB.id_usuario%TYPE,
    p_activo FIDE_Doctores_TB.activo%TYPE
) IS
BEGIN
    UPDATE FIDE_Doctores_TB
    SET telefono = p_telefono,
        numerolicencia = p_numerolicencia,
        id_usuario = p_id_usuario,
        activo = p_activo
    WHERE ID_DOCTOR = p_id_doctor;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró el doctor para actualizar.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Se encontró más de un doctor con ese ID.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un problema al actualizar el doctor, contacte a TI ' || SQLERRM);
END;
/
CREATE OR REPLACE PROCEDURE FIDE_DOCTORES_TB_Eliminar_Doctor_SP(
    p_id_doctor FIDE_Doctores_TB.ID_DOCTOR%TYPE
) IS
BEGIN
    UPDATE FIDE_Doctores_TB
    SET activo = 0
    WHERE ID_DOCTOR = p_id_doctor;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró el doctor para eliminar.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un problema al eliminar el doctor, CONTACTE A TI: ' || SQLERRM);
END;
/
CREATE OR REPLACE PROCEDURE FIDE_ESPECIALIDADES_TB_Insertar_Especialidad_SP(
    p_id_especialidad FIDE_Especialidades_TB.id_especialidad%TYPE,
    p_nombre FIDE_Especialidades_TB.nombre%TYPE,
    p_descripcion FIDE_Especialidades_TB.descripcion%TYPE,
    p_activo FIDE_Especialidades_TB.activo%TYPE
) IS
BEGIN
    INSERT INTO FIDE_Especialidades_TB (id_especialidad, nombre,descripcion, activo)
    VALUES (p_id_especialidad, p_nombre,p_descripcion, p_activo);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ya existe una especialidad con ese ID.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un problema al insertar, contactar a TI: ' || SQLERRM);
END;

/
CREATE OR REPLACE PROCEDURE FIDE_ESPECIALIDADES_TB_Actualizar_Especialidad_SP(
    p_id_especialidad FIDE_Especialidades_TB.id_especialidad%TYPE,
    p_nombre FIDE_Especialidades_TB.nombre%TYPE,
    p_activo FIDE_Especialidades_TB.activo%TYPE
) IS
BEGIN
    UPDATE FIDE_Especialidades_TB
    SET nombre = p_nombre,  -- corregido el nombre de la columna
        activo = p_activo
    WHERE id_especialidad = p_id_especialidad;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró la especialidad para actualizar.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Se encontró más de una especialidad con ese ID.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un problema, contactar a TI: ' || SQLERRM);
END;

/
CREATE OR REPLACE PROCEDURE FIDE_ESPECIALIDADES_TB_Eliminar_Especialidad_SP(
    p_id_especialidad FIDE_Especialidades_TB.id_especialidad%TYPE
) IS
BEGIN
    UPDATE FIDE_Especialidades_TB
    SET activo = 0
    WHERE id_especialidad = p_id_especialidad;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró la especialidad para eliminar.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un problema, contactar a TI: ' || SQLERRM);
END;
/
CREATE OR REPLACE PROCEDURE FIDE_DOCTORES_ESPECIALIDADES_TB_Insertar_Doctor_Especialidad_SP(
    p_id_especialidad FIDE_DOCTORES_ESPECIALIDADES_TB.ID_ESPECIALIDAD%TYPE,
    p_id_doctor FIDE_DOCTORES_ESPECIALIDADES_TB.ID_DOCTOR%TYPE
) IS
BEGIN
    INSERT INTO FIDE_DOCTORES_ESPECIALIDADES_TB (ID_ESPECIALIDAD, ID_DOCTOR)
    VALUES (p_id_especialidad, p_id_doctor);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ya existe una relación doctor-especialidad con esos IDs.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un problema, contactar a TI: ' || SQLERRM);
END;

/
CREATE OR REPLACE PROCEDURE FIDE_DOCTORES_ESPECIALIDADES_TB_Actualizar_Doctor_Especialidad_SP(
    p_id_especialidad FIDE_DOCTORES_ESPECIALIDADES_TB.ID_ESPECIALIDAD%TYPE,
    p_id_doctor FIDE_DOCTORES_ESPECIALIDADES_TB.ID_DOCTOR%TYPE
) IS
BEGIN
    UPDATE FIDE_DOCTORES_ESPECIALIDADES_TB
    SET ID_ESPECIALIDAD = p_id_especialidad,
        ID_DOCTOR = p_id_doctor
    WHERE ID_ESPECIALIDAD = p_id_especialidad AND ID_DOCTOR = p_id_doctor;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró la relación doctor especialidad para actualizar.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Se encontraron más de una relación doctor especialidad con esos IDs.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un problema, contactar a TI: ' || SQLERRM);
END;
/
CREATE OR REPLACE PROCEDURE FIDE_DOCTORES_ESPECIALIDADES_TB_Eliminar_Doctor_Especialidad_SP(
    p_id_especialidad FIDE_DOCTORES_ESPECIALIDADES_TB.ID_ESPECIALIDAD%TYPE,
    p_id_doctor FIDE_DOCTORES_ESPECIALIDADES_TB.ID_DOCTOR%TYPE
) IS
BEGIN
    DELETE FROM FIDE_DOCTORES_ESPECIALIDADES_TB
    WHERE ID_ESPECIALIDAD = p_id_especialidad AND ID_DOCTOR = p_id_doctor;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró la relación doctor-especialidad para eliminar.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un problema, contactar a TI: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE FIDE_DOCTORES_ESPECIALIDADES_TB_ACTUALIZAR_ESPECIALIDAD_DOCTOR_SP (
    p_id_doctor FIDE_DOCTORES_ESPECIALIDADES_TB.ID_DOCTOR%TYPE,
    p_id_especialidad FIDE_DOCTORES_ESPECIALIDADES_TB.ID_ESPECIALIDAD%TYPE
) AS
BEGIN
    UPDATE FIDE_Doctores_Especialidades_TB
    SET id_especialidad = p_id_especialidad
    WHERE id_doctor = p_id_doctor;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_TRATAMIENTOS_PROCEDIMIENTOS_TB_REGISTRAR_TRATAMIENTO_MEDICAMENTO_SP (
    p_id_procedimiento FIDE_TRATAMIENTOS_PROCEDIMIENTOS_TB.ID_PROCEDIMIENTO%TYPE,
    p_id_tratamiento FIDE_TRATAMIENTOS_PROCEDIMIENTOS_TB.ID_TRATAMIENTO%TYPE
) AS
BEGIN
    INSERT INTO FIDE_TRATAMIENTOS_PROCEDIMIENTOS_TB (id_procedimiento, id_tratamiento)
    VALUES (p_id_procedimiento, p_id_tratamiento);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_CITAS_TB_CAMBIAR_ESTADO_CITA_SP (
    p_id_cita FIDE_CITAS_TB.ID_CITA%TYPE,
    p_id_estado FIDE_CITAS_TB.ID_ESTADO_CITA%TYPE
) AS
BEGIN
    UPDATE FIDE_CITAS_TB
    SET id_estado_cita = p_id_estado
    WHERE id_cita = p_id_cita;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_MEDICAMENTOS_TB_ELIMINAR_MEDICAMENTO_SP (
    p_id_medicamento FIDE_MEDICAMENTOS_TB.ID_MEDICAMENTO%TYPE
) AS
BEGIN
    DELETE FROM FIDE_Medicamentos_TB
    WHERE id_medicamento = p_id_medicamento;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_PACIENTES_TB_INSERTAR_PACIENTE_SP (
    p_id_paciente FIDE_PACIENTES_TB.ID_PACIENTE%TYPE,
    p_fecha_nacimiento FIDE_PACIENTES_TB.FECHA_NACIMIENTO%TYPE,
    p_numero_seguro FIDE_PACIENTES_TB.NUMERO_SEGURO%TYPE,
    p_direccion FIDE_PACIENTES_TB.DIRECCION%TYPE,
    p_telefono FIDE_PACIENTES_TB.TELEFONO%TYPE,
    p_id_usuario FIDE_PACIENTES_TB.ID_USUARIO%TYPE,
    p_activo FIDE_PACIENTES_TB.ACTIVO%TYPE,
    p_id_direccion FIDE_PACIENTES_TB.ID_DIRECCION%TYPE
) AS
BEGIN
    INSERT INTO FIDE_PACIENTES_TB (id_paciente, fecha_nacimiento, numero_seguro, direccion, telefono, id_usuario, activo, id_direccion)
    VALUES (p_id_paciente, p_fecha_nacimiento, p_numero_seguro, p_direccion, p_telefono, p_id_usuario, p_activo, p_id_direccion);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_NOTIFICACIONES_TB_ENVIAR_NOTIFICACION_SP (
    p_id_notificacion FIDE_NOTIFICACIONES_TB.ID_NOTIFICACION%TYPE,
    p_mensaje FIDE_NOTIFICACIONES_TB.MENSAJE%TYPE,
    p_tipo FIDE_NOTIFICACIONES_TB.TIPO%TYPE,
    p_fecha_envio FIDE_NOTIFICACIONES_TB.FECHA_ENVIO%TYPE,
    p_activo FIDE_NOTIFICACIONES_TB.ACTIVO%TYPE,
    p_id_usuario FIDE_NOTIFICACIONES_TB.ID_USUARIO%TYPE
) AS
BEGIN
    INSERT INTO FIDE_Notificaciones_TB (id_notificacion, mensaje, tipo, fecha_envio, activo, id_usuario)
    VALUES (p_id_notificacion, p_mensaje, p_tipo, p_fecha_envio, p_activo, p_id_usuario);
    COMMIT;
END;
/