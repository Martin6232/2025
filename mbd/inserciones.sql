-- Insertando en la tabla tipo_usuario (solo 2 registros: Paciente y Empleado)
-- Insertando en la tabla tipo_usuario (solo 2 registros: Paciente y Empleado)
INSERT INTO `consulta`.`tipo_usuario` (`tipo_usuario`, `descripcion`, `create`) VALUES
('Paciente', 'Usuario que recibe atención', NOW()),
('Empleado', 'Trabajador de la consulta', NOW());

-- Insertando en la tabla personas (5 registros)
INSERT INTO `consulta`.`personas` (`rut`, `nombre`, `apellido`, `sexo`, `fecha_nacimiento`, `create`) VALUES
(12345678, 'Juan', 'Pérez', 'Masculino', '1985-03-15', NOW()),
(23456789, 'María', 'López', 'Femenino', '1990-07-22', NOW()),
(34567890, 'Carlos', 'González', 'Masculino', '1975-11-01', NOW()),
(45678901, 'Ana', 'Martínez', 'Femenino', '1988-02-17', NOW()),
(56789012, 'Luis', 'Hernández', 'Masculino', '1995-01-09', NOW());

-- Insertando en la tabla usuarios (5 registros)
INSERT INTO `consulta`.`usuarios` (`rut`, `idtipo_usuario`, `email`, `password`, `create`) VALUES
(12345678, 1, 'juan.perez@email.com', 'password123', NOW()),
(23456789, 1, 'maria.lopez@email.com', 'password456', NOW()),
(34567890, 2, 'carlos.gonzalez@email.com', 'password789', NOW()),
(45678901, 2, 'ana.martinez@email.com', 'password101', NOW()),
(56789012, 1, 'luis.hernandez@email.com', 'password202', NOW());

-- Insertando en la tabla especialidad (5 registros)
INSERT INTO `consulta`.`especialidad` (`tipo_especialidad`, `descripcion`, `create`) VALUES
('Cardiología', 'Corazón', NOW()),
('Pediatría', 'Niños', NOW()),
('Dermatología', 'Piel', NOW()),
('Neurología', 'Sistema nervioso', NOW()),
('Oftalmología', 'Ojos', NOW());

-- Insertando en la tabla medicos (5 registros)
INSERT INTO `consulta`.`medicos` (`idespecialidad`, `nombe`, `apellido`, `email`, `created`) VALUES
(1, 'Pedro', 'Ramírez', 'pedro.ramirez@email.com', NOW()),
(2, 'Laura', 'García', 'laura.garcia@email.com', NOW()),
(3, 'José', 'Vargas', 'jose.vargas@email.com', NOW()),
(4, 'Sofía', 'Martínez', 'sofia.martinez@email.com', NOW()),
(5, 'David', 'López', 'david.lopez@email.com', NOW());

-- Insertando en la tabla citas (5 registros)
INSERT INTO `consulta`.`citas` (`idusuario`, `idmedicos`, `fecha_cita`, `fecha_registro`) VALUES
(1, 1, '2025-03-10', NOW()),
(2, 2, '2025-03-12', NOW()),
(3, 3, '2025-03-14', NOW()),
(4, 4, '2025-03-15', NOW()),
(5, 5, '2025-03-16', NOW());

-- Insertando en la tabla consultas (5 registros)
INSERT INTO `consulta`.`consultas` (`idcitas`, `motivo`, `diagnostico`, `tratamiento`, `prescripcion`, `create`) VALUES
(1, 'Dolor en el pecho', 'Angina', 'Medicamentos', 'Nitroglicerina', NOW()),
(2, 'Fiebre alta', 'Amigdalitis', 'Antibióticos', 'Amoxicilina', NOW()),
(3, 'Erupción', 'Dermatitis', 'Crema tópica', 'Corticoides', NOW()),
(4, 'Dolor de cabeza', 'Migraña', 'Antiinflamatorios', 'Ibuprofeno', NOW()),
(5, 'Visión borrosa', 'Miopía', 'Gafas', 'Receta óptica', NOW());
