/*create table persona(
	dni integer primary key,
	apellido varchar(30),
	nombre varchar(30),
	fecnac date,
	estadoCivil varchar(10),
	constraint CH_Persona_EstadoCivil check (estadoCivil in
	('SOLTERO','CASADO','VIUDO','DIVORCIADO'))
)*/

/*CREATE OR REPLACE FUNCTION func_e() RETURNS TRIGGER AS $funcemp$
DECLARE
	edad smallint ;
	estadocivil varchar(10);
BEGIN
	NEW.estadoCivil := UPPER(NEW.estadoCivil);
	edad := date_part('year',age(NEW.fecnac));
	IF NEW.apellido = '' THEN
		RAISE EXCEPTION 'no puede tener apellido vacío';
	END IF;
	IF edad < '18' THEN
		RAISE EXCEPTION 'no puede ser menor de 18 años';
	END IF;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;*/

/*CREATE TRIGGER trigger_e BEFORE INSERT OR UPDATE ON persona
FOR EACH ROW EXECUTE PROCEDURE func_e();*/

/*CREATE OR REPLACE FUNCTION func_p() RETURNS TRIGGER AS $funcemp$
DECLARE
BEGIN
	NEW.estadoCivil := UPPER(NEW.estadoCivil);
	if OLD.estadoCivil = 'SOLTERO' AND (NEW.estadoCivil = 'VIUDO' or
		NEW.estadoCivil='DIVORCIADO') THEN
		RAISE EXCEPTION 'ERROR de transición en estado civil';
	END IF;
	if (OLD.estadoCivil = 'CASADO' or OLD.estadoCivil = 'DIVORCIADO' OR OLD.estadoCivil =
		'VIUDO') AND (NEW.estadoCivil = 'SOLTERO') THEN
		RAISE EXCEPTION 'ERROR de transición en estado civil';
	END IF;
	if OLD.estadoCivil = 'DIVORCIADO' AND (NEW.estadoCivil = 'VIUDO') THEN
		RAISE EXCEPTION 'ERROR de transición en estado civil';
	END IF;
	if OLD.estadoCivil = 'VIUDO' AND (NEW.estadoCivil = 'DIVORDIADO') THEN
		RAISE EXCEPTION 'ERROR de transición en estado civil';
	END IF;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;*/

/*CREATE TRIGGER trigger_p BEFORE UPDATE ON persona
FOR EACH ROW EXECUTE PROCEDURE func_p();*/

--INSERT into persona (dni, apellido,nombre,fecnac,estadoCivil) values (1,'','juan','8/09/1994','soltero')
--INSERT into persona (dni, apellido,nombre,fecnac,estadoCivil) values (3,'gonzalez','luis','8/09/2003','soltero')
--INSERT into persona (dni, apellido,nombre,fecnac,estadoCivil) values (2,'dominguez','juan','8/09/1994','casado')
--update persona set estadoCivil='soltero' where dni=2 
--update persona set apellido='martinez' where dni=1
--update persona set estadoCivil='divorciado' where dni=1
--update persona set fecnac='29-08-2001' where dni=1
--update persona set estadoCivil='viudo' where dni=2

/*create table auditoria(
  	id SERIAL,
	operacion varchar,
	constraint CH_operacion check (operacion in
	('INSERT','DELETE','UPDATE')),
	fechaHora date,
	nombTabla varchar(20),
	usuario varchar,
	valorAnt varchar,
	valorAct varchar,
	primary key(id)
);*/

/*CREATE OR REPLACE FUNCTION func_auditoria() RETURNS TRIGGER AS $auditoria$
DECLARE
BEGIN 
	if (TG_OP='INSERT') THEN
		insert into auditoria (operacion,fechaHora,nombTabla,usuario,valorAnt,valorAct) select 'INSERT', now(), TG_TABLE_NAME, user, null, NEW;
	elseif (TG_OP='DELETE') then
		insert into auditoria (operacion,fechaHora,nombTabla,usuario,valorAnt,valorAct)select 'DELETE', now(), TG_TABLE_NAME, user, OLD, null;
 	elseif (TG_OP='UPDATE') then
		insert into auditoria (operacion,fechaHora,nombTabla,usuario,valorAnt,valorAct)select 'UPDATE', now(), TG_TABLE_NAME, user, OLD, NEW;
	end if;
RETURN NEW;
END; 
$auditoria$ LANGUAGE plpgsql;*/

/*CREATE TRIGGER trigger_auditoria AFTER UPDATE or INSERT or DELETE ON persona
FOR EACH ROW EXECUTE PROCEDURE func_auditoria();*/

--INSERT into persona (dni, apellido,nombre,fecnac,estadoCivil) values (7,'perez','carlos','14/08/1998','viudo')
--UPDATE persona set estadoCivil='casado' where dni=7;
--select * from auditoria