-- 1) Crear base y usarla

CREATE DATABASE IF NOT EXISTS empresa;
USE empresa;
-- 2) Crear tabla si no existe (con estructura mínima)
CREATE TABLE IF NOT EXISTS empleados (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
cargo VARCHAR(50) NOT NULL,
sueldo DECIMAL(10,2) NOT NULL
);
-- 3) Asegurar columnas de auditoría y borrado lógico (MySQL 8.0.29+: IF NOT EXISTS)
ALTER TABLE empleados
ADD COLUMN eliminado TINYINT(1) NOT NULL DEFAULT 0 AFTER sueldo,
ADD COLUMN created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN updated_at DATETIME NULL DEFAULT NULL ON UPDATE
CURRENT_TIMESTAMP,
ADD COLUMN deleted_at DATETIME NULL DEFAULT NULL;

-- 4) Poblar datos de ejemplo SOLO si está vacía
INSERT INTO empleados (nombre, cargo, sueldo)
SELECT 'Juan Pérez', 'Administrador', 850000
WHERE NOT EXISTS (SELECT 1 FROM empleados LIMIT 1);
INSERT INTO empleados (nombre, cargo, sueldo)
SELECT 'Ana Gómez', 'Vendedora', 650000
WHERE NOT EXISTS (SELECT 1 FROM empleados LIMIT 1 OFFSET 1);
INSERT INTO empleados (nombre, cargo, sueldo)
SELECT 'Carlos Rojas','Técnico', 720000
WHERE NOT EXISTS (SELECT 1 FROM empleados LIMIT 1 OFFSET 2);
-- 5) Recrear procedimientos almacenados
DELIMITER $$
-- A) Listar SOLO activos
DROP PROCEDURE IF EXISTS sp_listar_empleados_activos $$
CREATE PROCEDURE sp_listar_empleados_activos()
BEGIN
SELECT id, nombre, cargo, sueldo, created_at, updated_at
FROM empleados
WHERE eliminado = 0
ORDER BY id;
END $$
-- B) Listar TODOS (incluye eliminados)
DROP PROCEDURE IF EXISTS sp_listar_empleados_todos $$
CREATE PROCEDURE sp_listar_empleados_todos()
BEGIN
SELECT id, nombre, cargo, sueldo, eliminado, created_at, updated_at, deleted_at
FROM empleados
ORDER BY id;
END $$
-- C) Insertar y devolver ID nuevo (OUT)
DROP PROCEDURE IF EXISTS sp_insertar_empleado $$
CREATE PROCEDURE sp_insertar_empleado(
IN p_nombre VARCHAR(50),
IN p_cargo VARCHAR(50),
IN p_sueldo DECIMAL(10,2),
OUT p_nuevo_id INT
)
BEGIN
INSERT INTO empleados (nombre, cargo, sueldo)

VALUES (p_nombre, p_cargo, p_sueldo);
SET p_nuevo_id = LAST_INSERT_ID();
END $$
-- D) Borrado lógico
DROP PROCEDURE IF EXISTS sp_borrado_logico_empleado $$
CREATE PROCEDURE sp_borrado_logico_empleado(IN p_id INT)
BEGIN
UPDATE empleados
SET eliminado = 1,
deleted_at = NOW()
WHERE id = p_id AND eliminado = 0;
END $$
-- E) Restaurar (opcional)
DROP PROCEDURE IF EXISTS sp_restaurar_empleado $$
CREATE PROCEDURE sp_restaurar_empleado(IN p_id INT)
BEGIN
UPDATE empleados
SET eliminado = 0,
deleted_at = NULL
WHERE id = p_id AND eliminado = 1;
END $$
DELIMITER ;
