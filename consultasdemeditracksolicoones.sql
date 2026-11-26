
USE meditracksolucionesweb;

SHOW TABLES;


SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'meditracksolucionesweb'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, COLUMN_NAME;

SELECT COUNT(*) AS total_tablas
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'meditracksolucionesweb'
  AND TABLE_TYPE = 'BASE TABLE';
  
  DESCRIBE usuario;
  describe paciente;
  DESCRIBE familiar;
DESCRIBE medico;
  SELECT
    id_usuario,
    nombre,
    apellidos,
    dni,
    correo,
    rol,
    estado
FROM usuario;
SELECT
    id_paciente,
    id_usuario,
    fecha_nacimiento,
    genero,
    direccion
FROM paciente;
SHOW TABLES;


SELECT DISTINCT rol
FROM usuario
ORDER BY rol;

USE meditracksolucionesweb;

SELECT id_usuario, correo, rol, estado
FROM usuario
WHERE correo = 'andrea.prueba2@example.com';

DESCRIBE usuario;
USE meditracksolucionesweb;

SELECT id_usuario, nombre, apellidos, correo, rol, estado
FROM usuario
WHERE rol = 'ADMIN';


UPDATE usuario
SET nombre = 'Royer',
    apellidos = 'fernandez'
WHERE correo = 'admin@meditrack.local'
  AND rol = 'ADMIN';
  
  SELECT id_usuario, nombre, apellidos, correo, rol
FROM usuario
WHERE correo = 'admin@meditrack.local'
  AND rol = 'ADMIN';
  
  DELETE FROM usuario
WHERE correo = 'admin@meditrack.local'
  AND rol = 'ADMIN';
  
  SELECT
    id_usuario,
    correo,
    rol,
    estado,
    LENGTH(password_hash) AS longitud_hash,
    LEFT(password_hash, 7) AS inicio_hash
FROM usuario
WHERE correo IN (
    'admin@meditrack.local',
    'andrea.prueba2@example.com'
);

DESCRIBE enfermera;
DESCRIBE medico;
DESCRIBE enfermera;
DESCRIBE usuario;
SELECT id_usuario, dni, correo, rol
FROM usuario
WHERE rol = 'ENFERMERA';

USE meditracksolucionesweb;

SELECT id_usuario, nombre, apellidos, dni, correo, rol
FROM usuario
WHERE dni = '87654321';

SELECT *
FROM paciente_familiar
WHERE id_paciente = 1;
USE meditracksolucionesweb;

SELECT
    id_usuario,
    nombre,
    apellidos,
    rol,dni,
    correo,
    telefono,
    
    estado,
    fecha_registro
FROM usuario
WHERE correo = 'lucia.ramirez.fam01@example.com';
SELECT
    id_codigo,
    id_paciente,
    codigo,
    fecha_expiracion,
    usado,
    fecha_creacion
FROM codigo_vinculacion 
 WHERE codigo = 'MT-BD3WvQN7';
USE meditracksolucionesweb;

SELECT
    pf.id_paciente,
    up.nombre AS nombre_paciente,
    up.apellidos AS apellidos_paciente,
    pf.id_familia,
    uf.nombre AS nombre_familiar,
    uf.apellidos AS apellidos_familiar,
    pf.parentesco,
    pf.autorizado_citas,
    pf.fecha_vinculo
FROM paciente_familiar pf
INNER JOIN paciente p
    ON p.id_paciente = pf.id_paciente
INNER JOIN usuario up
    ON up.id_usuario = p.id_usuario
INNER JOIN familiar f
    ON f.id_familia = pf.id_familia
INNER JOIN usuario uf
    ON uf.id_usuario = f.id_usuario
WHERE pf.id_paciente = 2
  AND pf.id_familia = 1;



USE meditracksolucionesweb;

SELECT
    m.id_medico,
    m.id_usuario,
    u.nombre,
    u.apellidos,
    m.cmp
FROM medico m
INNER JOIN usuario u
    ON m.id_usuario = u.id_usuario;
    
    SELECT * FROM usuario
WHERE rol = 'MEDICO';

SELECT COUNT(*) AS total_medicos
FROM medico;

USE meditracksolucionesweb;

SELECT *
FROM especialidad;


USE meditracksolucionesweb;

INSERT INTO especialidad (nombre, descripcion, estado)
VALUES
('Medicina General', 'Atención médica integral y prevención de enfermedades.', 'Activo'),
('Pediatría', 'Atención médica especializada para niños y adolescentes.', 'Activo'),
('Cardiología', 'Diagnóstico y tratamiento de enfermedades del corazón.', 'Activo'),
('Dermatología', 'Atención de enfermedades de la piel.', 'Activo'),
('Endocrinología', 'Tratamiento de enfermedades hormonales y metabólicas.', 'Activo'),
('Ginecología', 'Atención de la salud reproductiva femenina.', 'Activo'),
('Neurología', 'Diagnóstico y tratamiento de enfermedades del sistema nervioso.', 'Activo');

