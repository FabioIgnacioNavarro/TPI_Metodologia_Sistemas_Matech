-- ============================================================
--  CARGA DE DATOS DE PRUEBA — BD colegio
--  Orden respeta dependencias de claves foráneas
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;

-- ------------------------------------------------------------
-- 1. USUARIO
-- ------------------------------------------------------------
INSERT IGNORE INTO `usuario` (`id`, `nombre_usuario`, `contrasenia`, `correo`) VALUES
(1,  'jgomez',       'pass1234',   'jgomez@colegio.edu.ar'),
(2,  'mrodriguez',   'pass1234',   'mrodriguez@colegio.edu.ar'),
(3,  'lfernandez',   'pass1234',   'lfernandez@colegio.edu.ar'),
(4,  'clopez',       'pass1234',   'clopez@colegio.edu.ar'),
(5,  'pmartinez',    'pass1234',   'pmartinez@colegio.edu.ar'),
(6,  'asanchez',     'pass1234',   'asanchez@colegio.edu.ar'),
(7,  'rperez',       'pass1234',   'rperez@colegio.edu.ar'),
(8,  'ndiaz',        'pass1234',   'ndiaz@colegio.edu.ar'),
(9,  'sgil',         'pass1234',   'sgil@colegio.edu.ar'),
(10, 'emorales',     'pass1234',   'emorales@colegio.edu.ar');

-- ------------------------------------------------------------
-- 2. PERSONA
-- ------------------------------------------------------------
INSERT IGNORE INTO `persona` (`id`, `id_usuario`, `dni`, `nombre`, `apellido`, `fecha_nacimiento`, `direccion`, `telefono`, `email`) VALUES
-- Alumnos
(1,  1,  '40123456', 'Juan',      'Gómez',      '2008-03-14', 'Mitre 123',       '3624-100001', 'jgomez@mail.com'),
(2,  2,  '40234567', 'María',     'Rodríguez',  '2008-07-22', 'Belgrano 456',    '3624-100002', 'mrodriguez@mail.com'),
(3,  3,  '40345678', 'Lucas',     'Fernández',  '2009-01-05', 'Salta 789',       '3624-100003', 'lfernandez@mail.com'),
-- Docentes
(4,  4,  '30456789', 'Carlos',    'López',      '1985-05-10', 'San Martín 321',  '3624-200001', 'clopez@mail.com'),
(5,  5,  '31567890', 'Patricia',  'Martínez',   '1980-09-30', 'Rivadavia 654',   '3624-200002', 'pmartinez@mail.com'),
-- Preceptor
(6,  6,  '28678901', 'Andrea',    'Sánchez',    '1975-12-01', 'Tucumán 987',     '3624-300001', 'asanchez@mail.com'),
-- Tutores
(7,  7,  '25789012', 'Roberto',   'Pérez',      '1970-04-18', 'Corrientes 111',  '3624-400001', 'rperez@mail.com'),
(8,  8,  '26890123', 'Nora',      'Díaz',       '1972-08-25', 'Entre Ríos 222',  '3624-400002', 'ndiaz@mail.com'),
-- Personal administrativo
(9,  9,  '29901234', 'Sergio',    'Gil',        '1978-02-14', 'Santa Fe 333',    '3624-500001', 'sgil@mail.com'),
-- Directivo
(10, 10, '27012345', 'Elena',     'Morales',    '1968-11-20', 'Chaco 444',       '3624-600001', 'emorales@mail.com');

-- ------------------------------------------------------------
-- 3. AULA
-- ------------------------------------------------------------
INSERT IGNORE INTO `aula` (`id_aula`, `nombre`, `numero`, `piso`, `capacidad`, `tipo`, `estado`) VALUES
(1, 'Aula A',     101, 1, 30, 'Teórica',  'Disponible'),
(2, 'Aula B',     102, 1, 30, 'Teórica',  'Disponible'),
(3, 'Lab. Info',  201, 2, 25, 'Laboratorio', 'Disponible');

