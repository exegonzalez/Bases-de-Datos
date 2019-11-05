--Creamos las tablas de la BBDD
/*
create table rol(
  	codigo SERIAL,
	nombre varchar(25) NOT NULL unique,
	constraint nombre_rol check (nombre in
	('ADMINISTRADOR GENERAL','ADMINISTRADOR VENTAS','ADMINISTRADOR STOCK','CLIENTE')),
	constraint "rol_pkey" Primary Key (codigo)
);

/*CREATE EXTENSION citext;
CREATE DOMAIN email AS citext
  CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );
*/

create table usuario(
	email varchar(255) NOT NULL unique,
	nombreuser varchar(30) NOT NULL unique,
	contrasenia varchar(30) NOT NULL,
	rol integer NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL,
	direccion varchar(70),
	ciudad varchar(70),
	telefono varchar(15),
	constraint "usuario_pkey" Primary Key (email),
	foreign key (rol) references rol deferrable
);

create table tipo(
  	codigo SERIAL,
	nombre varchar(20) NOT NULL unique,
	constraint nombre_tipo check (nombre in
	('YERBA','MATE','BOMBILLA','TERMO','PORTATERMO','OTRO')),
	constraint "tipo_pkey" Primary Key (codigo)
);

create table proveedor(
	cuit varchar(11) NOT NULL unique,
	nombre varchar(50) NOT NULL,
	direccion varchar(70) NOT NULL,
	ciudad varchar(70) NOT NULL,
	email varchar(255) NOT NULL unique,
	telefono varchar(15),
	constraint "proveedor_pkey" Primary Key (cuit)
);

create table producto(
	codigo SERIAL,
	nombre varchar(50) NOT NULL,
	stock integer NOT NULL,
	precio float NOT NULL,
	stockmin integer NOT NULL,
	descripcion varchar(255) NOT NULL,
	calificacion float NOT NULL,
	proveedor varchar(11) NOT NULL,
	tipo integer NOT NULL,
	constraint "producto_pkey" Primary Key (codigo),	
	foreign key (proveedor) references proveedor deferrable,
	foreign key (tipo) references tipo deferrable
);

create table comentario(
	codigo SERIAL,
	fecha date NOT NULL,
	hora time NOT NULL,
	contenido varchar(255) NOT NULL,
	calificacion float,
	usuario varchar(255) NOT NULL,
	producto integer NOT NULL,
	constraint "comentario_pkey" Primary Key (codigo),
	foreign key (usuario) references usuario deferrable,
	foreign key (producto) references producto deferrable
);

create table combo(
	codigo SERIAL,
	nombre varchar(50) NOT NULL,
	precio float NOT NULL,
	fechainicio date NOT NULL,
	fechafinal date NOT NULL,
	descripcion varchar(255),
	constraint "combo_pkey" Primary Key (codigo)
);

create table productoxcombo(
	producto integer NOT NULL,
	combo integer NOT NULL,
	constraint "productoxcombo_pkey" Primary Key (producto,combo),	
	foreign key (producto) references producto deferrable,	
	foreign key (combo) references combo deferrable
);

create table carrito(
	codigo SERIAL,
	constraint "carrito_pkey" Primary Key (codigo)
);

create table linea(
	codigo SERIAL,
	cantidadproducto integer NOT NULL,
	totalproducto float NOT NULL,
	producto integer,
	combo integer,
	carrito integer NOT NULL,
	constraint "linea_pkey" Primary Key (codigo),	
	foreign key (carrito) references carrito deferrable,
	foreign key (producto) references producto deferrable,	
	foreign key (combo) references combo deferrable
);

create table compra(
	codigo SERIAL,
	total float NOT NULL,
	fecha date NOT NULL,
	hora time NOT NULL,
	numerotarjeta varchar(20) NOT NULL,
	tipotarjeta varchar(20),
	seguimiento SERIAL,
	carrito integer NOT NULL,
	usuario varchar(255) NOT NULL,
	constraint "compra_pkey" Primary Key (codigo),	
	foreign key (carrito) references carrito deferrable,
	foreign key (usuario) references usuario deferrable
);
*/



