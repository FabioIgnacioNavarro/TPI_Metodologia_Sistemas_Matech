-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-06-2026 a las 03:17:32
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `colegio`
--
CREATE DATABASE IF NOT EXISTS `colegio` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `colegio`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

DROP TABLE IF EXISTS `alumno`;
CREATE TABLE `alumno` (
  `legajo` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `id_curso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`legajo`, `id_persona`, `fecha_ingreso`, `id_curso`) VALUES
(1, 1, 2024, 1),
(2, 2, 2024, 1),
(3, 3, 2024, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

DROP TABLE IF EXISTS `asistencia`;
CREATE TABLE `asistencia` (
  `id_asistencia` int(11) NOT NULL,
  `legajo_alumno` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `tipo_asistencia` enum('Presente','Ausente','Tardanza') NOT NULL,
  `archivo_justificacion` VARCHAR(255) NULL,
  `observacion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asistencia`
--

INSERT INTO `asistencia`
(
    `id_asistencia`,
    `legajo_alumno`,
    `fecha`,
    `tipo_asistencia`,
    `archivo_justificacion`,
    `observacion`
)
VALUES
(
    1,
    1,
    '2026-06-16',
    'Ausente',
    NULL,
    'Falta justificada por enfermedad.'
),
(
    2,
    2,
    '2026-06-16',
    'Tardanza',
    NULL,
    'Llegó 15 minutos tarde.'
),
(
    3,
    1,
    '2026-06-17',
    'Ausente',
    'justificaciones/Juan_Gómez_1A_2026-06-17_20260618_010457.png',
    'Presentó certificado médico.'
),
(
    4,
    3,
    '2026-06-18',
    'Ausente',
    NULL,
    'Ausencia por trámite familiar.'
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula`
--

DROP TABLE IF EXISTS `aula`;
CREATE TABLE `aula` (
  `id_aula` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `numero` int(11) DEFAULT NULL,
  `piso` int(11) DEFAULT NULL,
  `capacidad` int(11) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aula`
--

INSERT INTO `aula` (`id_aula`, `nombre`, `numero`, `piso`, `capacidad`, `tipo`, `estado`) VALUES
(1, 'Aula A', 101, 1, 30, 'Teórica', 'Disponible'),
(2, 'Aula B', 102, 1, 30, 'Teórica', 'Disponible'),
(3, 'Lab. Info', 201, 2, 25, 'Laboratorio', 'Disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificacion`
--

DROP TABLE IF EXISTS `calificacion`;
CREATE TABLE `calificacion` (
  `id_calificacion` int(11) NOT NULL,
  `nota` decimal(4,2) NOT NULL,
  `tipo_evaluacion` varchar(50) DEFAULT NULL,
  `fecha` date NOT NULL,
  `id_materia` int(11) NOT NULL,
  `legajo_alumno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calificacion`
--

INSERT INTO `calificacion` (`id_calificacion`, `nota`, `tipo_evaluacion`, `fecha`, `id_materia`, `legajo_alumno`) VALUES
(1, 8.50, 'Parcial', '2024-05-10', 1, 1),
(2, 7.00, 'Parcial', '2024-05-10', 1, 2),
(3, 9.25, 'Parcial', '2024-05-10', 2, 1),
(4, 6.75, 'Parcial', '2024-05-10', 2, 2),
(5, 10.00, 'Trabajo Práctico', '2024-06-01', 1, 3),
(6, 8.00, 'Parcial', '2024-05-15', 3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuota`
--

DROP TABLE IF EXISTS `cuota`;
CREATE TABLE `cuota` (
  `id_cuota` int(11) NOT NULL,
  `periodo` varchar(20) DEFAULT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `estado` varchar(30) NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `medio_pago` varchar(50) DEFAULT NULL,
  `fecha_emision_factura` date NOT NULL,
  `pagada` tinyint(1) NOT NULL DEFAULT 0,
  `id_tutor` int(11) NOT NULL,
  `id_legajo_alumno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuota`
--

INSERT INTO `cuota` (`id_cuota`, `periodo`, `monto`, `fecha_vencimiento`, `estado`, `fecha_pago`, `medio_pago`, `fecha_emision_factura`, `pagada`, `id_tutor`, `id_legajo_alumno`) VALUES
(1, '2024-04', 15000.00, '2024-04-10', 'Pagada', '2024-04-08', 'Transferencia', '2024-04-01', 1, 1, 1),
(2, '2024-05', 15000.00, '2024-05-10', 'Pagada', '2024-05-09', 'Efectivo', '2024-05-01', 1, 1, 1),
(3, '2024-06', 15000.00, '2024-06-10', 'Pendiente', NULL, NULL, '2024-06-01', 0, 1, 1),
(4, '2024-04', 15000.00, '2024-04-10', 'Pagada', '2024-04-07', 'Transferencia', '2024-04-01', 1, 2, 2),
(5, '2024-05', 15000.00, '2024-05-10', 'Vencida', NULL, NULL, '2024-05-01', 0, 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

DROP TABLE IF EXISTS `curso`;
CREATE TABLE `curso` (
  `id` int(11) NOT NULL,
  `comision` varchar(20) NOT NULL,
  `anio` int(2) NOT NULL,
  `turno` varchar(30) NOT NULL,
  `nivel` varchar(30) NOT NULL,
  `cupo_maximo` int(11) DEFAULT NULL,
  `legajo_preceptor` int(11) DEFAULT NULL,
  `id_aula` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`id`, `comision`, `anio`, `turno`, `nivel`, `cupo_maximo`, `legajo_preceptor`, `id_aula`) VALUES
(1, 'A', 1, 'Mañana', 'Secundario', 30, 1, 1),
(2, 'B', 2, 'Tarde', 'Secundario', 30, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_cursa_materias`
--

DROP TABLE IF EXISTS `curso_cursa_materias`;
CREATE TABLE `curso_cursa_materias` (
  `id` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `horarios` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso_cursa_materias`
--

INSERT INTO `curso_cursa_materias` (`id`, `id_curso`, `id_materia`, `horarios`) VALUES
(1, 1, 1, '{\"lunes\":\"08:00-09:40\",\"miercoles\":\"08:00-09:40\"}'),
(2, 1, 2, '{\"martes\":\"08:00-09:20\",\"jueves\":\"08:00-09:20\"}'),
(3, 2, 1, '{\"lunes\":\"14:00-15:40\",\"miercoles\":\"14:00-15:40\"}'),
(4, 2, 3, '{\"viernes\":\"14:00-16:00\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_participa_viaje`
--

DROP TABLE IF EXISTS `curso_participa_viaje`;
CREATE TABLE `curso_participa_viaje` (
  `id` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `id_viaje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso_participa_viaje`
--

INSERT INTO `curso_participa_viaje` (`id`, `id_curso`, `id_viaje`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `directivo`
--

DROP TABLE IF EXISTS `directivo`;
CREATE TABLE `directivo` (
  `id` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `directivo`
--

INSERT INTO `directivo` (`id`, `id_persona`) VALUES
(1, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-06-04 23:48:50.597734'),
(2, 'auth', '0001_initial', '2026-06-04 23:48:51.057853'),
(3, 'admin', '0001_initial', '2026-06-04 23:48:51.176182'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-06-04 23:48:51.188240'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-06-04 23:48:51.204904'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-06-04 23:48:51.272454'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-06-04 23:48:51.329311'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-06-04 23:48:51.347176'),
(9, 'auth', '0004_alter_user_username_opts', '2026-06-04 23:48:51.358131'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-06-04 23:48:51.412561'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-06-04 23:48:51.418467'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-06-04 23:48:51.433214'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-06-04 23:48:51.452441'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-06-04 23:48:51.471227'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-06-04 23:48:51.491291'),
(16, 'auth', '0011_update_proxy_permissions', '2026-06-04 23:48:51.504236'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-06-04 23:48:51.522094'),
(18, 'sessions', '0001_initial', '2026-06-04 23:48:51.560957');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('sm89xx3ogxizw84oxqp9ruphlsi1w4ab', 'eyJ1c3VhcmlvX2lkIjo4fQ:1wXPRY:CMtCppyIR31_DUPY_sAX1GRsz4rszXcN9JSOIYDGN9k', '2026-06-24 20:22:32.725830');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente`
--

DROP TABLE IF EXISTS `docente`;
CREATE TABLE `docente` (
  `legajo` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `docente`
--

INSERT INTO `docente` (`legajo`, `id_persona`, `titulo`, `especialidad`, `fecha_ingreso`) VALUES
(1, 4, 'Profesor en Matemática', 'Matemática', '2010-03-01'),
(2, 5, 'Profesora en Literatura', 'Literatura', '2012-03-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente_dicta_materia`
--

DROP TABLE IF EXISTS `docente_dicta_materia`;
CREATE TABLE `docente_dicta_materia` (
  `id` int(11) NOT NULL,
  `id_docente` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `docente_dicta_materia`
--

INSERT INTO `docente_dicta_materia` (`id`, `id_docente`, `id_materia`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripcion`
--

DROP TABLE IF EXISTS `inscripcion`;
CREATE TABLE `inscripcion` (
  `id_inscripcion` int(11) NOT NULL,
  `fecha_inscripcion` date NOT NULL,
  `estado` varchar(30) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `legajo_alumno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inscripcion`
--

INSERT INTO `inscripcion` (`id_inscripcion`, `fecha_inscripcion`, `estado`, `id_curso`, `legajo_alumno`) VALUES
(1, '2024-02-20', 'Activa', 1, 1),
(2, '2024-02-20', 'Activa', 1, 2),
(3, '2024-02-21', 'Activa', 2, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud_inscripcion`
--

CREATE TABLE solicitud_inscripcion (
    id_solicitud INT AUTO_INCREMENT PRIMARY KEY,

    nombre_alumno VARCHAR(100) NOT NULL,
    apellido_alumno VARCHAR(50) NOT NULL,
    dni_alumno VARCHAR(8) NOT NULL,
    fecha_nacimiento DATE NOT NULL,

    nombre_tutor VARCHAR(100) NOT NULL,
    apellido_tutor VARCHAR(50) NOT NULL,
    dni_tutor VARCHAR(8) NOT NULL,

    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,

    nivel VARCHAR(20) NOT NULL,
    turno VARCHAR(20) NOT NULL,

    observaciones TEXT NULL,

    fecha_solicitud DATETIME NOT NULL,

    estado VARCHAR(20) DEFAULT 'Pendiente',

    direccion VARCHAR(100) NULL,
    telefono_alumno VARCHAR(20) NULL,
    email_alumno VARCHAR(100) NULL,

    parentesco VARCHAR(30) NULL,

    direccion_tutor VARCHAR(255) NULL
) 

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instalacion`
--

DROP TABLE IF EXISTS `instalacion`;
CREATE TABLE `instalacion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `instalacion`
--

INSERT INTO `instalacion` (`id`, `nombre`, `capacidad`, `estado`) VALUES
(1, 'Gimnasio', 200, 'Disponible'),
(2, 'SUM', 150, 'Disponible'),
(3, 'Cancha de fútbol', 100, 'En mantenimiento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

DROP TABLE IF EXISTS `materia`;
CREATE TABLE `materia` (
  `id_materia` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `carga_horaria` int(11) NOT NULL,
  `cantidad_clases` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`id_materia`, `nombre`, `descripcion`, `carga_horaria`, `cantidad_clases`) VALUES
(1, 'Matemática', 'Álgebra y geometría analítica', 5, 80),
(2, 'Literatura', 'Literatura argentina y universal', 4, 64),
(3, 'Informática', 'Fundamentos de programación', 3, 48);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticia`
--

DROP TABLE IF EXISTS `noticia`;
CREATE TABLE `noticia` (
  `id_noticia` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `contenido` text NOT NULL,
  `fecha_publicacion` date NOT NULL,
  `legajo_personal` int(11) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `noticia`
--

INSERT INTO `noticia`
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
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `dni` varchar(8) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id`, `id_usuario`, `dni`, `nombre`, `apellido`, `fecha_nacimiento`, `direccion`, `telefono`, `email`) VALUES
(1, 1, '40123456', 'Juan', 'Gómez', '2008-03-14', 'Mitre 123', '3624-100001', 'jgomez@mail.com'),
(2, 2, '40234567', 'María', 'Rodríguez', '2008-07-22', 'Belgrano 456', '3624-100002', 'mrodriguez@mail.com'),
(3, 3, '40345678', 'Lucas', 'Fernández', '2009-01-05', 'Salta 789', '3624-100003', 'lfernandez@mail.com'),
(4, 4, '30456789', 'Carlos', 'López', '1985-05-10', 'San Martín 321', '3624-200001', 'clopez@mail.com'),
(5, 5, '31567890', 'Patricia', 'Martínez', '1980-09-30', 'Rivadavia 654', '3624-200002', 'pmartinez@mail.com'),
(6, 6, '28678901', 'Andrea', 'Sánchez', '1975-12-01', 'Tucumán 987', '3624-300001', 'asanchez@mail.com'),
(7, 7, '25789012', 'Roberto', 'Pérez', '1970-04-18', 'Corrientes 111', '3624-400001', 'rperez@mail.com'),
(8, 8, '26890123', 'Nora', 'Díaz', '1972-08-25', 'Entre Ríos 222', '3624-400002', 'ndiaz@mail.com'),
(9, 9, '29901234', 'Sergio', 'Gil', '1978-02-14', 'Santa Fe 333', '3624-500001', 'sgil@mail.com'),
(10, 10, '27012345', 'Elena', 'Morales', '1968-11-20', 'Chaco 444', '3624-600001', 'emorales@mail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_administrativo`
--

DROP TABLE IF EXISTS `personal_administrativo`;
CREATE TABLE `personal_administrativo` (
  `legajo` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `sector` varchar(50) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  `fecha_ingreso` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personal_administrativo`
--

INSERT INTO `personal_administrativo` (`legajo`, `id_persona`, `sector`, `cargo`, `fecha_ingreso`) VALUES
(1, 9, 'Secretaría', 'Secretario', '2016-03-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preceptor`
--

DROP TABLE IF EXISTS `preceptor`;
CREATE TABLE `preceptor` (
  `legajo` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `turno` varchar(30) DEFAULT NULL COMMENT 'Puede no haber sido asignado aíun.',
  `fecha_ingreso` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preceptor`
--

INSERT INTO `preceptor` (`legajo`, `id_persona`, `turno`, `fecha_ingreso`) VALUES
(1, 6, 'Mañana', '2015-03-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

DROP TABLE IF EXISTS `reserva`;
CREATE TABLE `reserva` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `legajo_personal_evaluador` int(11) NOT NULL,
  `id_persona_solicitante` int(11) NOT NULL,
  `id_instalacion` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Volcado de datos para la tabla reserva
--

INSERT INTO `reserva` (`id`, `nombre`, `hora_inicio`, `hora_fin`, `legajo_personal_evaluador`, `id_persona_solicitante`, `id_instalacion`, `fecha`) VALUES
(1, 'Acto escolar Día del Maestro', '08:00:00', '12:00:00', 1, 10, 2, '2024-09-11'),
(2, 'Clase de Educación Física 1A', '10:00:00', '11:30:00', 1, 4, 1, '2024-09-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud_viaje`
--

DROP TABLE IF EXISTS `solicitud_viaje`;
CREATE TABLE `solicitud_viaje` (
  `id_solicitud` int(11) NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `estado` varchar(50) NOT NULL,
  `observaciones` text DEFAULT NULL,
  `legajo_docente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `solicitud_viaje`
--

INSERT INTO `solicitud_viaje` (`id_solicitud`, `fecha_solicitud`, `estado`, `observaciones`, `legajo_docente`) VALUES
(1, '2024-08-01', 'Aprobada', 'Visita al Museo del Hombre Chaqueño', 1),
(2, '2024-09-10', 'Pendiente', 'Campamento fin de año 2do', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutor`
--

DROP TABLE IF EXISTS `tutor`;
CREATE TABLE `tutor` (
  `id` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `telefono_contacto` varchar(20) DEFAULT NULL,
  `email_contacto` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tutor`
--

INSERT INTO `tutor` (`id`, `id_persona`, `telefono_contacto`, `email_contacto`) VALUES
(1, 7, '3624-400001', 'rperez@mail.com'),
(2, 8, '3624-400002', 'ndiaz@mail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutor_tutora_alumno`
--

DROP TABLE IF EXISTS `tutor_tutora_alumno`;
CREATE TABLE `tutor_tutora_alumno` (
  `id` int(11) NOT NULL,
  `id_tutor` int(11) NOT NULL,
  `id_alumno` int(11) NOT NULL,
  `tipo_parentesco` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tutor_tutora_alumno`
--

INSERT INTO `tutor_tutora_alumno` (`id`, `id_tutor`, `id_alumno`, `tipo_parentesco`) VALUES
(1, 1, 1, 'Padre'),
(2, 2, 2, 'Madre'),
(3, 1, 3, 'Tío');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombre_usuario` varchar(60) NOT NULL,
  `contrasenia` varchar(20) NOT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre_usuario`, `contrasenia`, `correo`) VALUES
(1, 'jgomez', 'pass1234', 'jgomez@colegio.edu.ar'),
(2, 'mrodriguez', 'pass1234', 'mrodriguez@colegio.edu.ar'),
(3, 'lfernandez', 'pass1234', 'lfernandez@colegio.edu.ar'),
(4, 'clopez', 'pass1234', 'clopez@colegio.edu.ar'),
(5, 'pmartinez', 'pass1234', 'pmartinez@colegio.edu.ar'),
(6, 'asanchez', 'pass1234', 'asanchez@colegio.edu.ar'),
(7, 'rperez', 'pass1234', 'rperez@colegio.edu.ar'),
(8, 'ndiaz', 'pass1234', 'ndiaz@colegio.edu.ar'),
(9, 'sgil', 'pass1234', 'sgil@colegio.edu.ar'),
(10, 'emorales', 'pass1234', 'emorales@colegio.edu.ar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

DROP TABLE IF EXISTS `vehiculo`;
CREATE TABLE `vehiculo` (
  `id_vehiculo` int(11) NOT NULL,
  `patente` varchar(20) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculo`
--

INSERT INTO `vehiculo` (`id_vehiculo`, `patente`, `modelo`, `capacidad`, `estado`) VALUES
(1, 'AB123CD', 'Mercedes Sprinter', 19, 'Disponible'),
(2, 'EF456GH', 'Ford Transit', 15, 'Disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viaje`
--

DROP TABLE IF EXISTS `viaje`;
CREATE TABLE `viaje` (
  `id_viaje` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `fecha_salida` date NOT NULL,
  `fecha_regreso` date NOT NULL,
  `motivo` text NOT NULL,
  `id_solicitud` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `viaje`
--

INSERT INTO `viaje` (`id_viaje`, `tipo`, `fecha_salida`, `fecha_regreso`, `motivo`, `id_solicitud`) VALUES
(1, 'Educativo', '2024-08-15', '2024-08-15', 'Visita al Museo del Hombre Chaqueño', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viaje_utiliza_vehiculo`
--

DROP TABLE IF EXISTS `viaje_utiliza_vehiculo`;
CREATE TABLE `viaje_utiliza_vehiculo` (
  `id` int(11) NOT NULL,
  `id_viaje` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `fecha_uso` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `viaje_utiliza_vehiculo`
--

INSERT INTO `viaje_utiliza_vehiculo` (`id`, `id_viaje`, `id_vehiculo`, `fecha_uso`) VALUES
(1, 1, 1, '2024-08-15');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`legajo`),
  ADD KEY `id_curso` (`id_curso`),
  ADD KEY `id_persona` (`id_persona`);

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id_asistencia`),
  ADD KEY `legajo_alumno` (`legajo_alumno`);

--
-- Indices de la tabla `aula`
--
ALTER TABLE `aula`
  ADD PRIMARY KEY (`id_aula`);

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD PRIMARY KEY (`id_calificacion`),
  ADD KEY `calificacion_ibfk_1` (`id_materia`),
  ADD KEY `calificacion_ibfk_2` (`legajo_alumno`);

--
-- Indices de la tabla `cuota`
--
ALTER TABLE `cuota`
  ADD PRIMARY KEY (`id_cuota`),
  ADD KEY `id_tutor` (`id_tutor`),
  ADD KEY `id_alumno` (`id_legajo_alumno`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `curso_ibfk_1` (`legajo_preceptor`),
  ADD KEY `curso_ibfk_2` (`id_aula`);

--
-- Indices de la tabla `curso_cursa_materias`
--
ALTER TABLE `curso_cursa_materias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_curso` (`id_curso`),
  ADD KEY `id_materia` (`id_materia`);

--
-- Indices de la tabla `curso_participa_viaje`
--
ALTER TABLE `curso_participa_viaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_curso` (`id_curso`),
  ADD KEY `id_viaje` (`id_viaje`);

--
-- Indices de la tabla `directivo`
--
ALTER TABLE `directivo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_persona` (`id_persona`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indices de la tabla `docente`
--
ALTER TABLE `docente`
  ADD PRIMARY KEY (`legajo`),
  ADD KEY `id_persona` (`id_persona`);

--
-- Indices de la tabla `docente_dicta_materia`
--
ALTER TABLE `docente_dicta_materia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_docente` (`id_docente`),
  ADD KEY `id_materia` (`id_materia`);

--
-- Indices de la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD PRIMARY KEY (`id_inscripcion`),
  ADD KEY `inscripcion_ibfk_1` (`id_curso`),
  ADD KEY `inscripcion_ibfk_2` (`legajo_alumno`);

--
-- Indices de la tabla `instalacion`
--
ALTER TABLE `instalacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`id_materia`);

--
-- Indices de la tabla `noticia`
--
ALTER TABLE `noticia`
  ADD PRIMARY KEY (`id_noticia`),
  ADD KEY `legajo_personal` (`legajo_personal`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `personal_administrativo`
--
ALTER TABLE `personal_administrativo`
  ADD PRIMARY KEY (`legajo`),
  ADD KEY `id_persona` (`id_persona`);

--
-- Indices de la tabla `preceptor`
--
ALTER TABLE `preceptor`
  ADD PRIMARY KEY (`legajo`),
  ADD KEY `id_persona` (`id_persona`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reserva_ibfk_1` (`legajo_personal_evaluador`),
  ADD KEY `reserva_ibfk_111` (`id_persona_solicitante`),
  ADD KEY `id_instalacion` (`id_instalacion`);

--
-- Indices de la tabla `solicitud_viaje`
--
ALTER TABLE `solicitud_viaje`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `legajo_docente` (`legajo_docente`);

--
-- Indices de la tabla `tutor`
--
ALTER TABLE `tutor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_persona` (`id_persona`);

--
-- Indices de la tabla `tutor_tutora_alumno`
--
ALTER TABLE `tutor_tutora_alumno`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tutor` (`id_tutor`),
  ADD KEY `id_alumno` (`id_alumno`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD PRIMARY KEY (`id_vehiculo`);

--
-- Indices de la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD PRIMARY KEY (`id_viaje`),
  ADD UNIQUE KEY `id_solicitud` (`id_solicitud`);

--
-- Indices de la tabla `viaje_utiliza_vehiculo`
--
ALTER TABLE `viaje_utiliza_vehiculo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_viaje` (`id_viaje`),
  ADD KEY `id_vehiculo` (`id_vehiculo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `legajo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `id_asistencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `aula`
--
ALTER TABLE `aula`
  MODIFY `id_aula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  MODIFY `id_calificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cuota`
--
ALTER TABLE `cuota`
  MODIFY `id_cuota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `curso_cursa_materias`
--
ALTER TABLE `curso_cursa_materias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `curso_participa_viaje`
--
ALTER TABLE `curso_participa_viaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `directivo`
--
ALTER TABLE `directivo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `docente`
--
ALTER TABLE `docente`
  MODIFY `legajo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `docente_dicta_materia`
--
ALTER TABLE `docente_dicta_materia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  MODIFY `id_inscripcion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `instalacion`
--
ALTER TABLE `instalacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `materia`
--
ALTER TABLE `materia`
  MODIFY `id_materia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `noticia`
--
ALTER TABLE `noticia`
  MODIFY `id_noticia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `personal_administrativo`
--
ALTER TABLE `personal_administrativo`
  MODIFY `legajo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `preceptor`
--
ALTER TABLE `preceptor`
  MODIFY `legajo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `reserva`
--
ALTER TABLE `reserva`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `solicitud_viaje`
--
ALTER TABLE `solicitud_viaje`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tutor`
--
ALTER TABLE `tutor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tutor_tutora_alumno`
--
ALTER TABLE `tutor_tutora_alumno`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  MODIFY `id_vehiculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `viaje`
--
ALTER TABLE `viaje`
  MODIFY `id_viaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `viaje_utiliza_vehiculo`
--
ALTER TABLE `viaje_utiliza_vehiculo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alumno_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`);

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `asistencia_ibfk_1` FOREIGN KEY (`legajo_alumno`) REFERENCES `alumno` (`legajo`);

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD CONSTRAINT `calificacion_ibfk_1` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `calificacion_ibfk_2` FOREIGN KEY (`legajo_alumno`) REFERENCES `alumno` (`legajo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cuota`
--
ALTER TABLE `cuota`
  ADD CONSTRAINT `cuota_ibfk_11` FOREIGN KEY (`id_tutor`) REFERENCES `tutor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cuota_ibfk_2` FOREIGN KEY (`id_legajo_alumno`) REFERENCES `alumno` (`legajo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`legajo_preceptor`) REFERENCES `preceptor` (`legajo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_2` FOREIGN KEY (`id_aula`) REFERENCES `aula` (`id_aula`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `curso_cursa_materias`
--
ALTER TABLE `curso_cursa_materias`
  ADD CONSTRAINT `curso_cursa_materias_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_cursa_materias_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `curso_participa_viaje`
--
ALTER TABLE `curso_participa_viaje`
  ADD CONSTRAINT `curso_participa_viaje_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_participa_viaje_ibfk_2` FOREIGN KEY (`id_viaje`) REFERENCES `viaje` (`id_viaje`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `directivo`
--
ALTER TABLE `directivo`
  ADD CONSTRAINT `directivo_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `docente`
--
ALTER TABLE `docente`
  ADD CONSTRAINT `docente_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `docente_dicta_materia`
--
ALTER TABLE `docente_dicta_materia`
  ADD CONSTRAINT `docente_dicta_materia_ibfk_1` FOREIGN KEY (`id_docente`) REFERENCES `docente` (`legajo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `docente_dicta_materia_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD CONSTRAINT `inscripcion_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inscripcion_ibfk_2` FOREIGN KEY (`legajo_alumno`) REFERENCES `alumno` (`legajo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `noticia`
--
ALTER TABLE `noticia`
  ADD CONSTRAINT `noticia_ibfk_1` FOREIGN KEY (`legajo_personal`) REFERENCES `personal_administrativo` (`legajo`);

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `personal_administrativo`
--
ALTER TABLE `personal_administrativo`
  ADD CONSTRAINT `personal_administrativo_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `preceptor`
--
ALTER TABLE `preceptor`
  ADD CONSTRAINT `preceptor_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`legajo_personal_evaluador`) REFERENCES `personal_administrativo` (`legajo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reserva_ibfk_111` FOREIGN KEY (`id_persona_solicitante`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reserva_ibfk_112` FOREIGN KEY (`id_instalacion`) REFERENCES `instalacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `solicitud_viaje`
--
ALTER TABLE `solicitud_viaje`
  ADD CONSTRAINT `solicitud_viaje_ibfk_1` FOREIGN KEY (`legajo_docente`) REFERENCES `docente` (`legajo`);

--
-- Filtros para la tabla `tutor`
--
ALTER TABLE `tutor`
  ADD CONSTRAINT `tutor_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tutor_tutora_alumno`
--
ALTER TABLE `tutor_tutora_alumno`
  ADD CONSTRAINT `tutor_tutora_alumno_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`legajo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tutor_tutora_alumno_ibfk_2` FOREIGN KEY (`id_tutor`) REFERENCES `tutor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD CONSTRAINT `viaje_ibfk_1` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud_viaje` (`id_solicitud`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `viaje_utiliza_vehiculo`
--
ALTER TABLE `viaje_utiliza_vehiculo`
  ADD CONSTRAINT `viaje_utiliza_vehiculo_ibfk_1` FOREIGN KEY (`id_viaje`) REFERENCES `viaje` (`id_viaje`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `viaje_utiliza_vehiculo_ibfk_2` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

-- Datos de cv
CREATE TABLE postulacion_laboral (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(15) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    puesto VARCHAR(50) NOT NULL,
    mensaje TEXT,
    cv VARCHAR(255),
    fecha_postulacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
