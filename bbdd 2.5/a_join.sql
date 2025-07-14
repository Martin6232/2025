-- ejer 1
select u.username, u.email, t.nombre_tipo from usuarios u
join tipo_usuarios t on u.id_tipo_usuario = t.id_tipo
where id_tipo_usuario = 2;
-- ejer 2
select p.nombre_completo, p.fecha_nac, u.username from personas p
join usuarios u on p.id_usuario = u.id_usuario
where fecha_nac > '1990-12-31';
-- ejer 3
select p.nombre_completo, u.email from personas p
join usuarios u on p.id_usuario = u.id_usuario
where  nombre_completo like 'A%';
-- ejer 4
select p.nombre_completo, u.username, u.email from personas p
join usuarios u on p.id_usuario = u.id_usuario
where  email like '%mail.com%';
-- ejer 5
select p.nombre_completo, u.username, c.nombre_ciudad from personas p
join usuarios u on p.id_usuario = u.id_usuario
join ciudad c on p.id_ciudad = c.id_ciudad
where p.id_ciudad = 2;
-- ejer 6
select p.rut, u.username from personas p
join usuarios u on p.id_usuario = u.id_usuario
where length(u.username) > 7;
-- ejer 7
select p.rut, p.fecha_nac, u.username from personas p
join usuarios u on p.id_usuario = u.id_usuario
where fecha_nac between "1990-12-31" and "1995-01-01";
