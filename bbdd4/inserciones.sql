-- ********************************************
-- 1. Tablas de Catálogo y Entidades Base
-- ********************************************

-- 1.1. Inserción de Tipos de Usuario
INSERT INTO tipo_usuario (descripcion, tipo_u, created_at) VALUES
( 'Usuario con permisos de administrador general', 'Administrador', NOW()),
( 'Docente encargado de alumnos y actividades', 'Profesor', NOW()),
( 'Estudiante que realiza actividades TDAH', 'Alumno', NOW());

-- 1.2. Inserción de Institución
INSERT INTO instituciones (nombre_institucion, contacto_principal, direccion, created_at) VALUES
( 'Colegio San Ignacio', 987654321, 'Av. Libertador 1234, Santiago', NOW());

-- 1.3. Inserción de Materias
INSERT INTO materias (materia, descripcion, created_at) VALUES
( 'Matemáticas', 'Cálculo y lógica básica', NOW()),
( 'Lenguaje', 'Comunicación oral y escrita', NOW()),
( 'Apoyo TDAH', 'Estrategias de concentración y gestión emocional', NOW());

-- 1.4. Inserción de Tipos de Material
INSERT INTO tipo_material (tipo_material, created_at) VALUES
( 'Video Educativo', NOW()),
( 'Guía de Estrategias', NOW()),
( 'Ficha de Ejercicios', NOW());

-- ********************************************
-- 2. Personas y Usuarios (Profesor y Alumno)
-- ********************************************

-- 2.1. Inserción de Personas (Rut es AUTO_INCREMENT, no se especifica)

-- Profesor Andrea Flores (Rut 1, si es el primero)
INSERT INTO personas (nombre, apellido, fecha_nac, telefono, created_at) VALUES
( 'Andrea', 'Flores', '1985-03-15', '987654321', NOW()); 

-- Alumno Martín Pérez (Rut 2, si es el segundo)
INSERT INTO personas (nombre, apellido, fecha_nac, telefono, created_at) VALUES
( 'Martín', 'Pérez', '2015-05-10', '912345678', NOW()); 

-- 2.2. Inserción de Usuarios

-- Usuario Profesor (asumiendo id_usuario = 1)
INSERT INTO usuarios (personas_rut, tipo_usuario_idtipo_usuario, instituciones_id_institucion, email, password, activo, created_at) VALUES
( 1, 2, 1, 'andrea.flores@colegio.cl', 'clave123profesor', 1, NOW()); 

-- Usuario Alumno (asumiendo id_usuario = 2)
INSERT INTO usuarios (personas_rut, tipo_usuario_idtipo_usuario, instituciones_id_institucion, email, password, activo, created_at) VALUES
( 2, 3, 1, 'martin.perez@colegio.cl', 'clave123alumno', 1, NOW()); 

-- ********************************************
-- 3. Entidades Específicas del Negocio
-- ********************************************

-- 3.1. Inserción de Profesores (Profesor Andrea es id_profesores = 1)
-- Se asocia con el usuario 1 y la materia "Apoyo TDAH" (asumiendo id_materia = 3)
INSERT INTO profesores (usuarios_id_usuario, materias_id_usuario, created_at) VALUES
( 1, 3, NOW()); 

-- 3.2. Inserción de Actividades Eficaces (Estrategias TDAH)
INSERT INTO ACTIVIDADES_EFICACES (nombre_actividad, descripcion, created_at) VALUES
( 'Uso de Temporizador Pomodoro', 'Técnica de 25 min de trabajo x 5 min de descanso. Ayuda a la atención sostenida.', NOW()),
( 'Organización por Colores', 'Asignar un color a cada materia/tarea para visualización rápida.', NOW()),
( 'Movimiento y Pausas Activas', 'Ejercicios breves de estiramiento para liberar energía acumulada.', NOW());

-- 3.3. Inserción de Registro de Actividad (Registro para Martín con Pomodoro, id_registro = 1)
-- Asumiendo ACTIVIDADES_EFICACES_id_alumno = 1 (Pomodoro)
INSERT INTO REGISTRO_ACTIVIDAD_ALUMNO (fecha_realizacion, ACTIVIDADES_EFICACES_id_alumno, created_at) VALUES
( '2024-10-01', 1, NOW());

-- 3.4. Inserción de Rendimiento Histórico (Rendimiento Inicial de Martín, id_rendimiento = 1)
INSERT INTO RENDIMIENTO_HISTORICO (escala_mejora, promedio_general, created_at) VALUES
( 0.1, 4.5, NOW()); -- Mejora inicial del 10%, Promedio 4.5

-- 3.5. Inserción de Alumnos (Alumno Martín es id_alumno = 1)
-- Asociado a usuario 2, registro 1, rendimiento 1
INSERT INTO alumnos (usuarios_id_usuario, REGISTRO_ACTIVIDAD_ALUMNO_id_registro, RENDIMIENTO_HISTORICO_id_alumno, created_at) VALUES
( 2, 1, 1, NOW()); 

-- 3.6. Inserción de Materiales
-- Guía de Estrategias TDAH (id_alumno = 1)
INSERT INTO MATERIALES (titulo, tipo_material_id_alumno, url_archivo_externo, fecha_subida, aprobado, created_at) VALUES
( 'Guía Rápida: Pausas Activas', 2, 'https://recursos.edu/guia-pausas', NOW(), 1, NOW());

-- 3.7. Inserción de Asignación de Material
-- Asignar la guía al Colegio San Ignacio (id_alumno = 1)
INSERT INTO ASIGNACION_MATERIAL (fecha_asignacion, instituciones_id_institucion, MATERIALES_id_alumno, created_at) VALUES
( NOW(), 1, 1, NOW());