-- ------------------------------------------------------------
-- 4. PRECEPTOR
-- ------------------------------------------------------------
INSERT IGNORE INTO `preceptor` (`legajo`, `id_persona`, `turno`, `fecha_ingreso`) VALUES
(1, 6, 'Mañana', '2015-03-01');

-- ------------------------------------------------------------
-- 5. CURSO
-- ------------------------------------------------------------
INSERT IGNORE INTO `curso` (`id_curso`, `comision`, `turno`, `nivel`, `cupo_maximo`, `legajo_preceptor`, `id_aula`) VALUES
(1, 'A', 'Mañana', 'Secundario', 30, 1, 1),
(2, 'B', 'Tarde',  'Secundario', 30, 1, 2);

-- ------------------------------------------------------------
-- 6. ALUMNO
-- ------------------------------------------------------------
INSERT IGNORE INTO `alumno` (`legajo`, `id_persona`, `anio_cursado`, `fecha_ingreso`, `id_curso`) VALUES
(1, 1, 2024, '2024-03-01', 1),
(2, 2, 2024, '2024-03-01', 1),
(3, 3, 2024, '2024-03-01', 2);

-- ------------------------------------------------------------
-- 7. DOCENTE
-- ------------------------------------------------------------
INSERT IGNORE INTO `docente` (`legajo`, `id_persona`, `titulo`, `especialidad`, `fecha_ingreso`) VALUES
(1, 4, 'Profesor en Matemática',  'Matemática',  '2010-03-01'),
(2, 5, 'Profesora en Literatura', 'Literatura',  '2012-03-01');

-- ------------------------------------------------------------
-- 8. MATERIA
-- ------------------------------------------------------------
INSERT IGNORE INTO `materia` (`id_materia`, `nombre`, `descripcion`, `carga_horaria`, `cantidad_clases`) VALUES
(1, 'Matemática',  'Álgebra y geometría analítica', 5, 80),
(2, 'Literatura',  'Literatura argentina y universal', 4, 64),
(3, 'Informática', 'Fundamentos de programación',   3, 48);

-- ------------------------------------------------------------
-- 9. DOCENTE_DICTA_MATERIA
-- ------------------------------------------------------------
INSERT IGNORE INTO `docente_dicta_materia` (`id`, `id_docente`, `id_materia`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 1, 3);

-- ------------------------------------------------------------
-- 10. CURSO_CURSA_MATERIAS
-- ------------------------------------------------------------
INSERT IGNORE INTO `curso_cursa_materias` (`id`, `id_curso`, `id_materia`, `horarios`) VALUES
(1, 1, 1, '{"lunes":"08:00-09:40","miercoles":"08:00-09:40"}'),
(2, 1, 2, '{"martes":"08:00-09:20","jueves":"08:00-09:20"}'),
(3, 2, 1, '{"lunes":"14:00-15:40","miercoles":"14:00-15:40"}'),
(4, 2, 3, '{"viernes":"14:00-16:00"}');

-- ------------------------------------------------------------
-- 11. INSCRIPCION
-- ------------------------------------------------------------
INSERT IGNORE INTO `inscripcion` (`id_inscripcion`, `fecha_inscripcion`, `estado`, `id_curso`, `legajo_alumno`) VALUES
(1, '2024-02-20', 'Activa', 1, 1),
(2, '2024-02-20', 'Activa', 1, 2),
(3, '2024-02-21', 'Activa', 2, 3);

-- ------------------------------------------------------------
-- 12. CALIFICACION
-- ------------------------------------------------------------
INSERT IGNORE INTO `calificacion` (`id_calificacion`, `nota`, `tipo_evaluacion`, `fecha`, `id_materia`, `legajo_alumno`) VALUES
(1,  8.50, 'Parcial',    '2024-05-10', 1, 1),
(2,  7.00, 'Parcial',    '2024-05-10', 1, 2),
(3,  9.25, 'Parcial',    '2024-05-10', 2, 1),
(4,  6.75, 'Parcial',    '2024-05-10', 2, 2),
(5,  10.0, 'Trabajo Práctico', '2024-06-01', 1, 3),
(6,  8.00, 'Parcial',    '2024-05-15', 3, 3);

