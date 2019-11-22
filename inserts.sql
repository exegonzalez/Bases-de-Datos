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
insert into tipo values(6, 'OTRO');


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
insert into usuario values(
	'exe.gye@gmail.com', 'Exegye', 'exe123', 1, 'Exequiel', 'Gonzalez', '25 de Agosto 231', 'Concepcion del Uruguay', '3442647543');
insert into usuario values(
	'juancurtoni@gmail.com', 'Pipa Benedeto', 'juan123', 2, 'Juan', 'Curtoni', 'San Martin 362', 'Concepcion del Uruguay', '3445536635');
insert into usuario values(
	'sanchezhernan@gmail.com', 'Hornit0', 'hernan123', 3, 'Hernan', 'Sanchez', 'J. Peron 465', 'Concepcion del Uruguay', '3445431625');
insert into usuario values(
	'lazaro@gmail.com', 'Lazaro', 'laza123', 4, 'Lazaro', 'Rodriguez', '9 de Julio 3441', 'La Plata', '2114526721');
insert into usuario values(
	'kevinchen@gmail.com', 'Kevin', 'kevin123', 4, 'Kevin', 'Chen', '12 de Octubre 552', 'Concepcion del Uruguay', '3442647543');
insert into usuario values(
	'verocafrete@gmail.com', 'Verost', 'vero123', 4, 'Veronica', 'Frete', 'J. J. Urquiza 41', 'Posadas', '3764256216');
insert into usuario values(
	'danieldorado@gmail.com', 'Puerco', 'dani123', 4, 'Daniel', 'Dorado', 'Corrientes 467', 'Cordoba', '3511232597');
insert into usuario values(
	'luisreyes@gmail.com', 'Luisito', 'luis123', 4, 'Luis', 'Reyes', '25 de Agosto 231', 'Mar del Plata', '2236548962');
insert into usuario values(
	'tamaralozano@gmail.com', 'Tami22', 'tami123', 4, 'Tamara', 'Lozano', 'Colon 668', 'Naschel', '2656332584');
insert into usuario values(
	'carlospalacios@gmail.com', 'CarlosP', 'carlos123', 4, 'Carlos', 'Palacios', '3 de Febrero 989', 'General Pico', '2302424562');

-- Combos --
insert into combo(nombre, precio, fechainicio, fechafinal, descripcion) values(
	'Combo de Mate Calabaza y bombilla Pico Loro', 995, '2009-11-13', '2010-11-13', 'Mate Uruguayo hecho de las mejores calabazas con Bombilla Uruguaya Pico de Loro, de acero inoxidable, tipo tambor');
insert into combo(nombre, precio, fechainicio, fechafinal, descripcion) values(
	'Combo de Mate Premium y bombilla Pico Loro', 1495, '2009-11-13', '2010-11-13', 'Mate realizado con calabazas y cuero finamente seleccionados con Bombilla Uruguaya Pico de Loro, de acero inoxidable, tipo tambor');
insert into combo(nombre, precio, fechainicio, fechafinal, descripcion) values(
	'Combo de Mate, Bombilla, Termo Aluminio y Bolso para Mate', 2149, '2009-11-13', '2010-11-13', 'Mate Uruguayo hecho de las mejores calabazas con Bombilla Matelica tipo resorte, Termo Aluminio Doble Capa y Bolso con cierre, tipo tahg con cierre frontal');
insert into combo(nombre, precio, fechainicio, fechafinal, descripcion) values(
	'Combo de Mate Uruguayo Cuero y Mate Uruguayo Calabaza', 1600, '2011-10-15', '2013-12-07', 'Promocion de dos Mates Uruguayos -Calabaza y Cuero-');

-- ProductoxCombo --
insert into productoxcombo values(1, 1);
insert into productoxcombo values(5, 1);
insert into productoxcombo values(4, 2);
insert into productoxcombo values(5, 2);
insert into productoxcombo values(1, 3);
insert into productoxcombo values(6, 3);
insert into productoxcombo values(12, 3);
insert into productoxcombo values(8, 3);
insert into productoxcombo values(1, 4);
insert into productoxcombo values(2, 4);

