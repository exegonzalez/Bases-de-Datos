--TP INTRODUCCION SQL

--2) Crear tabla empleado
create table empleado(
	dni int not null,
	apellido varchar(40) not null,
	nombre varchar(40) not null,
	genero char not null,
	sueldo int,
	primary key (dni));

--3) Insertar empleados en la tabla
insert into empleado(dni,apellido,nombre,genero,sueldo) values (25100000,'PEREZ','PABLO','M',18000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values (29332501,'SLOTOWIAZDA','MARIA','F',35000); 
insert into empleado(dni,apellido,nombre,genero,sueldo) values (19302500,'TENEMBAUN','ENRNESTO','M',22500); 
insert into empleado(dni,apellido,nombre,genero,sueldo) values (33001321,'RINEIRI','EVANGELINA','F',17000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values (22958543,'DIAZ','XIMENA','F',48000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values (33387695,'RICCA','JAVIER','M',29700); 
insert into empleado(dni,apellido,nombre,genero,sueldo) values (25321542,'SIGNORINI','ESTELA','F',45000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values (27123456,'REZONICO','CONSTANZA','F',31000); 
insert into empleado(dni,apellido,nombre,genero,sueldo) values (13334401,'RETAMAR','JOAQUIN','F',35000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values (35254310,'PEREZ LINDO','MATIAS','M',29000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values (41119682,'RETAMAR','CARLOS','M',12000); 

--4) Crear tabla departamento
create table departamento(
	codigo int not null,
	nombre varchar(20) not null,
	primary key (codigo)); 

--5) Insertar departamentos en la tabla 
insert into departamento(codigo,nombre) values (1,'PRODUCCION'),(2,'COMPUTOS'),(3,'VENTAS'),(4,'DEPOSITO');

--6) Borrar el departamento "VENTAS"
delete from departamento where (nombre='VENTAS');

--7) Crear tabla trabajapara
create table trabajapara(
	dni int not null,
	codigo int not null,
	horas int not null,
	primary key (dni,codigo),
	foreign key (dni) references empleado,
	foreign key (codigo) references departamento);

--8) Insertar datos en trabajapara
insert into trabajapara(dni,codigo,horas) values (19302500,1,10),(35254310,1,10),(22958543,2,5),(27123456,2,10),(29332501,4,20),(13334401,1,10),(29332501,2,6),(35254310,4,10);

--9) Modificar el genero de un empleado
update empleado set genero = 'M' where dni=13334401;

--10) Realizar las consultas:
--a) Listar todos los empleados 
select * from empleado;
--b) Listar los empleados de género masculino 
select * from empleado where genero='M';
--c) Listar el mayor sueldo, el menor sueldo, el sueldo promedio de los empleados
select MAX(sueldo) as "mayor", MIN(sueldo) as "menor", AVG(sueldo) as "promedio" from empleado;
--d) Listar la cantidad de empleados cuyo sueldo supera 20000 
select count(dni) from empleado where sueldo>=20000;
--e) Listar el promedio de sueldos del departamento ‘COMPUTOS’ 
select AVG(empleado.sueldo) as "promedio" from empleado, trabajapara, departamento where (empleado.dni = trabajapara.dni) and (trabajapara.codigo = departamento.codigo) and (departamento.nombre = 'COMPUTOS');
--f) Listar cantidad de horas que se trabaja en el departamento ‘PRODUCCION’ 
select sum(horas) from trabajapara,departamento where (trabajapara.codigo = departamento.codigo) and (departamento.nombre = 'PRODUCCION'); 
--g) Listar los nombres de los empleados que trabajan al menos 6 horas para el departamento ‘DEPOSITO’ 
select empleado.nombre,empleado.apellido from empleado,trabajapara,departamento where (trabajapara.codigo = departamento.codigo) and (departamento.nombre = 'DEPOSITO') and (empleado.dni = trabajapara.dni) and (trabajapara.horas>=6)

--Practica realizada en clases
select e.dni, e.apellido,e.nombre,e.sueldo from empleado e where sueldo BETWEEN 20000 and 32000;
select nombre,apellido from empleado where apellido like 'R%' order by (apellido,nombre); 

select distinct t.codigo,t.dni,e.apellido, e.nombre,d.nombre from trabajapara t,empleado e,departamento d where e.dni=t.dni and t.codigo=d.codigo;

select avg(sueldo), genero from empleado group by (genero);
select count(dni), genero from empleado group by (genero);
select count(e.dni), (d.nombre) from empleado e, departamento d, trabajapara t where (e.dni=t.dni) and (d.codigo=t.codigo) group by d.nombre;
select count(dni),genero from empleado group by (genero) having (genero='F');