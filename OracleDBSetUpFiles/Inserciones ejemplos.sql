---insertar usuario
BEGIN
    FIDE_USUARIOS_TB_INSERT_USUARIO_SP(
        P_ID_USUARIO      => 2001, 
        P_NOMBRE          => 'Juan', 
        P_PRIMER_APELLIDO => 'Pérez', 
        P_SEGUNDO_APELLIDO => 'Gómez', 
        P_CORREO          => 'juan.perez@example.com', 
        P_CONTRASENA      => 'Segura123', 
        P_ACTIVO          => 1
    );
END;
---insertar roles
/
BEGIN
    FIDE_ROL_TB_INSERT_ROL_SP(
        P_ID_ROL     => 1, 
        P_NOMBRE          => 'Doctor',  
        P_ACTIVO          => 1
    );
END;
/
BEGIN
    FIDE_ROL_TB_INSERT_ROL_SP(
        P_ID_ROL     => 2, 
        P_NOMBRE     => 'Paciente',  
        P_ACTIVO     => 1
    );
END;
/
--INSERTAR RELACION USUARIO-ROL
BEGIN
   FIDE_USUARIO_ROL_TB_INSERT_RELACION_SP(
    P_ID_ROL    => 1, 
    P_ID_USUARIO  => 2001
    );
END;
/
---INSERTAR DIRECCION
BEGIN
    FIDE_DIRECCION_TB_INSERT_DIRECCION_SP(
        P_ID_DIRECCION => 1001,
        P_PAIS => 'Costa Rica',
        P_CANTON => 'San José',
        P_DISTRITO => 'Escazú',
        P_ACTIVO => 1
    );
END;
--INSERTAR DOCTOR
BEGIN
    FIDE_DOCTORES_TB_Insertar_Doctor_SP(
        p_id_doctor => 1001,
        p_telefono => '87645643',
        p_numerolicencia => 'LIC34534',
        p_id_usuario => 2001,
        p_id_direccion => 1001,
        P_ACTIVO => 1
    );
END;

--INSERTAR ESPECIALIDAD
BEGIN
    FIDE_ESPECIALIDADES_TB_Insertar_Especialidad_SP(
        p_id_especialidad => 15,
        p_nombre => 'Odontologo',
        p_descripcion  =>  'sala 2',
        P_ACTIVO => 1
    );
END;
/
BEGIN
    FIDE_DOCTORES_ESPECIALIDADES_TB_Insertar_Doctor_Especialidad_SP(
    p_id_especialidad  => 15  ,
    p_id_doctor  => 1001
    );
END;
