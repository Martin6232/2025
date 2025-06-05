USE sistema_ventas;

-- Primer ejer
insert into usuarios (
	nombre_tipo, correo, tipo_usuario_id, created_by, updated_by
) values (
	'sistemas', 'sistema@plataforma.cl', null, null, null
);

select * from usuarios;
-- Segundo ejer
insert into tipo_usuario (nombre_tipo) values 
('Administrador'),
('Vendedor');

select * from tipo_usuario;
-- Tercer ejer
insert into usuarios (nombre_tipo, correo, tipo_usuario_id) values 
('Miguel','Miguel@gmail.com', 1),
('Lenneth','Lenneth@gmail.com', 2),
('Max','Max@gmail.com', 2);

select * from usuarios;
-- Quarto ejer
insert into productos (nombre, precio, stock, created_by, updated_by) values
('Manzana','800','30', 2, 2),
('Yogurt','1200','18', 2, 2),
('Frutilla','900','26', 2, 2);

select * from productos;
-- Quinto ejer
insert into ventas (usuario_id, fecha) values
(3, now()),
(3, now()),
(4, now());

select * from ventas;
-- sexto ejer
insert into detalle_ventas (venta_id, producto_id, cantidad, precio_unitario, fecha) values
(1, 1, 4, 3200,now()),
(2, 2, 6, 7200,now()),
(3, 3, 10, 9000,now());

select * from detalle_ventas;