-- ------------------------------------------------------------
-- 13. ASISTENCIA
-- ------------------------------------------------------------
INSERT IGNORE INTO `asistencia` (`id_asistencia`, `legajo_alumno`, `fecha`, `observacion`) VALUES
(1, 1, '2024-04-08', 'Presente'),
(2, 2, '2024-04-08', 'Ausente con aviso'),
(3, 3, '2024-04-08', 'Presente'),
(4, 1, '2024-04-10', 'Presente'),
(5, 2, '2024-04-10', 'Presente'),
(6, 3, '2024-04-10', 'Tardanza');

-- ------------------------------------------------------------
-- 14. TUTOR
-- ------------------------------------------------------------
INSERT IGNORE INTO `tutor` (`id`, `id_persona`, `telefono_contacto`, `email_contacto`) VALUES
(1, 7, '3624-400001', 'rperez@mail.com'),
(2, 8, '3624-400002', 'ndiaz@mail.com');

-- ------------------------------------------------------------
-- 15. TUTOR_TUTORA_ALUMNO
-- ------------------------------------------------------------
INSERT IGNORE INTO `tutor_tutora_alumno` (`id`, `id_tutor`, `id_alumno`, `tipo_parentesco`) VALUES
(1, 1, 1, 'Padre'),
(2, 2, 2, 'Madre'),
(3, 1, 3, 'Tío');

-- ------------------------------------------------------------
-- 16. CUOTA
-- ------------------------------------------------------------
INSERT IGNORE INTO `cuota` (`id_cuota`, `periodo`, `monto`, `fecha_vencimiento`, `estado`, `fecha_pago`, `medio_pago`, `fecha_emision_factura`, `pagada`, `id_tutor`, `id_legajo_alumno`) VALUES
(1, '2024-04', 15000.00, '2024-04-10', 'Pagada',   '2024-04-08', 'Transferencia', '2024-04-01', 1, 1, 1),
(2, '2024-05', 15000.00, '2024-05-10', 'Pagada',   '2024-05-09', 'Efectivo',      '2024-05-01', 1, 1, 1),
(3, '2024-06', 15000.00, '2024-06-10', 'Pendiente', NULL,         NULL,            '2024-06-01', 0, 1, 1),
(4, '2024-04', 15000.00, '2024-04-10', 'Pagada',   '2024-04-07', 'Transferencia', '2024-04-01', 1, 2, 2),
(5, '2024-05', 15000.00, '2024-05-10', 'Vencida',  NULL,          NULL,            '2024-05-01', 0, 2, 2);

-- ------------------------------------------------------------
-- 17. INSTALACION
-- ------------------------------------------------------------
INSERT IGNORE INTO `instalacion` (`id`, `nombre`, `capacidad`, `estado`) VALUES
(1, 'Gimnasio',        200, 'Disponible'),
(2, 'SUM',             150, 'Disponible'),
(3, 'Cancha de fútbol', 100, 'En mantenimiento');

-- ------------------------------------------------------------
-- 18. PERSONAL ADMINISTRATIVO
-- ------------------------------------------------------------
INSERT IGNORE INTO `personal_administrativo` (`legajo`, `id_persona`, `sector`, `cargo`, `fecha_ingreso`) VALUES
(1, 9, 'Secretaría', 'Secretario', '2016-03-01');

-- ------------------------------------------------------------
-- 19. DIRECTIVO
-- ------------------------------------------------------------
INSERT IGNORE INTO `directivo` (`id`, `id_persona`) VALUES
(1, 10);

