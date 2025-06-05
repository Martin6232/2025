-- Ejer 1
select * from usuarios
where deleted = False;
-- Ejer 2
select * from usuarios
where tipo_usuario_id = 1;
-- Ejer 3
select * from usuarios
where nombre_tipo like "M%";
-- Ejer 4
select * from usuarios
where date(created_at) between "2025-05-18" and "2025-06-05";
-- Ejer 5
select usuario_id, fecha from ventas
where fecha between "2025-05-10" and "2025-06-05";
-- Ejer 6
select nombre, precio from productos
where precio < 1000;
-- Ejer 7
select nombre, precio from productos
where nombre like "%a";
-- Ejer 8 
select nombre, stock from productos
where stock > 20;
-- Ejer 9
select producto_id, cantidad, precio_unitario from detalle_ventas
where cantidad > 5;


