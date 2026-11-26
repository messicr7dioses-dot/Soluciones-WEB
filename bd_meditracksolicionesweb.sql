
use meditracksolucionesweb;


create table usuario (
id_usuario  BIGINT AUTO_INCREMENT PRIMARY KEY,
nombre varchar(100) not null,
apellidos varchar(100) not null,
dni varchar(8) not null unique,
correo varchar(100) not null unique,
telefono varchar(15) not null ,
password_hash varchar(250) not null,
rol varchar(20) not null,
estado varchar(20) not null default 'Activo',
fecha_registro timestamp default current_timestamp
);

create table especialidad (
id_especialidad bigint auto_increment primary key,
nombre varchar(100) not null unique,
descripcion varchar(250),
estado varchar(20) not null default 'Activo'
);
create table paciente (
id_paciente bigint auto_increment primary key,
id_usuario bigint not null unique,
fecha_nacimiento date,
genero varchar(20),
direccion varchar(200),
constraint fk_paciente_usuario foreign key(id_usuario)
references usuario(id_usuario)
);
create table medico(
id_medico bigint auto_increment primary key,
id_usuario bigint not null unique,
id_especialidad bigint not null,
cmp varchar(20) not null unique,
 constraint fk_medico_usuario foreign key(id_usuario)
 references usuario(id_usuario),
 constraint fk_medico_especialidad  foreign key(id_especialidad)
 references especialidad(id_especialidad)
);

create table horario_medico(
id_horario bigint auto_increment primary key,
id_medico bigint not null,
dia_semana varchar(100) not null,
hora_inicio time not null,
hora_fin time not null,
activo boolean not null default true,
constraint fk_horario_medico_medico foreign key(id_medico)
references medico(id_medico),
CONSTRAINT chk_horario_horas
        CHECK (hora_fin > hora_inicio)
);

create table citas(
id_cita bigint auto_increment primary key,
id_paciente  bigint not null,
id_medico bigint not null,
fecha_hora datetime not null,
motivo varchar(100),
estado varchar(20) not null default 'Pendiente',
fecha_registro timestamp default current_timestamp,

constraint fk_citas_paciente foreign key(id_paciente)
references paciente(id_paciente),
constraint fk_citas_medico foreign key (id_medico)
references medico(id_medico),
constraint uq_medico_fecha unique ( id_medico,fecha_hora),
constraint uq_paciente_fecha unique(id_paciente, fecha_hora)

);

create table familiar(
id_familia bigint auto_increment primary key,
id_usuario bigint not null unique,
fecha_registro timestamp default current_timestamp,

constraint fk_familiar_usuario foreign key(id_usuario)
references usuario(id_usuario)

);

create table paciente_familiar (
id_paciente bigint not null,
id_familia bigint not null,
parentesco varchar(50) not null,
autorizado_citas boolean not null default false,
fecha_vinculo timestamp default current_timestamp,
PRIMARY KEY (id_paciente, id_familia),
CONSTRAINT fk_pf_paciente FOREIGN KEY (id_paciente)
	REFERENCES paciente(id_paciente),
CONSTRAINT fk_pf_familiar FOREIGN KEY (id_familia)
	REFERENCES familiar(id_familia)
);

CREATE TABLE notificacion (
    id_notificacion BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_usuario BIGINT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    mensaje VARCHAR(500) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    fecha_envio TIMESTAMP NULL DEFAULT NULL,
    leida BOOLEAN NOT NULL DEFAULT FALSE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notificacion_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

CREATE TABLE historia_clinica (
    id_historia BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_paciente BIGINT NOT NULL UNIQUE,
    antecedentes VARCHAR(1000),
    alergias VARCHAR(1000),
    observaciones TEXT,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_historia_paciente
        FOREIGN KEY (id_paciente)
        REFERENCES paciente(id_paciente)
);

CREATE TABLE medicamento (
    id_medicamento BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion VARCHAR(500),
    presentacion VARCHAR(100),
    estado VARCHAR(20) NOT NULL DEFAULT 'Activo',
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE tratamiento (
    id_tratamiento BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_paciente BIGINT NOT NULL,
    id_medico BIGINT NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR(20) NOT NULL DEFAULT 'Activo',
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_tratamiento_paciente
        FOREIGN KEY (id_paciente)
        REFERENCES paciente(id_paciente),

    CONSTRAINT fk_tratamiento_medico
        FOREIGN KEY (id_medico)
        REFERENCES medico(id_medico),

    CONSTRAINT chk_tratamiento_fechas
        CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE detalle_tratamiento (
    id_detalle BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_tratamiento BIGINT NOT NULL,
    id_medicamento BIGINT NOT NULL,
    dosis VARCHAR(100) NOT NULL,
    frecuencia VARCHAR(100) NOT NULL,
    duracion_dias INT,
    indicaciones VARCHAR(500),

    CONSTRAINT fk_detalle_tratamiento
        FOREIGN KEY (id_tratamiento)
        REFERENCES tratamiento(id_tratamiento),

    CONSTRAINT fk_detalle_medicamento
        FOREIGN KEY (id_medicamento)
        REFERENCES medicamento(id_medicamento),

    CONSTRAINT chk_duracion_dias
        CHECK (duracion_dias IS NULL OR duracion_dias > 0)
);

CREATE TABLE auditoria (
    id_auditoria BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_usuario BIGINT,
    accion VARCHAR(100) NOT NULL,
    descripcion VARCHAR(500),
    fecha_accion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    direccion_ip VARCHAR(45),

    CONSTRAINT fk_auditoria_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);


CREATE TABLE consulta_medica (
    id_consulta BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_cita BIGINT NOT NULL UNIQUE,
    diagnostico TEXT NOT NULL,
    observaciones TEXT,
    fecha_consulta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_consulta_cita
        FOREIGN KEY (id_cita)
        REFERENCES citas(id_cita)
);

USE meditracksolucionesweb;

CREATE TABLE enfermera (
    id_enfermera BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    colegiatura VARCHAR(20) NOT NULL,

    PRIMARY KEY (id_enfermera),
    UNIQUE KEY uk_enfermera_usuario (id_usuario),
    UNIQUE KEY uk_enfermera_colegiatura (colegiatura),

    CONSTRAINT fk_enfermera_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);



CREATE TABLE codigo_vinculacion (
    id_codigo BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_paciente BIGINT NOT NULL,
    codigo VARCHAR(100) NOT NULL UNIQUE,
    fecha_expiracion DATETIME NOT NULL,
    usado BOOLEAN NOT NULL DEFAULT FALSE,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_codigo_paciente
        FOREIGN KEY (id_paciente)
        REFERENCES paciente(id_paciente)
);
