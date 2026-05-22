--CREATE DATABASE colegio;
--USE colegio;

-- =========================
-- PERSONA
-- =========================
CREATE TABLE Persona (
    dni VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100)
);

-- =========================
-- Alumno
-- =========================
CREATE TABLE Alumno (
    legajo INT PRIMARY KEY AUTO_INCREMENT,
    dni VARCHAR(15) UNIQUE,
    anio_cursado INT,
    fecha_ingreso DATE,
    usuario VARCHAR(50) UNIQUE,
    contrasena VARCHAR(255),

    FOREIGN KEY (dni) REFERENCES Persona(dni)
);

-- =========================
-- TUTOR
-- =========================
CREATE TABLE Tutor (
    id_tutor INT PRIMARY KEY AUTO_INCREMENT,
    legajo_alumno VARCHAR(15),
    parentesco VARCHAR(50),
    telefono_contacto VARCHAR(20),
    email_contacto VARCHAR(100),

    FOREIGN KEY (legajo_alumno) REFERENCES Alumno(legajo)
);

-- =========================
-- DOCENTE
-- =========================
CREATE TABLE Docente (
    legajo INT PRIMARY KEY AUTO_INCREMENT,
    dni VARCHAR(15) UNIQUE,
    titulo VARCHAR(100),
    especialidad VARCHAR(100),
    fecha_ingreso DATE,
    usuario VARCHAR(50) UNIQUE,
    contrasena VARCHAR(255),

    FOREIGN KEY (dni) REFERENCES Persona(dni)
);

-- =========================
-- PRECEPTOR
-- =========================
CREATE TABLE Preceptor (
    legajo INT PRIMARY KEY AUTO_INCREMENT,
    dni VARCHAR(15) UNIQUE,
    turno VARCHAR(30),
    fecha_ingreso DATE,
    usuario VARCHAR(50) UNIQUE,
    contrasena VARCHAR(255),

    FOREIGN KEY (dni) REFERENCES Persona(dni)
);

-- =========================
-- PERSONAL ADMINISTRATIVO
-- =========================
CREATE TABLE Personal_Administrativo (
    legajo INT PRIMARY KEY AUTO_INCREMENT,
    dni VARCHAR(15) UNIQUE,
    sector VARCHAR(50),
    cargo VARCHAR(50),
    fecha_ingreso DATE,
    usuario VARCHAR(50) UNIQUE,
    contrasena VARCHAR(255),

    FOREIGN KEY (dni) REFERENCES Persona(dni)
);

-- =========================
-- CURSO
-- =========================
CREATE TABLE Curso (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    comision VARCHAR(20),
    turno VARCHAR(30),
    nivel VARCHAR(30),
    cupo_maximo INT
);

-- =========================
-- AULA
-- =========================
CREATE TABLE Aula (
    id_aula INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    numero INT,
    piso INT,
    capacidad INT,
    tipo VARCHAR(50),
    estado VARCHAR(50) --en este capaz pueda ser un un array de tres opciones
);

-- =========================
-- MATERIA
-- =========================
CREATE TABLE Materia (
    id_materia INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    carga_horaria INT,
    cantidad_clases INT
);

-- =========================
-- HORARIO
-- =========================
--Esto hay que sacar por ahora, o lo podemos usar como tabla intermedia
/*
CREATE TABLE Horario (
    id_horario INT PRIMARY KEY AUTO_INCREMENT,
    hora_inicio TIME,
    hora_fin TIME,
    dia VARCHAR(20),
    id_curso INT,

    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);
*/
-- =========================
-- INSCRIPCION
-- =========================
CREATE TABLE Inscripcion (
    id_inscripcion INT PRIMARY KEY AUTO_INCREMENT,
    fecha_inscripcion DATE,
    estado VARCHAR(30),
    id_curso INT,
    legajo_alumno INT,

    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    FOREIGN KEY (legajo_alumno) REFERENCES Alumno(legajo)
);

