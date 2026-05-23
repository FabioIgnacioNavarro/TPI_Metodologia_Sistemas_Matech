CREATE DATABASE colegio;
USE colegio;

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
-- AULA
-- =========================
CREATE TABLE Aula (
    id_aula INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    numero INT,
    piso INT,
    capacidad INT,
    tipo VARCHAR(50),
    estado VARCHAR(50) -- en este capaz pueda ser un un array de tres opciones
);

-- =========================
-- CURSO
-- =========================
CREATE TABLE Curso (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    comision VARCHAR(20),
    turno VARCHAR(30),
    nivel VARCHAR(30),
    cupo_maximo INT,
    legajo_preceptor INT,
    id_aula INT,
    FOREIGN KEY (legajo_preceptor) REFERENCES Preceptor(legajo),
    FOREIGN KEY (id_aula) REFERENCES Aula(id_aula)
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
    id_curso INT,

    FOREIGN KEY (dni) REFERENCES Persona(dni),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

-- =========================
-- TUTOR
-- =========================
CREATE TABLE Tutor (
    id_tutor INT PRIMARY KEY AUTO_INCREMENT,
    legajo_alumno INT,
    parentesco VARCHAR(50),
    telefono_contacto VARCHAR(20),
    email_contacto VARCHAR(100),

    FOREIGN KEY (legajo_alumno) REFERENCES Alumno(legajo)
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
-- SOLICITANTE
-- =========================
CREATE TABLE Solicitante (
    id_solicitante INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(20)
);

-- =========================
-- RESERVA
-- =========================
CREATE TABLE Reserva (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    hora_inicio TIME,
    hora_fin TIME,
    legajo_personal INT,
    id_solicitante INT,
    FOREIGN KEY (legajo_personal) REFERENCES Personal_Administrativo(legajo),
    FOREIGN KEY (id_solicitante) REFERENCES Solicitante(id_solicitante)
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
-- SOLICITUD VIAJE
-- =========================
CREATE TABLE Solicitud_Viaje (
    id_solicitud INT PRIMARY KEY AUTO_INCREMENT,
    fecha_solicitud DATE,
    estado VARCHAR(50),
    observaciones TEXT,
    legajo_docente INT,
    FOREIGN KEY (legajo_docente) REFERENCES Docente(legajo)
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
-- NOTICIA
-- =========================
CREATE TABLE Noticia (
    id_noticia INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200),
    contenido TEXT,
    fecha_publicacion DATE,
    legajo_personal INT,
    FOREIGN KEY (legajo_personal) REFERENCES Personal_Administrativo(legajo)
);

-- =========================
-- CERTIFICADO
-- =========================
CREATE TABLE Certificado (
    id_certificado INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(100),
    fecha_emision DATE,
    descripcion TEXT,
    dni_persona VARCHAR(15),
    FOREIGN KEY (dni_persona) REFERENCES Persona(dni)
);
-- =========================
-- TABLAS INTERMEDIAS
-- =========================


CREATE TABLE Vehiculo_Viaje (
    id_vehiculo INT,
    id_viaje INT,

    PRIMARY KEY (id_vehiculo, id_viaje),

    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id_vehiculo),

    FOREIGN KEY (id_viaje) REFERENCES Viaje(id_viaje)
);


CREATE TABLE Curso_Viaje (
    id_curso INT,
    id_viaje INT,

    PRIMARY KEY (id_curso, id_viaje),

    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),

    FOREIGN KEY (id_viaje) REFERENCES Viaje(id_viaje)
);


CREATE TABLE Reserva_Instalacion (
    id_reserva INT,
    id_instalacion INT,
    horario DATETIME,

    PRIMARY KEY (id_reserva, id_instalacion),

    FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva),

    FOREIGN KEY (id_instalacion) REFERENCES Instalacion(id_instalacion)
);

CREATE TABLE Curso_Materia (
    id_curso INT,
    id_materia INT,
    horario DATETIME,

    PRIMARY KEY (id_curso, id_materia),

    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);
CREATE TABLE Alumno_Calificacion (
    legajo_alumno INT,
    id_calificacion INT,

    PRIMARY KEY (legajo_alumno, id_calificacion),

    FOREIGN KEY (legajo_alumno) REFERENCES Alumno(legajo),
    FOREIGN KEY (id_calificacion) REFERENCES Calificacion(id_calificacion)
);
CREATE TABLE Docente_Materia (
    legajo_docente INT,
    id_materia INT,

    PRIMARY KEY (legajo_docente, id_materia),

    FOREIGN KEY (legajo_docente) REFERENCES Docente(legajo),
    FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);
CREATE TABLE Alumno_Cuota (
    legajo_alumno INT,
    id_cuota INT,

    PRIMARY KEY (legajo_alumno, id_cuota),

    FOREIGN KEY (legajo_alumno) REFERENCES Alumno(legajo),
    FOREIGN KEY (id_cuota) REFERENCES Cuota(id_cuota)
);