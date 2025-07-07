-- Creación de la base de datos
CREATE DATABASE ejemploSelect;
USE ejemploSelect;

-- Tabla: tipo_usuarios
CREATE TABLE tipo_usuarios (
    id_tipo INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    nombre_tipo VARCHAR(50) NOT NULL unique, 
    descripcion_tipo VARCHAR(200) not null check(length(descripcion_tipo) <= 100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	created_by INT,
	updated_by INT,
	deleted BOOLEAN DEFAULT FALSE
);

-- Tabla: usuarios (se añade campo created_at con valor por defecto)
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE check(email like '%@%.%'),
    id_tipo_usuario INT,
    CONSTRAINT fk_usuarios_tipo_usuarios FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuarios(id_tipo),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	created_by INT,
	updated_by INT,
	deleted BOOLEAN DEFAULT FALSE
);

-- Tabla: ciudad (nueva)
CREATE TABLE ciudad (
    id_ciudad INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_ciudad VARCHAR(100) NOT NULL check(length(nombre_ciudad) >= 7),
    region VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	created_by INT,
	updated_by INT,
	deleted BOOLEAN DEFAULT FALSE
);

-- Tabla: personas (relacionada con usuarios y ciudad)
CREATE TABLE personas (
    rut VARCHAR(13) NOT NULL UNIQUE check(LENGTH(rut) = 10),
    nombre_completo VARCHAR(100) NOT NULL,
    fecha_nac DATE,
    id_usuario INT,
    id_ciudad INT,
    CONSTRAINT fk_personas_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_personas_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	created_by INT,
	updated_by INT,
	deleted BOOLEAN DEFAULT FALSE
);