-- ------------------------------------------------------------
-- 20. RESERVA
-- ------------------------------------------------------------
INSERT IGNORE INTO `reserva` (`id`, `nombre`, `hora_inicio`, `hora_fin`, `legajo_personal_evaluador`, `id_persona_solicitante`, `id_instalacion`) VALUES
(1, 'Acto escolar Día del Maestro', '08:00:00', '12:00:00', 1, 10, 2),
(2, 'Clase de Educación Física 1A', '10:00:00', '11:30:00', 1,  4, 1);

-- ------------------------------------------------------------
-- 21. VEHICULO
-- ------------------------------------------------------------
INSERT IGNORE INTO `vehiculo` (`id_vehiculo`, `patente`, `modelo`, `capacidad`, `estado`) VALUES
(1, 'AB123CD', 'Mercedes Sprinter', 19, 'Disponible'),
(2, 'EF456GH', 'Ford Transit',      15, 'Disponible');

-- ------------------------------------------------------------
-- 22. SOLICITUD_VIAJE
-- ------------------------------------------------------------
INSERT IGNORE INTO `solicitud_viaje` (`id_solicitud`, `fecha_solicitud`, `estado`, `observaciones`, `legajo_docente`) VALUES
(1, '2024-08-01', 'Aprobada', 'Visita al Museo del Hombre Chaqueño', 1),
(2, '2024-09-10', 'Pendiente', 'Campamento fin de año 2do', 2);

-- ------------------------------------------------------------
-- 23. VIAJE
-- ------------------------------------------------------------
INSERT IGNORE INTO `viaje` (`id_viaje`, `tipo`, `fecha_salida`, `fecha_regreso`, `motivo`, `id_solicitud`) VALUES
(1, 'Educativo', '2024-08-15', '2024-08-15', 'Visita al Museo del Hombre Chaqueño', 1);

-- ------------------------------------------------------------
-- 24. VIAJE_UTILIZA_VEHICULO
-- ------------------------------------------------------------
INSERT IGNORE INTO `viaje_utiliza_vehiculo` (`id`, `id_viaje`, `id_vehiculo`, `fecha_uso`) VALUES
(1, 1, 1, '2024-08-15');

-- ------------------------------------------------------------
-- 25. CURSO_PARTICIPA_VIAJE
-- ------------------------------------------------------------
INSERT IGNORE INTO `curso_participa_viaje` (`id`, `id_curso`, `id_viaje`) VALUES
(1, 1, 1);

-- ------------------------------------------------------------
-- 26. NOTICIA
-- ------------------------------------------------------------

INSERT IGNORE INTO `noticia`
(
    `id_noticia`,
    `titulo`,
    `contenido`,
    `fecha_publicacion`,
    `legajo_personal`,
    `imagen`
)
VALUES
(
    1,
    'Inicio del ciclo lectivo 2024',
    'Se informa a la comunidad educativa que el ciclo lectivo 2024 comenzará el 4 de marzo. Los alumnos deberán presentarse con el uniforme reglamentario.',
    '2024-02-28',
    1,
    'noticias/noticia4.jpg'
),
(
    2,
    'Entrega de boletines — 1er trimestre',
    'El viernes 28 de junio se realizará la entrega de boletines correspondientes al primer trimestre. Se cita a los tutores a las 17:00 hs.',
    '2024-06-20',
    1,
    'noticias/noticia5.jpg'
),
(
    3,
    'Jornada deportiva',
    'Se realizará una jornada recreativa y deportiva para promover el trabajo en equipo y la vida saludable.',
    '2024-09-10',
    1,
    'noticias/noticia2.jpg'
),
(
    4,
    'Nuevos laboratorios',
    'El centro educativo incorporó nuevos equipos tecnológicos para fortalecer las actividades de informática y ciencias.',
    '2024-09-15',
    1,
    'noticias/noticia3.jpg'
),
(
    5,
    'Inscripciones 2027',
    'Ya se encuentran abiertas las inscripciones para el ciclo lectivo 2027 en nivel inicial, primario y secundario.',
    '2024-10-01',
    1,
    'noticias/noticia1.jpg'
);

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
--  FIN DE LA CARGA
-- ============================================================
