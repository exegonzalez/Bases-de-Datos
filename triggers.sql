-- Triggers

-- 1. Controlar que cuando se carga una línea solo puede haber un producto o combo, no ambos --
CREATE OR REPLACE FUNCTION controlLinea() RETURNS TRIGGER AS $funcemp$
DECLARE
BEGIN
	IF ((NEW.producto is null) and (NEW.combo is not null)) THEN
		RETURN NEW;
	ELSIF ((NEW.combo is null) and (NEW.producto is not null)) THEN
		RETURN NEW;
	ELSE
		RAISE EXCEPTION 'Solo se puede tener un producto o combo por linea';
	END IF;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER triggerControlLinea BEFORE INSERT OR UPDATE ON linea
FOR EACH ROW EXECUTE PROCEDURE controlLinea();

-- Prueba Trigger: Inserts de una linea con un producto y combo simultaneamente, o ninguno.
--insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(6, 10000, null, null, 9);
--insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(4, 5200, 2, 4, 8);

-- 2. Controlar que para calificar un producto, se debe haber realizado una compra del mismo previamente --
CREATE OR REPLACE FUNCTION controlCalificacionCompra() RETURNS TRIGGER AS $funcemp$
DECLARE
productoCompra bigint;
BEGIN
	productoCompra:= (select count(lp.producto) from compra co, carrito ca, lineaProductos lp
	WHERE NEW.usuario=co.usuario and ca.codigo=co.carrito and ca.codigo=lp.carrito and lp.producto=NEW.producto and co.estado='FINALIZADA');
	IF (productoCompra!=0) THEN
		RETURN NEW;
	ELSE
		RAISE EXCEPTION 'Debe realizar alguna compra del producto para poder calificarlo';
	END IF;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER triggerControlCalificacionCompra BEFORE INSERT OR UPDATE ON calificacion
FOR EACH ROW EXECUTE PROCEDURE controlCalificacionCompra();
		
-- Prueba Trigger: Inserts de una calificacion de un usuario que NO compro el producto
--insert into calificacion(calificacion, fecha, hora, usuario, producto) values(4,'2017-10-25','22:00:00','luisreyes@gmail.com',1);


-- 3. Cuando se realiza una calificación, actualizar la calificación actual del producto​ --
create or replace function actualizarCalificacion() RETURNS TRIGGER AS $funcemp$
declare
	promedio float;
	calif integer;
BEGIN
	promedio:= (select avg(calificacion) from calificacion where producto=NEW.producto);
	calif:= CAST ((select ROUND(promedio)) AS integer);
	update producto set calificacion=calif where codigo=NEW.producto;
	return new;
END;$funcemp$ LANGUAGE plpgsql;

create trigger triggerActualizarCalificacion after insert or update on calificacion
for each row execute procedure actualizarCalificacion();

-- Prueba Trigger: insert de una calificacion del producto "3", que tenia previamente una calificacion 5.
--insert into calificacion(calificacion, fecha, hora, usuario, producto) values(1,'2019-04-14','10:22:46','kevinchen@gmail.com',3);
--select * from producto where codigo=3;

-- 4. Verificacion de que solamente el estado ESPERA de la compra pase a otro estado, y control de que en la actualizacion
-- no se cambien otros datos de la compra.
create or replace function cambiarEstadoCompra() RETURNS TRIGGER AS $funcemp$
declare
BEGIN
	IF (OLD.estado='CANCELADA') THEN
		RAISE EXCEPTION 'No se puede cambiar el estado de una compra cancelada';
	ELSIF (OLD.estado='FINALIZADA') THEN
		RAISE EXCEPTION 'No se puede cambiar el estado de una compra finalizada';
	ELSIF (OLD.estado='ESPERA' and OLD.total=NEW.total and OLD.fecha=NEW.fecha and OLD.hora=NEW.hora and 
		  OLD.numerotarjeta=NEW.numerotarjeta and OLD.tipotarjeta=NEW.tipotarjeta and OLD.carrito=NEW.carrito and
		  OLD.usuario=NEW.usuario) THEN
		RETURN NEW;
	ELSE
		RAISE EXCEPTION 'No se pueden cambiar los valores de la compra, solo su estado';
	END IF;
END;$funcemp$ LANGUAGE plpgsql;

create trigger triggerControlCompra BEFORE update on compra
for each row execute procedure cambiarEstadoCompra();

-- Este update muestra como el trigger impide actualizar una compra que ya se encontraba FINALIZADA
--update compra set estado='CANCELADA' where codigo=1;

-- Insertamos una nueva compra que esta en un estado en ESPERA
--insert into compra(total, fecha, hora, numerotarjeta, tipotarjeta, carrito, usuario) values(
--	600,'2017-11-25', '11:29:15', '4411666612214488', 'VISA', 13,'luisreyes@gmail.com');
-- Intentamos actualizar el estado de la compra cambiando ademas otros datos, como el total y el numero de tarjeta.
--update compra set estado='FINALIZADA', total=200, numerotarjeta='1111000022221111' where codigo=13;
-- Cancelamos la compra
--update compra set estado='CANCELADA' where codigo=13;
-- Intentamos cambiar el estado de la compra cancelada
--update compra set estado='FINALIZADA' where codigo=13;

-- 4. Verificacion de que la cantidad de productos a comprar en una linea, sea menor o igual que el stock disponible
create or replace function cantidadProductosLinea() RETURNS TRIGGER AS $funcemp$
declare  
	cantidad integer;
	valor boolean;
BEGIN
	IF ((NEW.combo is null) and (NEW.producto is not null)) THEN
		cantidad:= (select p.stock from producto p where p.codigo=NEW.producto);
		IF(cantidad<NEW.cantidadproducto) THEN
			RAISE EXCEPTION 'La cantidad de productos a comprar excede el stock';
		ELSE
			return new;
		END IF;
	ELSIF ((NEW.producto is null) and (NEW.combo is not null)) THEN
		valor:= cantidadLineaProductosCombo(NEW.cantidadproducto, NEW.combo);
		IF(cantidad)THEN
			return new;
		ELSE
			RAISE EXCEPTION 'La cantidad de productos a comprar excede el stock';
		END IF;
	END IF;
END;$funcemp$ LANGUAGE plpgsql;

create trigger cantidadProductosLinea BEFORE insert or update on linea
for each row execute procedure cantidadProductosLinea();

-- Actualizamos la cantidad de productos a comprar de la linea 10, donde se compra el combo 10, 
-- en el cual un producto tiene stock 500 y el otro 494.
update linea set cantidadproducto=500 where codigo=10;

-- Actualizamos la cantidad de productos a comprar de la linea 1, donde se compra el producto 3, 
-- que tiene un stock de 500.
update linea set cantidadproducto=505 where codigo=1;

