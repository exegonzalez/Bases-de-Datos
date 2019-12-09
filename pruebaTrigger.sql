-- 1. Controlar que cuando se carga una línea solo puede haber un producto o combo, no ambos --
--> Se inserta una linea sin producto ni combo.
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(6, 10000, null, null, 9);
--> Se inserta una linea con un producto y un combo.
insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(4, 5200, 2, 4, 8);

-- 2. Controlar que para calificar un producto, se debe haber realizado una compra del mismo previamente --
--> Se inserta una calificacion de un usuario que NO compro el producto
insert into calificacion(calificacion, fecha, hora, usuario, producto) values(4,'2017-10-25','22:00:00','luisreyes@gmail.com',1);

-- 3. Cuando se realiza una calificación, actualizar la calificación actual del producto --
--> Se inserta una calificacion del producto "3", que tenia previamente una calificacion 5.
insert into calificacion(calificacion, fecha, hora, usuario, producto) values(1,'2019-04-14','10:22:46','kevinchen@gmail.com',3);
select * from producto where codigo=3;

-- 4. Verificacion de que solamente el estado ESPERA de la compra pase a otro estado, y control de que en la actualizacion
-- no se cambien otros datos de la compra --
--> Este update muestra como el trigger impide actualizar una compra que ya se encontraba FINALIZADA
update compra set estado='CANCELADA' where codigo=1;
--> Insertamos una nueva compra que esta en un estado por defecto de en ESPERA
insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
	600,'2017-11-25', '11:29:15', '4411666612214488', 'VISA', 13,'luisreyes@gmail.com');
--> Intentamos actualizar el estado de la compra cambiando ademas otros datos, como el total y el numero de tarjeta.
update compra set estado='FINALIZADA', total=200, numerotarjeta='1111000022221111' where codigo=13;
--> Cancelamos la compra
update compra set estado='CANCELADA' where codigo=13;
--> Intentamos cambiar el estado de la compra cancelada
update compra set estado='FINALIZADA' where codigo=13;

-- 5. Verificacion de que la cantidad de productos a comprar en una linea, sea menor o igual que el stock disponible --
--> Actualizamos la cantidad de productos a comprar de la linea 19, donde se compra el combo 10, 
-- en el cual un producto tiene stock 500 y el otro 494.
update linea set cantidadproducto=500 where codigo=19;

--> Actualizamos la cantidad de productos a comprar de la linea 1, donde se compra el producto 3, 
-- que tiene un stock de 500.
update linea set cantidadproducto=505 where codigo=1;