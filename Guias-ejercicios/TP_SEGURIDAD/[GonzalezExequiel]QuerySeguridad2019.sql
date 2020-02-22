/*
--a) Crear dos usuarios
CREATE USER user1 PASSWORD '111';
CREATE USER user2 PASSWORD '222';

--b) Crear dos tablas
CREATE TABLE tabla2(
	nrodpto SERIAL,
	nombdpto varchar(50) NOT NULL,
	primary key(nrodpto)
)

CREATE TABLE tabla1(
	id SERIAL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL,
	sueldo float NOT NULL,
	nrodpto integer NOT NULL,
	primary key(id),
	foreign key (nrodpto) references tabla2
)

--c) Otorgar los siguientes permiso:
--ALL al usuario root de postgres sobre ambas tablas
--User1 Insert, Select sobre tabla1
--User2 todos los permisos sobre tabla2

GRANT ALL ON tabla1, tabla2 TO postgres
GRANT insert, select ON tabla1 TO user1
GRANT ALL on tabla2 TO user2
GRANT USAGE, SELECT ON SEQUENCE tabla1_id_seq TO user1;
GRANT USAGE, SELECT ON SEQUENCE tabla2_nrodpto_seq TO user1;
GRANT USAGE, SELECT ON SEQUENCE tabla1_id_seq TO user2;
GRANT USAGE, SELECT ON SEQUENCE tabla2_nrodpto_seq TO user2;

--d) Insertar datos (3 tuplas) en ambas tablas

Insert into tabla2(nombdpto) values('departamento1');
Insert into tabla2(nombdpto) values('departamento2');
Insert into tabla2(nombdpto) values('departamento3');
Insert into tabla1(nombre,apellido,sueldo,nrodpto) values('Juan','Perez',10000,1);
Insert into tabla1(nombre,apellido,sueldo,nrodpto) values('Martin','Lopez',15000,2);
Insert into tabla1(nombre,apellido,sueldo,nrodpto) values('Leandro','Gonzalez',20000,3);


--e) Logearse como User1 y realizar las siguientes operaciones:
-- Insert y select en tabla1
-- Select en tabla2
-- Registrar lo que pasa en el DBMS

--Crear nuevo servidor -> host: localhost -> user:user1 -> contaseña:111
Insert into tabla1(nombre,apellido,sueldo,nrodpto) values('Adrian','Lopez',17000,1);
--Funciono correctamente
Select * from tabla1;	
--Funciono correctamente
Select * from tabla2;
--El user1 no tiene permiso para hacer un select en la tabla2

--f) Logearse como User2 y realizar las siguientes operaciones
-- Update en tabla2
-- Select en tabla1
-- Registrar lo que pasa en el DBMS

Update tabla2 set nombdpto='nuevodepartamento3' where nrodpto=1;
--Funciono correctamente

Select * from tabla1
--El user2 no tiene permiso para hacer un select en la tabla1

--g) Modifique los permisos de User2 para que pueda realizar select en tabla1
GRANT select on tabla1 TO user2

--h) Logearse como User2 y probar realizar Select sobre tabla1
-- Registrar lo que pasa en el DBMS

Select * from tabla1
--Funciono correctamente

--i) Investigue y prueba funciones de criptografía en PostgreSql
--Pgcrypto es una extensión para encriptar datos en Postgresql, se la agrega de la siguiente forma:

create extension pgcrypto

--Ejemplo de uso:
CREATE TABLE usuario
(
 id serial NOT NULL,
 usuario character varying(15) NOT NULL,
 clave bytea
);

--Ingresamos datos, utilizando la funcion "encrypt" para realizar la encriptacion, el primer parametro es la clave 
--a encriptar, el segundo es la clave de encriptacion y el tercero el algoritmo utilizado:
insert into usuario (usuario, clave) values ('alex', encrypt('11112222', 'password','3des'));

--Hacemos un select para ver el dato cifrado en la tabla
select * from usuario;

--Para desencriptar el valor se utiliza la funcion decrypt
select usuario, encode(decrypt(clave,'password','3des'::text), 'escape'::text) AS clave from usuario

--j) Realizar dos funciones de criptografía:
-- Primero elija alguno de los siguientes atributos para realizar criptografía sobre sus valores: nombre, apellido, sueldo.
-- Realice la función de criptografía para encriptar los valores del atributo elegido
-- Realice la función para desencriptar los valores del mismo atributo
-- Probar ambas funciones realizando insert, update y select
-- Nota: utilice los criterios de criptografía que crea conveniente.

CREATE OR REPLACE FUNCTION encriptar(nombre varchar) RETURNS varchar AS $$
DECLARE
	nomb varchar;
	aux integer;
	i integer;
	cadena varchar;
BEGIN
	FOR i IN 1..length(nombre)
	loop
		nomb=(select substring(nombre from i for i));
		aux= (select(ascii(nomb)));
		aux= aux+length(nombre);
		cadena= (select(concat(cadena,chr(aux))));
	END loop;
	RETURN cadena;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION desencriptar(nombre varchar) RETURNS varchar AS $$
DECLARE
	nomb varchar;
	aux integer;
	i integer;
	cadena varchar;
BEGIN
	FOR i IN 1..length(nombre)
	loop
		nomb=(select substring(nombre from i for i));
		aux= (select(ascii(nomb)));
		aux= aux-length(nombre);
		cadena= (select(concat(cadena,chr(aux))));
	END loop;
	RETURN cadena;
END; 
$$ LANGUAGE plpgsql;

insert into tabla1(nombre,apellido,sueldo,nrodpto) values((select encriptar('Pedro')),'Gimenez',7000,2);
select nombre from tabla1 where id=8;
select desencriptar(nombre) from tabla1 where id=8;

Update tabla1 set nombre=encriptar('Alejandro') where id=8;
select * from tabla1 where id=8;
select desencriptar(nombre) from tabla1 where id=8;
*/