-- =========================
-- ASISTENCIA
-- =========================
CREATE TABLE Asistencia (
    id_asistencia INT PRIMARY KEY AUTO_INCREMENT,
    legajo_alumno INT,
    fecha DATE,

    observacion TEXT,

    FOREIGN KEY (legajo_alumno) REFERENCES Alumno(legajo)
);

-- =========================
-- CALIFICACION
-- =========================
CREATE TABLE Calificacion (
    id_calificacion INT PRIMARY KEY AUTO_INCREMENT,
    nota DECIMAL(4,2),
    tipo_evaluacion VARCHAR(50),
    fecha DATE,
    id_materia INT,
    legajo_alumno INT,

    FOREIGN KEY (id_materia) REFERENCES Materia(id_materia),
    FOREIGN KEY (legajo_alumno) REFERENCES Alumno(legajo)
);

-- =========================
-- TURNO
-- =========================
CREATE TABLE Turno (
    id_turno INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    hora_inicio TIME,
    hora_fin TIME
);

-- =========================
-- CUOTA
-- =========================
CREATE TABLE Cuota (
    id_cuota INT PRIMARY KEY AUTO_INCREMENT,
    periodo VARCHAR(20),
    monto DECIMAL(10,2),
    fecha_vencimiento DATE,
    estado VARCHAR(30),
    fecha_pago DATE,
    medio_pago VARCHAR(50),
    fecha_emision_factura DATE,
    pagada BOOLEAN
);

-- =========================
-- INSTALACION
-- =========================
CREATE TABLE Instalacion (
    id_instalacion INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    capacidad INT,
    estado VARCHAR(50)
);

-- =========================
-- RESERVA
-- =========================
CREATE TABLE Reserva (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    hora_inicio TIME,
    hora_fin TIME
);

-- =========================
-- DISCIPLINA DEPORTIVA
-- =========================
CREATE TABLE Disciplina_Deportiva (
    id_disciplina INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    categoria VARCHAR(50),
    descripcion TEXT
);

-- =========================
-- VEHICULO
-- =========================
CREATE TABLE Vehiculo (
    id_vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    patente VARCHAR(20),
    modelo VARCHAR(50),
    capacidad INT,
    estado VARCHAR(50)
);

-- =========================
-- VIAJE
-- =========================
CREATE TABLE Viaje (
    id_viaje INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50),
    fecha_salida DATE,
    fecha_regreso DATE,
    motivo TEXT,
    id_solicitud INT UNIQUE,

    FOREIGN KEY (id_solicitud) REFERENCES Solicitud_Viaje(id_solicitud)
);

-- =========================
-- SOLICITUD VIAJE
-- =========================
CREATE TABLE Solicitud_Viaje (
    id_solicitud INT PRIMARY KEY AUTO_INCREMENT,
    fecha_solicitud DATE,
    estado VARCHAR(50),
    observaciones TEXT
    legajo_docente INT,
    FOREIGN KEY (legajo_docente) REFERENCES Docente(legajo)
);

-- =========================
-- NOTICIA
-- =========================
CREATE TABLE Noticia (
    id_noticia INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200),
    contenido TEXT,
    fecha_publicacion DATE
);

-- =========================
-- CERTIFICADO
-- =========================
CREATE TABLE Certificado (
    id_certificado INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(100),
    fecha_emision DATE,
    descripcion TEXT
);
-- =========================
-- TABLAS INTERMEDIAS
-- =========================


CREATE TABLE Vehiculo_Viaje (
    id_vehiculo INT,
    id_viaje INT,

    PRIMARY KEY (id_vehiculo, id_viaje),

    FOREIGN KEY (id_vehiculo)
        REFERENCES Vehiculo(id_vehiculo),

    FOREIGN KEY (id_viaje)
        REFERENCES Viaje(id_viaje)
);