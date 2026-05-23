USE colegio;

-- =========================
-- PERSONAS
-- =========================
INSERT IGNORE INTO Persona VALUES
('40111222', 'Juan', 'Perez', '2005-03-10', 'Av. Sarmiento 123', '3624001111', 'juan@gmail.com'),
('40222333', 'Maria', 'Gomez', '2006-07-15', 'Calle 10', '3624002222', 'maria@gmail.com'),
('30111444', 'Carlos', 'Lopez', '1980-09-20', 'Av. Alberdi 500', '3624003333', 'carlos@gmail.com'),
('28999888', 'Ana', 'Martinez', '1978-12-01', 'Belgrano 250', '3624004444', 'ana@gmail.com'),
('35666777', 'Pedro', 'Ramirez', '1990-05-18', 'Mitre 890', '3624005555', 'pedro@gmail.com');

-- =========================
-- DOCENTE
-- =========================
INSERT IGNORE INTO Docente (dni, titulo, especialidad, fecha_ingreso, usuario, contrasena)
VALUES
('30111444', 'Lic. Matemática', 'Matemática', '2015-03-01', 'carlosl', '1234');

-- =========================
-- PRECEPTOR
-- =========================
INSERT IGNORE INTO Preceptor (dni, turno, fecha_ingreso, usuario, contrasena)
VALUES
('28999888', 'Mañana', '2018-04-10', 'anam', '1234');

-- =========================
-- AULA
-- =========================
INSERT IGNORE INTO Aula (nombre, numero, piso, capacidad, tipo, estado)
VALUES
('Aula A', 1, 1, 30, 'Teórica', 'Disponible'),
('Laboratorio', 2, 1, 20, 'Práctica', 'Disponible');

-- =========================
-- CURSO
-- =========================
INSERT IGNORE INTO Curso (comision, turno, nivel, cupo_maximo, legajo_preceptor, id_aula)
VALUES
('1A', 'Mañana', 'Secundario', 30, 1, 1);

-- =========================
-- ALUMNO
-- =========================
INSERT IGNORE INTO Alumno (dni, anio_cursado, fecha_ingreso, usuario, contrasena, id_curso)
VALUES
('40111222', 5, '2023-03-01', 'juanp', '1234', 1),
('40222333', 4, '2024-03-01', 'mariag', '1234', 1);

-- =========================
-- TUTOR
-- =========================
INSERT IGNORE INTO Tutor (legajo_alumno, parentesco, telefono_contacto, email_contacto)
VALUES
(1, 'Padre', '3624555555', 'padrejuan@gmail.com'),
(2, 'Madre', '3624666666', 'madremaria@gmail.com');

-- =========================
-- PERSONAL ADMINISTRATIVO
-- =========================
INSERT IGNORE INTO Personal_Administrativo
(dni, sector, cargo, fecha_ingreso, usuario, contrasena)
VALUES
('35666777', 'Secretaría', 'Administrador', '2020-02-15', 'pedror', '1234');

-- =========================
-- MATERIA
-- =========================
INSERT IGNORE INTO Materia (nombre, descripcion, carga_horaria, cantidad_clases)
VALUES
('Matemática', 'Álgebra y geometría', 6, 3),
('Historia', 'Historia argentina', 4, 2);

-- =========================
-- INSCRIPCION
-- =========================
INSERT IGNORE INTO Inscripcion (fecha_inscripcion, estado, id_curso, legajo_alumno)
VALUES
('2025-02-20', 'Activa', 1, 1),
('2025-02-20', 'Activa', 1, 2);

-- =========================
-- ASISTENCIA
-- =========================
INSERT IGNORE INTO Asistencia (legajo_alumno, fecha, observacion)
VALUES
(1, '2025-05-10', 'Presente'),
(2, '2025-05-10', 'Llegó tarde');

-- =========================
-- CALIFICACION
-- =========================
INSERT IGNORE INTO Calificacion
(nota, tipo_evaluacion, fecha, id_materia, legajo_alumno)
VALUES
(8.50, 'Parcial', '2025-05-01', 1, 1),
(7.00, 'Trabajo Práctico', '2025-05-02', 2, 2);

