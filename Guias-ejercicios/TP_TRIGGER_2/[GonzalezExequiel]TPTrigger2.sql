--Ejercicio 1

create table empleado(
	dni integer NOT NULL, 
	apellido text NOT NULL, 
	nombre text NOT NULL, 
	salario integer default 15000, 
	jefe integer,
	constraint "empleado_pkey" Primary Key (dni),
	foreign key (jefe) references empleado deferrable
);

INSERT INTO empleado(dni,apellido,nombre) VALUES (1,'perez','juan');
INSERT INTO empleado(dni,apellido,nombre) VALUES (2,'lopez','pablo');
INSERT INTO empleado(dni,apellido,nombre) VALUES (3,'gonzalez','carlos');
INSERT INTO empleado(dni,apellido,nombre,jefe) VALUES (4,'ruiz','luciano',3);
INSERT INTO empleado(dni,apellido,nombre,jefe) VALUES (5,'cepeda','leandro',2);
INSERT INTO empleado(dni,apellido,nombre,jefe) VALUES (6,'sanchez','pablo',3);
INSERT INTO empleado(dni,apellido,nombre,jefe) VALUES (7,'cesar','julio',1);

CREATE OR REPLACE FUNCTION func_3_emp() RETURNS TRIGGER AS $funcemp$
DECLARE
BEGIN
	if((Select count(e.jefe) from empleado e where e.jefe=new.jefe)>=3) then
		RAISE EXCEPTION 'el jefe ya tiene 3 empleados';
	End if;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_3_empleados BEFORE INSERT OR UPDATE ON empleado
FOR EACH ROW EXECUTE PROCEDURE func_3_emp();

INSERT INTO empleado(dni,apellido,nombre,jefe) VALUES (8,'perez','martin',3);
INSERT INTO empleado(dni,apellido,nombre,jefe) VALUES (9,'ruiz','nicolas',3);

--b. Crear un Trigger para que un empleado no gane más que su jefe.
CREATE OR REPLACE FUNCTION func_salario_emp_jefe() RETURNS TRIGGER AS $funcemp$
DECLARE
BEGIN
	if((Select count(dni) from empleado e where e.dni=new.jefe and e.salario<new.salario)<>0) then
		RAISE EXCEPTION 'el empleado gana mas que el jefe';
	End if;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_salario_emp_jefe BEFORE INSERT OR UPDATE ON empleado
FOR EACH ROW EXECUTE PROCEDURE func_salario_emp_jefe();

INSERT INTO empleado(dni,apellido,nombre,jefe) VALUES (10,'soria','lucas',1);
INSERT INTO empleado(dni,apellido,nombre,salario,jefe) VALUES (11,'pescio','pablo',16000,1);

--c. Crear un Trigger para que no se puede aumentar más del 15% del salario de ningún empleado.
CREATE OR REPLACE FUNCTION func_aumentar_salario_15() RETURNS TRIGGER AS $funcemp$
DECLARE
	porcentaje float;
BEGIN
	porcentaje := (15*old.salario)/100; 
	if(old.salario+porcentaje<new.salario) then
		RAISE EXCEPTION 'no se puede aumentar mas del 15 el salario';
   	End if;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_aumento_salario_15 BEFORE UPDATE ON empleado
FOR EACH ROW EXECUTE PROCEDURE func_aumentar_salario_15();

UPDATE empleado SET salario=50000  WHERE dni=1;

create table departamento(
	id serial, 
	nombre text NOT NULL, 
	jefe integer unique,
	constraint "departamento_pkey" Primary Key (id),
	foreign key (jefe) references empleado deferrable
);

create table trabajapara(
	dni integer NOT NULL,
	id integer NOT NULL,
	constraint "trabajapara_pkey" Primary Key (dni,id),
	foreign key (id) references departamento deferrable,
	foreign key (dni) references empleado deferrable
);

INSERT INTO departamento(nombre,jefe) values ('COMPUTOS',1);
INSERT INTO departamento(nombre,jefe) values ('PRODUCCION',2);
INSERT INTO departamento(nombre,jefe) values ('VENTAS',3);

INSERT INTO trabajapara(dni,id) values (1,1);
INSERT INTO trabajapara(dni,id) values (2,2);
INSERT INTO trabajapara(dni,id) values (3,3);

--i.Ningún empleado debe pertenecer a un departamento distinto de su jefe.
CREATE OR REPLACE FUNCTION func_departamento_distinto() RETURNS TRIGGER AS $funcemp$
DECLARE
	dnijefe integer;
BEGIN
	dnijefe= (select jefe from empleado where new.dni=dni);
	if((select t.id from trabajapara t where t.dni=dnijefe)<>new.id) then
		RAISE EXCEPTION 'no se puede añadir un empleado al departamento que no sea el mismo del jefe';
   	End if;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_departamento_distinto BEFORE INSERT OR UPDATE ON trabajapara
FOR EACH ROW EXECUTE PROCEDURE func_departamento_distinto();

INSERT INTO trabajapara(dni,id) values (4,1);

