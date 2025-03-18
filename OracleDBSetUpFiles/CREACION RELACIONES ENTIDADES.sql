-- CREACION DE RELACIONES ENTRE LAS ENTIDADES

-- Agregar la FK de Notificaciones ? Usuarios
ALTER TABLE Notificaciones
  ADD CONSTRAINT fk_notif_usuarios
  FOREIGN KEY (id_usuario)
  REFERENCES Usuarios (id_usuario);
