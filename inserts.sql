-- Alters --

alter table producto
	alter column calificacion set default 0.00;
	alter column stockmin set default 5;
	
alter table combo
	alter column nombre type varchar(60);


-- INSERTS --

-- Proveedores --
insert into proveedor values('3011111111', 'Proveedor A', '3 de Febrero 111', 'Concepcion del Uruguay', 'proveedora@xmail.com', '11111111');
insert into proveedor values('3022222222', 'Proveedor B', 'Tibiletti 222', 'Concepcion del Uruguay', 'proveedorb@xmail.com', '22222222');
insert into proveedor values('3033333333', 'Proveedor C', 'Ingeniero Henry 313', 'Gualeguaychu', 'proveedorc@xmail.com', '33333333');
insert into proveedor values('3044444444', 'Proveedor D', 'Mariano Moreno 414', 'Colon', 'proveedord@xmail.com', '44444444');
insert into proveedor values('3055555555', 'Proveedor E', 'Justo Jose de Urquiza 441', 'Concepcion del Uruguay', 'proveedore@xmail.com', '55555555');
insert into proveedor values('3066666666', 'Proveedor F', 'Ferrari 564', 'Colon', 'proveedorf@xmail.com', '666666666');
insert into proveedor values('3077777777', 'Proveedor G', 'Sarmiento 112', 'San jose', 'proveedorg@xmail.com', '77777777');
insert into proveedor values('3088888888', 'Proveedor H', 'Mariano Moreno 512', 'Concepcion del Uruguay', 'proveedorh@xmail.com', '88888888');
insert into proveedor values('3099999999', 'Proveedor I', '25 de Mayo 167', 'Gualeguaychu', 'proveedori@xmail.com', '99999999');
insert into proveedor values('3000000000', 'Proveedor J', 'Almafuerte 128', 'Concepcion del Uruguay', 'proveedorj@xmail.com', '00000000');


-- Tipos --
insert into tipo values(1, 'MATE');
insert into tipo values(2, 'TERMO');
insert into tipo values(3, 'BOMBILLA');
insert into tipo values(4, 'PORTATERMO');
insert into tipo values(5, 'YERBA');
insert into tipo values(6, 	'OTRO');


-- Productos --
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Mate Uruguayo Calabaza', 10, 700, 'Mate Uruguayo hecho de las mejores calabazas', '3011111111', 1);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Mate Uruguayo Cuero', 10, 900, 'Mate Uruguayo de cuero; colores: negro y marron', '3011111111', 1);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Mate Madera', 10, 400, 'Mate hecho de madera de calden; colores: rosa, azul, amarillo, negro', '3022222222', 1);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Mate Uruguayo Camionero Premium', 10, 1200, 'Mates realizados con calabazas y cuero finamente seleccionados', '3033333333', 1);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Bombilla Pico Loro Tambor', 10, 295, 'Bombilla Uruguaya Pico de Loro, de acero inoxidable, tipo tambor', '3044444444', 3);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Bombilla Metalica', 10, 199, 'Bombillas metalicas de varios colores de tipo resorte', '3044444444', 3);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Yerba Marolio', 10, 100, 'Yerba Mate Marolio, Marolio le da sabor a tu vida', '3055555555', 5);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Bolso para Mate Tahg', 10, 750, 'Bolso con cierre, tipo tahg, con bolsillo frontal', '3066666666', 4);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Bolso para Mate Gamuza', 10, 859, 'Bolso porta termo negro de poliester con gamuza', '3066666666', 4);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Automate Forrado', 10, 400, 'Mate Listo Automate Forrado de Metal 500cc', '3088888888', 6);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Termo Waterdog', 10, 2100, 'Termo Waterdog de acero inoxidable, de 1 litro, tipo bala', '3099999999', 2);
insert into producto(nombre, stock, precio, descripcion, proveedor, tipo)
	values('Termo Aluminio', 10, 500, 'Termo Aluminio Doble Capa Varios Colores 1 Litro', '3099999999', 2);


