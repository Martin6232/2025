-- ejer 1
select username,email,id_tipo_usuario from usuarios 
where id_tipo_usuario like 2;
-- ejer 2
select nombre_completo, fecha_nac from personas 
where fecha_nac > '1990-12-31';
-- ejer 3
select username,email from usuarios 
where username like 'a%';
-- ejer 4
select * from usuarios 
where email like '%mail.com%';
-- ejer 5
select nombre_completo,id_ciudad from personas
where id_ciudad != 2;
-- ejer 6
select * from usuarios 
where length(username) > 7;

select * from personas
where fecha_nac between "1990-12-31" and "1995-01-01";