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
	WHERE NEW.usuario=co.usuario and ca.codigo=co.carrito and ca.codigo=lp.carrito and lp.producto=NEW.producto);
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
