/*busqueda simple*/
select * from citas
where fecha_cita > '2025-03-14';

select * from consultas
where motivo = "fiebre alta";

select * from medicos
where apellido = "Ramirez";
/*update*/
update citas
set fecha_cita = '2025-06-08'
where idcitas = 4;

select * from citas
where idcitas = 4;

update usuarios
set password = "parangarecutirimicuaro"
where idusuario = 1;

select * from usuarios
where idusuario = 1;
/*delete*/
delete from consultas
where idconsultas = 1;

select * from consultas;