-- Roles --
insert into rol(nombre) values('ADMINISTRADOR GENERAL');
insert into rol(nombre) values('ADMINISTRADOR VENTAS');
insert into rol(nombre) values('ADMINISTRADOR STOCK');
insert into rol(nombre) values('CLIENTE');


-- Usuarios --
insert into usuario() values(
	'exe.gye@gmail.com', 'Exegye', 'exe123', 1, 'Exequiel', 'Gonzalez', '25 de Agosto 231', 'Concepcion del Uruguay', '3442647543');
insert into usuario() values(
	'juancurtoni@gmail.com', 'Pipa Benedeto', 'juan123', 2, 'Juan', 'Curtoni', 'San Martin 362', 'Concepcion del Uruguay', '3445536635');
insert into usuario() values(
	'sanchezhernan@gmail.com', 'Hornit0', 'hernan123', 3, 'Hernan', 'Sanchez', 'J. Peron 465', 'Concepcion del Uruguay', '3445431625');
insert into usuario() values(
	'lazaro.com', 'Lazaro', 'laza123', 4, 'Lazaro', 'Rodriguez', '9 de Julio 3441', 'La Plata', '2114526721');
insert into usuario() values(
	'kevinchen.com', 'Kevin', 'kevin123', 4, 'Kevin', 'Chen', '12 de Octubre 552', 'Concepcion del Uruguay', '3442647543');
insert into usuario() values(
	'verocafrete.com', 'Verost', 'vero123', 4, 'Veronica', 'Frete', 'J. J. Urquiza 41', 'Posadas', '3764256216');
insert into usuario() values(
	'danieldorado@gmail.com', 'Puerco', 'dani123', 4, 'Daniel', 'Dorado', 'Corrientes 467', 'Cordoba', '3511232597');
insert into usuario() values(
	'luisreyes@gmail.com', 'Exegye', 'exe123', 4, 'Exequiel', 'Gonzalez', '25 de Agosto 231', 'Mar del Plata', '2236548962');
insert into usuario() values(
	'tamaralozano@gmail.com', 'Tami22', 'tami123', 4, 'Tamara', 'Lozano', 'Colon 668', 'Naschel', '2656332584');
insert into usuario() values(
	'carlospalacios@gmail.com', 'CarlosP', 'carlos123', 4, 'Carlos', 'Palacios', '3 de Febrero 989', 'General Pico', '2302424562');



-- Combos --
insert into combo(nombre, precio, fechainicio, fechafinal, descripcion) values(
	'Combo de Mate Calabaza y bombilla Pico Loro', 950, '2009-11-13', '2010-11-13', 'Mate Uruguayo hecho de las mejores calabazas con Bombilla Uruguaya Pico de Loro, de acero inoxidable, tipo tambor');
insert into combo(nombre, precio, fechainicio, fechafinal, descripcion) values(
	'Combo de Mate Premium y bombilla Pico Loro', 1425, '2009-11-13', '2010-11-13', 'Mate realizado con calabazas y cuero finamente seleccionados con Bombilla Uruguaya Pico de Loro, de acero inoxidable, tipo tambor');
insert into combo(nombre, precio, fechainicio, fechafinal, descripcion) values(
	'Combo de Mate, Bombilla, Termo Aluminio y Bolso para Mate', 2000, '2009-11-13', '2010-11-13', 'Mate Uruguayo hecho de las mejores calabazas con Bombilla Matelica tipo resorte, Termo Aluminio Doble Capa y Bolso con cierre, tipo tahg con cierre frontal');


-- ProductoxCombo --
insert into productoxcombo values(
	18, 1);
insert into productoxcombo values(
	22, 1);
insert into productoxcombo values(
	21, 2);
insert into productoxcombo values(
	22, 2);
insert into productoxcombo values(
	18, 3);
insert into productoxcombo values(
	23, 3);
insert into productoxcombo values(
	29, 3);
insert into productoxcombo values(
	25, 3);

select * from productoxcombo
select * from producto