-- Comentario -- 
insert into comentario(fecha, hora, contenido, calificacion, usuario, producto) values(
	'2019-10-14', '12:30:42', 'Producto de excelente calidad, muy recomendado', 8, 'exe.gye@gmail.com',4);
insert into comentario(fecha, hora, contenido, calificacion, usuario, producto) values(
	'2019-08-14', '22:10:00', 'El producto funciona correctamente', 9, 'juancurtoni@gmail.com',2);
insert into comentario(fecha, hora, contenido, calificacion, usuario, producto) values(
	'2017-02-03', '05:30:22', 'Producto de buena calidad a un precio barato', 9, 'lazaro@gmail.com',8);
insert into comentario(fecha, hora, contenido, calificacion, usuario, producto) values(
	'2018-12-01', '16:57:29', 'El producto no era lo que esperaba', 3, 'luisreyes@gmail.com',11);
insert into comentario(fecha, hora, contenido, calificacion, usuario, producto) values(
	'2019-09-11', '08:02:57', 'Buen producto', 6, 'carlospalacios@gmail.com',6);
insert into comentario(fecha, hora, contenido, calificacion, usuario, producto) values(
	'2018-04-24', '22:05:20', 'Excelente calidad', 9, 'exe.gye@gmail.com',1);
insert into comentario(fecha, hora, contenido, calificacion, usuario, producto) values(
	'2011-03-30', '01:40:40', 'Demasiado caro el producto', 2, 'carlospalacios@gmail.com',6);
insert into comentario(fecha, hora, contenido, calificacion, usuario, producto) values(
	'2014-02-01', '09:29:50', 'Producto super recomendado', 10, 'verocafrete@gmail.com',7);
insert into comentario(fecha, hora, contenido, calificacion, usuario, producto) values(
	'2016-10-25', '19:04:20', 'El producto llego a tiempo y sin problemas', 8, 'sanchezhernan@gmail.com',11);
insert into comentario(fecha, hora, contenido, calificacion, usuario, producto) values(
	'2015-01-30', '02:49:13', 'El producto llego una semana mas tarde', 4, 'juancurtoni@gmail.com',5);

-- Carrito --
insert into carrito values (nextval('carrito_codigo_seq'));
insert into carrito values (nextval('carrito_codigo_seq'));
insert into carrito values (nextval('carrito_codigo_seq'));
insert into carrito values (nextval('carrito_codigo_seq'));
insert into carrito values (nextval('carrito_codigo_seq'));
insert into carrito values (nextval('carrito_codigo_seq'));

-- Linea -- 
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(6, 2400, 3, null, 2);
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(3, 4485, null, 2, 1);
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(20, 3980, 6, null, 3);
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(1, 995, null, 1, 1);
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(5, 2000, 10, null, 4);
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(10, 7000, 1, null, 3);
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(30, 3000, 7, null, 5);
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(4, 8596, null, 3, 6);
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(15, 24000, null, 4, 6);
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(18, 16200, 2, null, 3);

-- Compra --
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	2400,'2019-04-24', '09:22:11', '3000000022222222', 'VISA', 2,'exe.gye@gmail.com');
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	5480,'2018-06-12', '22:06:59', '9999888877776666', 'VISA', 1,'juancurtoni@gmail.com');
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	27180,'2017-11-28', '15:42:10', '1111222233334444', 'MASTERCARD', 3,'lazaro@gmail.com');
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	2000,'2014-04-03', '19:30:46', '2222333344449999', 'MASTERCARD', 4,'exe.gye@gmail.com');
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	3000,'2018-06-22', '10:20:37', '4444555544445555', 'NARANJA', 5,'danieldorado@gmail.com');
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	32596,'2019-02-24', '02:24:19', '9999222211110000', 'NARANJA', 6,'luisreyes@gmail.com');
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	27180,'2015-10-31', '07:14:49', '8888444499992222', 'CABAL', 3,'juancurtoni@gmail.com');
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	2000,'2016-08-14', '20:56:11', '1111333311112222', 'CABAL', 4,'juancurtoni@gmail.com');
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	2000,'2019-01-02', '23:11:00', '5555333322221111', 'VISA', 4,'carlospalacios@gmail.com');
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	2400,'2017-05-12', '13:48:15', '4444000044440000', 'MASTERCARD', 2,'kevinchen@gmail.com');

		