SELECT
    m.id_medico,
    u.id_usuario,
    u.nombre,
    u.apellidos,
    e.id_especialidad,
    e.nombre AS especialidad,
    m.cmp
FROM medico m
INNER JOIN usuario u
    ON m.id_usuario = u.id_usuario
INNER JOIN especialidad e
    ON m.id_especialidad = e.id_especialidad
WHERE u.id_usuario = 8;

USE meditracksolucionesweb;

SELECT
    id_horario,
    id_medico,
    dia_semana,
    hora_inicio,
    hora_fin,
    activo
FROM horario_medico
WHERE id_medico = 1;
select *from usuario;

DESCRIBE familiar;
DESCRIBE paciente;

SELECT id_usuario, nombre, apellidos, dni, correo
FROM usuario
WHERE dni = '12345678';

SELECT id_usuario, nombre, dni, correo
FROM usuario
WHERE dni = '12345678'
   OR correo = 'carlos.prueba@example.com';
   SELECT id_usuario, nombre, apellidos, dni, correo
FROM usuario
WHERE dni ;

select*from medico;
SELECT * FROM usuario;

USE meditracksolucionesweb;

SELECT id_usuario, nombre, apellidos, correo, rol, estado
FROM usuario
WHERE rol = 'ADMIN';

USE meditracksolucionesweb;

SELECT
    id_usuario,
    nombre,
    apellidos,
    correo,
    rol,
    estado
FROM usuario
ORDER BY id_usuario;
SELECT *
FROM usuario
WHERE correo

 = 'admin@meditrack.local';
 
 USE meditracksolucionesweb;

SELECT *
FROM usuario
WHERE correo = 'admin@meditrack.local'
   OR rol = 'ADMIN';
SELECT
    id_usuario,
    nombre,
    apellidos,
    dni,
    correo,
    rol,
    estado
FROM usuario
WHERE nombre LIKE '%Roger%'
   OR apellidos LIKE '%Fernández%';
   SELECT *
FROM paciente
WHERE id_usuario = 9;
SELECT *
FROM citas
WHERE id_paciente = 3;

START TRANSACTION;

DELETE FROM paciente
WHERE id_paciente = 3
  AND id_usuario = 9;

UPDATE usuario
SET rol = 'ADMIN',
    estado = 'Activo'
WHERE id_usuario = 9;

SELECT id_usuario, nombre, apellidos, dni, correo, rol, estado
FROM usuario
WHERE id_usuario = 9;

COMMIT;
UPDATE usuario
SET correo = 'admin@meditrack.com'
WHERE id_usuario = 9
  AND rol = 'ADMIN';
  
  SELECT
    id_usuario,
    nombre,
    apellidos,
    correo,
    rol,
    estado
FROM usuario
WHERE id_usuario = 9;

SELECT
    id_usuario,
    nombre,
    apellidos,
    dni,
    correo,
    telefono,
    rol,
    estado
FROM usuario
WHERE id_usuario = 13;
SELECT id_usuario, nombre, apellidos, rol, estado
FROM usuario
WHERE rol = 'ENFERMERA';


SELECT *
FROM paciente_familiar
WHERE id_familia = (
    SELECT id_familia
    FROM familiar
    WHERE id_usuario = 1
);

SELECT
    pf.id_paciente,
    p.id_usuario AS usuario_paciente,
    pf.id_familia,
    f.id_usuario AS usuario_familiar,
    pf.parentesco
FROM paciente_familiar pf
INNER JOIN paciente p
    ON p.id_paciente = pf.id_paciente
INNER JOIN familiar f
    ON f.id_familia = pf.id_familia;
    
SELECT
    pf.id_paciente,
    CONCAT(up.nombre, ' ', up.apellidos) AS paciente,
    up.id_usuario AS id_usuario_paciente,

    pf.id_familia,
    CONCAT(uf.nombre, ' ', uf.apellidos) AS familiar,
    uf.id_usuario AS id_usuario_familiar,

    pf.parentesco,
    pf.autorizado_citas,
    pf.fecha_vinculo

FROM paciente_familiar pf

INNER JOIN paciente p
    ON p.id_paciente = pf.id_paciente

INNER JOIN usuario up
    ON up.id_usuario = p.id_usuario

INNER JOIN familiar f
    ON f.id_familia = pf.id_familia

INNER JOIN usuario uf
    ON uf.id_usuario = f.id_usuario

ORDER BY pf.id_paciente, pf.id_familia;

SELECT
    pf.id_paciente,
    pf.id_familia,
    pf.parentesco
FROM paciente_familiar pf
ORDER BY pf.id_paciente;

describe horario_medico