-- =========================
-- TURNO
-- =========================
INSERT IGNORE INTO Turno (nombre, hora_inicio, hora_fin)
VALUES
('Mañana', '07:00:00', '12:00:00'),
('Tarde', '13:00:00', '18:00:00');

-- =========================
-- CUOTA
-- =========================
INSERT IGNORE INTO Cuota
(periodo, monto, fecha_vencimiento, estado, fecha_pago, medio_pago, fecha_emision_factura, pagada)
VALUES
('2025-05', 15000, '2025-05-10', 'Pagada', '2025-05-08', 'Transferencia', '2025-05-01', TRUE),
('2025-06', 15000, '2025-06-10', 'Pendiente', NULL, NULL, '2025-06-01', FALSE);

-- =========================
-- INSTALACION
-- =========================
INSERT IGNORE INTO Instalacion (nombre, capacidad, estado)
VALUES
('Gimnasio', 100, 'Disponible'),
('Cancha', 50, 'Ocupada');

-- =========================
-- SOLICITANTE
-- =========================
INSERT IGNORE INTO Solicitante (nombre, email, telefono)
VALUES
('Lucas Fernandez', 'lucas@gmail.com', '3624777777');

-- =========================
-- RESERVA
-- =========================
INSERT IGNORE INTO Reserva
(nombre, hora_inicio, hora_fin, legajo_personal, id_solicitante)
VALUES
('Reserva Gimnasio', '09:00:00', '11:00:00', 1, 1);

-- =========================
-- DISCIPLINA DEPORTIVA
-- =========================
INSERT IGNORE INTO Disciplina_Deportiva (nombre, categoria, descripcion)
VALUES
('Fútbol', 'Juvenil', 'Entrenamiento y torneos');

-- =========================
-- VEHICULO
-- =========================
INSERT IGNORE INTO Vehiculo (patente, modelo, capacidad, estado)
VALUES
('AB123CD', 'Mercedes Sprinter', 20, 'Disponible');

-- =========================
-- SOLICITUD VIAJE
-- =========================
INSERT IGNORE INTO Solicitud_Viaje
(fecha_solicitud, estado, observaciones, legajo_docente)
VALUES
('2025-04-15', 'Aprobada', 'Viaje educativo', 1);

-- =========================
-- VIAJE
-- =========================
INSERT IGNORE INTO Viaje
(tipo, fecha_salida, fecha_regreso, motivo, id_solicitud)
VALUES
('Educativo', '2025-06-10', '2025-06-12', 'Visita al museo', 1);

-- =========================
-- NOTICIA
-- =========================
INSERT IGNORE INTO Noticia
(titulo, contenido, fecha_publicacion, legajo_personal)
VALUES
('Inicio de clases', 'Las clases comienzan el 5 de marzo.', '2025-03-01', 1);

-- =========================
-- CERTIFICADO
-- =========================
INSERT IGNORE INTO Certificado
(tipo, fecha_emision, descripcion, dni_persona)
VALUES
('Alumno Regular', '2025-05-01', 'Certifica regularidad', '40111222');

-- =========================
-- TABLAS INTERMEDIAS
-- =========================

INSERT IGNORE INTO Vehiculo_Viaje VALUES
(1, 1);

INSERT IGNORE INTO Curso_Viaje VALUES
(1, 1);

INSERT IGNORE INTO Reserva_Instalacion VALUES
(1, 1, '2025-05-25 09:00:00');

INSERT IGNORE INTO Curso_Materia VALUES
(1, 1, '2025-05-26 08:00:00'),
(1, 2, '2025-05-27 10:00:00');

INSERT IGNORE INTO Alumno_Calificacion VALUES
(1, 1),
(2, 2);

INSERT IGNORE INTO Docente_Materia VALUES
(1, 1);

INSERT IGNORE INTO Alumno_Cuota VALUES
(1, 1),
(2, 2);