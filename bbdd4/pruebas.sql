select * from usuarios;

select * from personas 
where fecha_nac > '2000-01-01';

select p.nombre, p.telefono, u.email from usuarios u 
join personas p on u.personas_rut = p.rut;