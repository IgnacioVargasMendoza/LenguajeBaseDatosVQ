create or replace PACKAGE FIDE_HOSPITAL_MILAGRO_PKG AS
PROCEDURE FIDE_CREAR_USUARIO_SP(
    p_nombre FIDE_USUARIOS_TB.NOMBRE%TYPE,
    p_primer_apellido fide_usuarios_tb.primer_apellido%TYPE,
    p_segundo_apellido fide_usuarios_tb.segundo_apellido%TYPE,
    p_correo FIDE_USUARIOS_TB.CORREO%TYPE,
    p_contrasena FIDE_USUARIOS_TB.CONTRASENA%TYPE
    
);
PROCEDURE FIDE_REGISTRAR_PAIS_SP(
    p_nombre fide_paises_tb.nombre%TYPE
);
PROCEDURE FIDE_REGISTRAR_PROVINCIA_SP (
    p_nombre   fide_provincias_tb.nombre%TYPE,
    p_id_pais  fide_provincias_tb.id_pais%TYPE
);
PROCEDURE FIDE_REGISTRAR_CANTON_SP(
    p_nombre fide_cantones_tb.nombre%TYPE,
    p_id_provincia fide_cantones_tb.id_provincia%TYPE
);
PROCEDURE FIDE_REGISTRAR_DISTRITO_SP(
    p_nombre fide_distritos_tb.nombre%TYPE,
    p_id_canton fide_distritos_tb.id_canton%TYPE
);
PROCEDURE FIDE_REGISTRAR_DIRECCION_SP(
    p_id_pais fide_direccion_tb.id_pais%TYPE,
    p_id_provincia fide_direccion_tb.id_provincia%TYPE,
    p_id_canton fide_direccion_tb.id_canton%TYPE,
    p_id_distrito fide_direccion_tb.id_distrito%TYPE
);
PROCEDURE FIDE_REGISTRAR_PACIENTE_SP(
    p_fecha_nacimiento fide_pacientes_tb.fecha_nacimiento%TYPE,
    p_numero_seguro fide_pacientes_tb.numero_seguro%TYPE,
    p_direccion fide_pacientes_tb.direccion%TYPE,
    p_telefono fide_pacientes_tb.telefono%TYPE,
    p_id_usuario fide_pacientes_tb.id_usuario%TYPE,
    p_id_direccion fide_pacientes_tb.id_direccion%TYPE
);
PROCEDURE FIDE_CREAR_TRATAMIENTO_SP(
    p_descripcion fide_tratamientos_tb.descripcion%TYPE,
    p_fecha_inicio fide_tratamientos_tb.fecha_inicio%TYPE,
    p_fecha_fin fide_tratamientos_tb.fecha_fin%TYPE,
    p_id_paciente fide_tratamientos_tb.id_paciente%TYPE
);
PROCEDURE FIDE_AGREGAR_ESPECIALIDAD_SP(
    p_nombre fide_especialidades_tb.nombre%TYPE,
    p_descripcion fide_especialidades_tb.descripcion%TYPE
);
PROCEDURE FIDE_AGREGAR_SUBESPECIALIDAD_SP(
    p_nombre fide_subespecialidad_tb.nombre%TYPE,
    p_descripcion fide_subespecialidad_tb.descripcion%TYPE,
    p_id_especialidad fide_subespecialidad_tb.id_especialidad%TYPE
);
PROCEDURE FIDE_AGREGAR_SERVICIO_SP(
    p_nombre fide_servicio_tb.nombre%TYPE,
    p_descripcion fide_servicio_tb.descripcion%TYPE
);
PROCEDURE FIDE_ASOCIAR_SERVICIO_ESPECIALIDAD_SP(
    p_id_servicio fide_servicio_especialidad_tb.id_servicio%TYPE,
    p_id_especialidad fide_servicio_especialidad_tb.id_especialidad%TYPE
);
PROCEDURE FIDE_AGREGAR_PROCEDIMIENTO_SP(
    p_nombre_procedimiento fide_procedimientos_tb.nombre_procedimiento%TYPE,
    p_descripcion fide_procedimientos_tb.descripcion%TYPE,
    p_tipo_procedimiento fide_procedimientos_tb.tipo_procedimiento%TYPE,
    p_riesgo fide_procedimientos_tb.riesgo%TYPE
);
PROCEDURE FIDE_AGREGAR_PROCEDIMIENTO_TRATAMIENTO_SP(
    p_id_tratamiento fide_tratamientos_procedimientos_tb.id_tratamiento%TYPE,
    p_id_procedimiento fide_tratamientos_procedimientos_tb.id_procedimiento%TYPE
);
PROCEDURE FIDE_AGREGAR_ESTADO_CITA_SP(
    p_nombre_estado fide_estados_citas_tb.nombre_estado%TYPE
);
PROCEDURE FIDE_REGISTRAR_DOCTOR_SP(
    p_telefono fide_doctores_tb.telefono%TYPE,
    p_numero_licencia fide_doctores_tb.numerol_licencia%TYPE,
    p_id_usuario fide_doctores_tb.id_usuario%TYPE,
    p_id_direccion fide_doctores_tb.id_direccion%TYPE
);
PROCEDURE FIDE_PROGRAMAR_CITA_SP(
    p_fecha fide_citas_tb.fecha%TYPE,
    p_hora_cita fide_citas_tb.hora_cita%TYPE,
    p_id_estado_cita fide_citas_tb.id_estado_cita%TYPE,
    p_id_doctor  fide_citas_tb.id_doctor%TYPE,
    p_id_paciente  fide_citas_tb.id_paciente%TYPE
);
 PROCEDURE FIDE_ASOCIAR_CITA_TRATAMIENTO_SP(
    p_id_cita fide_citas_tratamientos_tb.id_cita%TYPE,
    p_id_tratamiento fide_citas_tratamientos_tb.id_tratamiento%TYPE
);
PROCEDURE FIDE_REGISTRAR_MEDICAMENTO_SP(
    p_nombre fide_medicamentos_tb.nombre%TYPE,
    p_descripcion  fide_medicamentos_tb.descripcion%TYPE,
    p_precio fide_medicamentos_tb.precio%TYPE
);
PROCEDURE FIDE_AGREGAR_TRATAMIENTOS_MEDICAMENTOS_TB_SP(
    p_id_medicamento fide_tratamientos_medicamentos_tb.id_medicamento%TYPE,
    p_id_tratamiento fide_tratamientos_medicamentos_tb.id_tratamiento%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_INVENTARIO_MEDICAMENTO_SP(
    p_id_medicamento fide_inventario_medicamentos_tb.id_medicamento%TYPE,
    p_cantidad fide_inventario_medicamentos_tb.cantidad%TYPE,
    p_observaciones fide_inventario_medicamentos_tb.observaciones%TYPE
);
PROCEDURE FIDE_REGISTRAR_COSTO_CITA_SP(
    p_id_cita fide_costos_cita_tb.id_cita%TYPE,
    p_monto fide_costos_cita_tb.monto%TYPE,
    p_descripcion fide_costos_cita_tb.descripcion%TYPE
);
PROCEDURE FIDE_GENERAR_FACTURA_SP(
    p_numero_factura fide_facturas_tb.numero_factura%TYPE,
    p_fecha_emision fide_facturas_tb.fecha_emision%TYPE,
    p_fecha_vencimiento fide_facturas_tb.fecha_vencimiento%TYPE,
    p_monto_total fide_facturas_tb.monto_total%TYPE,
    p_estado_pago fide_facturas_tb.estado_pago%TYPE,
    p_id_paciente fide_facturas_tb.id_paciente%TYPE
);
PROCEDURE FIDE_AGREGAR_DISPONIBILIDAD_SP(
    p_dia fide_disponibilidad_tb.dia%TYPE,
    p_hora_inicio fide_disponibilidad_tb.hora_inicio%TYPE,
    p_hora_fin fide_disponibilidad_tb.hora_fin%TYPE,
    p_id_doctor fide_disponibilidad_tb.id_doctor%TYPE
);
PROCEDURE FIDE_CREAR_ROL_SP(
    p_nombre fide_rol_tb.nombre%TYPE
);
PROCEDURE FIDE_ASIGNAR_ROL_USUARIO_SP(
    p_id_rol fide_usuario_rol_tb.id_usuario%TYPE,
    p_id_usuario fide_usuario_rol_tb.id_rol%TYPE
);
PROCEDURE FIDE_ENVIAR_NOTIFICACION_SP(
    p_mensaje fide_notificaciones_tb.mensaje%TYPE,
    p_tipo fide_notificaciones_tb.tipo%TYPE,
    p_fecha_envio fide_notificaciones_tb.fecha_envio%TYPE,
    p_id_usuario fide_notificaciones_tb.id_usuario%TYPE
);
PROCEDURE FIDE_ASIGNAR_ESPECIALIDAD_DOCTOR_SP(
    p_id_especialidad fide_doctores_especialidades_tb.id_especialidad%TYPE,
    p_id_doctor fide_doctores_especialidades_tb.id_doctor%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_ESPECIALIDAD_TB_SP(
    p_id_especialidad fide_especialidades_tb.nombre%TYPE, 
    p_nombre fide_especialidades_tb.nombre%TYPE,
    p_descripcion fide_especialidades_tb.descripcion%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_SUBESPECIALIDAD_TB_SP(
    p_id_subespecialidad fide_subespecialidad_tb.id_subespecialidad%TYPE,
    p_nombre fide_subespecialidad_tb.nombre%TYPE,
    p_descripcion fide_subespecialidad_tb.descripcion%TYPE,
    p_id_especialidad fide_subespecialidad_tb.id_especialidad%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_SERVICIO_TB_SP(
    p_id_servicio fide_servicio_tb.id_servicio%TYPE,
    p_nombre fide_servicio_tb.nombre%TYPE,
    p_descripcion fide_servicio_tb.descripcion%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_PROCEDIMIENTO_TB_SP(
    p_id_procedimiento fide_procedimientos_tb.id_procedimiento%TYPE,
    p_nombre_procedimiento fide_procedimientos_tb.nombre_procedimiento%TYPE,
    p_descripcion fide_procedimientos_tb.descripcion%TYPE,
    p_tipo_procedimiento fide_procedimientos_tb.tipo_procedimiento%TYPE,
    p_riesgo fide_procedimientos_tb.riesgo%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_TRATAMIENTO_TB_SP(
    p_id_tratamiento fide_tratamientos_tb.id_tratamiento%TYPE,
    p_descripcion fide_tratamientos_tb.descripcion%TYPE,
    p_fecha_inicio fide_tratamientos_tb.fecha_inicio%TYPE,
    p_fecha_fin fide_tratamientos_tb.fecha_fin%TYPE,
    p_id_paciente fide_tratamientos_tb.id_paciente%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_ESTADO_CITA_TB_SP(
    p_id_estado_cita fide_estados_citas_tb.id_estado_cita%TYPE,
    p_nombre_estado fide_estados_citas_tb.nombre_estado%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_CITA_TB_SP(
    p_id_cita fide_citas_tb.id_cita%TYPE,
    p_fecha fide_citas_tb.fecha%TYPE,
    p_hora_cita fide_citas_tb.hora_cita%TYPE,
    p_id_estado_cita fide_citas_tb.id_estado_cita%TYPE,
    p_id_doctor  fide_citas_tb.id_doctor%TYPE,
    p_id_paciente  fide_citas_tb.id_paciente%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_COSTO_CITA_TB_SP(
    p_id_costo fide_costos_cita_tb.id_costo%TYPE,
    p_id_cita fide_costos_cita_tb.id_cita%TYPE,
    p_monto fide_costos_cita_tb.monto%TYPE,
    p_descripcion fide_costos_cita_tb.descripcion%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_MEDICAMENTO_TB_SP(
    p_id_medicamento fide_medicamentos_tb.id_medicamento%TYPE,
    p_nombre fide_medicamentos_tb.nombre%TYPE,
    p_descripcion  fide_medicamentos_tb.descripcion%TYPE,
    p_precio fide_medicamentos_tb.precio%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_INVENTARIO_MEDICAMENTOS_TB_SP(
    p_id_inventario fide_inventario_medicamentos_tb.id_inventario%TYPE,
    p_id_medicamento fide_inventario_medicamentos_tb.id_medicamento%TYPE,
    p_cantidad fide_inventario_medicamentos_tb.cantidad%TYPE,
    p_observaciones fide_inventario_medicamentos_tb.observaciones%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_FACTURA_TB_SP(
    p_id_factura fide_facturas_tb.id_factura%TYPE,
    p_numero_factura fide_facturas_tb.numero_factura%TYPE,
    p_fecha_emision fide_facturas_tb.fecha_emision%TYPE,
    p_fecha_vencimiento fide_facturas_tb.fecha_vencimiento%TYPE,
    p_monto_total fide_facturas_tb.monto_total%TYPE,
    p_estado_pago fide_facturas_tb.estado_pago%TYPE,
    p_id_paciente fide_facturas_tb.id_paciente%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_PAIS_TB_SP(
    p_id_pais fide_paises_tb.id_pais%TYPE,
    p_nombre fide_paises_tb.nombre%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_PROVINCIA_TB_SP(
    p_id_provincia fide_provincias_tb.id_provincia%TYPE,
    p_nombre   fide_provincias_tb.nombre%TYPE,
    p_id_pais  fide_provincias_tb.id_pais%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_CANTON_TB_SP(
    p_id_canton fide_cantones_tb.id_canton%TYPE,
    p_nombre fide_cantones_tb.nombre%TYPE,
    p_id_provincia fide_cantones_tb.id_provincia%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_DISTRITO_TB_SP(
    p_id_distrito fide_distritos_tb.id_distrito%TYPE,
    p_nombre fide_distritos_tb.nombre%TYPE,
    p_id_canton fide_distritos_tb.id_canton%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_DIRECCION_TB_SP(
    p_id_direccion fide_direccion_tb.id_direccion%TYPE,
    p_id_pais fide_direccion_tb.id_direccion%TYPE,
    p_id_provincia fide_direccion_tb.id_provincia%TYPE,
    p_id_canton fide_direccion_tb.id_canton%TYPE,
    p_id_distrito fide_direccion_tb.id_distrito%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_DISPONIBILIDAD_TB_SP(
    p_id_disponibilidad fide_disponibilidad_tb.id_disponibilidad%TYPE,
    p_dia fide_disponibilidad_tb.dia%TYPE,
    p_hora_inicio fide_disponibilidad_tb.hora_inicio%TYPE,
    p_hora_fin fide_disponibilidad_tb.hora_fin%TYPE,
    p_id_doctor fide_disponibilidad_tb.id_doctor%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_USUARIO_TB_SP(
    p_id_usuario fide_usuarios_tb.id_usuario%TYPE,
    p_nombre FIDE_USUARIOS_TB.NOMBRE%TYPE,
    p_primer_apellido fide_usuarios_tb.primer_apellido%TYPE,
    p_segundo_apellido fide_usuarios_tb.segundo_apellido%TYPE,
    p_correo FIDE_USUARIOS_TB.CORREO%TYPE,
    p_contrasena FIDE_USUARIOS_TB.CONTRASENA%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_ROL_TB_SP(
    p_id_rol fide_rol_tb.id_rol%TYPE,
    p_nombre fide_rol_tb.nombre%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_DOCTOR_TB_SP(
    p_id_doctor fide_doctores_tb.id_doctor%TYPE,
    p_telefono fide_doctores_tb.telefono%TYPE,
    p_numero_licencia fide_doctores_tb.numerol_licencia%TYPE,
    p_id_usuario fide_doctores_tb.id_usuario%TYPE,
    p_id_direccion fide_doctores_tb.id_direccion%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_PACIENTE_TB_SP(
    p_id_paciente fide_pacientes_tb.id_paciente%TYPE,
    p_fecha_nacimiento fide_pacientes_tb.fecha_nacimiento%TYPE,
    p_numero_seguro fide_pacientes_tb.numero_seguro%TYPE,
    p_direccion fide_pacientes_tb.direccion%TYPE,
    p_telefono fide_pacientes_tb.telefono%TYPE,
    p_id_usuario fide_pacientes_tb.id_usuario%TYPE,
    p_id_direccion fide_pacientes_tb.id_direccion%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_NOTIFICACION_TB_SP(
    p_id_notificacion fide_notificaciones_tb.id_notificacion%TYPE,
    p_mensaje fide_notificaciones_tb.mensaje%TYPE,
    p_tipo fide_notificaciones_tb.tipo%TYPE,
    p_fecha_envio fide_notificaciones_tb.fecha_envio%TYPE,
    p_id_usuario fide_notificaciones_tb.id_usuario%TYPE
);
PROCEDURE FIDE_ACTUALIZAR_HISTORIAL_CITA_TB_SP(
    p_id_historial fide_historial_citas_tb.id_historial%TYPE,
    p_id_cita fide_historial_citas_tb.id_cita%TYPE,
    p_fecha_cambio fide_historial_citas_tb.fecha_cambio%TYPE,
    p_id_estado_anterior fide_historial_citas_tb.id_estado_anterior%TYPE,
    p_id_estado_nuevo fide_historial_citas_tb.id_estado_nuevo%TYPE,
    p_observaciones fide_historial_citas_tb.observaciones%TYPE
);
PROCEDURE FIDE_DESACTIVAR_ESPECIALIDAD_TB_SP(
    p_id_especialidad fide_especialidades_tb.nombre%TYPE
);
PROCEDURE FIDE_DESACTIVAR_SUBESPECIALIDAD_TB_SP(
    p_id_subespecialidad fide_subespecialidad_tb.id_subespecialidad%TYPE
);
PROCEDURE FIDE_DESACTIVAR_SERVICIO_TB_SP(
    p_id_servicio fide_servicio_tb.id_servicio%TYPE
);
PROCEDURE FIDE_DESACTIVAR_PROCEDIMIENTO_TB_SP(
    p_id_procedimiento fide_procedimientos_tb.id_procedimiento%TYPE
);
PROCEDURE FIDE_DESACTIVAR_SERVICIO_ESPECIALIDAD_TB_SP(
    p_id_servicio fide_servicio_especialidad_tb.id_servicio%TYPE,
    p_id_especialidad fide_servicio_especialidad_tb.id_especialidad%TYPE
);
PROCEDURE FIDE_DESACTIVAR_TRATAMIENTO_TB_SP(
    p_id_tratamiento fide_tratamientos_tb.id_tratamiento%TYPE
);
PROCEDURE FIDE_DESACTIVAR_ESTADO_CITA_TB_SP(
    p_id_estado_cita fide_estados_citas_tb.id_estado_cita%TYPE
);
PROCEDURE FIDE_DESACTIVAR_CITA_TB_SP(
    p_id_cita fide_citas_tb.id_cita%TYPE
);
PROCEDURE FIDE_DESACTIVAR_COSTO_CITA_TB_SP(
    p_id_costo fide_costos_cita_tb.id_costo%TYPE
);
PROCEDURE FIDE_DESACTIVAR_CITA_TRATAMIENTO_TB_SP(
    p_id_cita fide_citas_tratamientos_tb.id_cita%TYPE,
    p_id_tratamiento fide_citas_tratamientos_tb.id_tratamiento%TYPE
);
PROCEDURE FIDE_DESACTIVAR_MEDICAMENTO_TB_SP(
    p_id_medicamento fide_medicamentos_tb.id_medicamento%TYPE
);
PROCEDURE FIDE_DESACTIVAR_INVENTARIO_TB_SP(
    p_id_inventario fide_inventario_medicamentos_tb.id_inventario%TYPE
);
PROCEDURE FIDE_DESACTIVAR_FACTURA_TB_SP(
    p_id_factura fide_facturas_tb.id_factura%TYPE
);
PROCEDURE FIDE_DESACTIVAR_TRATAMIENTO_PROCEDIMIENTO_TB_SP(
    p_id_tratamiento fide_tratamientos_procedimientos_tb.id_tratamiento%TYPE,
    p_id_procedimiento fide_tratamientos_procedimientos_tb.id_procedimiento%TYPE
);
PROCEDURE FIDE_DESACTIVAR_TRATAMIENTO_MEDICAMENTO_TB_SP(
    p_id_medicamento fide_tratamientos_medicamentos_tb.id_medicamento%TYPE,
    p_id_tratamiento fide_tratamientos_medicamentos_tb.id_tratamiento%TYPE
);
PROCEDURE FIDE_DESACTIVAR_PAIS_TB_SP(
    p_id_pais fide_paises_tb.id_pais%TYPE
);
PROCEDURE FIDE_DESACTIVAR_PROVINCIA_TB_SP(
    p_id_provincia fide_provincias_tb.id_provincia%TYPE
);
PROCEDURE FIDE_DESACTIVAR_CANTON_TB_SP(
    p_id_canton fide_cantones_tb.id_canton%TYPE
);
PROCEDURE FIDE_DESACTIVAR_DISTRITO_TB_SP(
    p_id_distrito fide_distritos_tb.id_distrito%TYPE
);
PROCEDURE FIDE_DESACTIVAR_DIRECCION_TB_SP(
    p_id_direccion fide_direccion_tb.id_direccion%TYPE
);
PROCEDURE FIDE_DESACTIVAR_DISPONIBILIDAD_TB_SP(
    p_id_disponibilidad fide_disponibilidad_tb.id_disponibilidad%TYPE
);
PROCEDURE FIDE_DESACTIVAR_USUARIO_TB_SP(
    p_id_usuario fide_usuarios_tb.id_usuario%TYPE
);
PROCEDURE FIDE_DESACTIVAR_ROL_TB_SP(
    p_id_rol fide_rol_tb.id_rol%TYPE
);
PROCEDURE FIDE_DESACTIVAR_DOCTOR_TB_SP(
    p_id_doctor fide_doctores_tb.id_doctor%TYPE
);
PROCEDURE FIDE_DESACTIVAR_PACIENTE_TB_SP(
    p_id_paciente fide_pacientes_tb.id_paciente%TYPE
);
PROCEDURE FIDE_DESACTIVAR_NOTIFICACION_TB_SP(
    p_id_notificacion fide_notificaciones_tb.id_notificacion%TYPE
);
PROCEDURE FIDE_DESACTIVAR_USUARIO_ROL_TB_SP(
    p_id_rol fide_usuario_rol_tb.id_usuario%TYPE,
    p_id_usuario fide_usuario_rol_tb.id_rol%TYPE
);
PROCEDURE FIDE_DESACTIVAR_DOCTOR_ESPECIALIDAD_TB_SP(
    p_id_especialidad fide_doctores_especialidades_tb.id_especialidad%TYPE,
    p_id_doctor fide_doctores_especialidades_tb.id_doctor%TYPE
);
PROCEDURE FIDE_DESACTIVAR_HISTORIAL_CITA_TB_SP(
    p_id_historial fide_historial_citas_tb.id_historial%TYPE
);
END FIDE_HOSPITAL_MILAGRO_PKG;