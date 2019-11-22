-- Triggers

-- 1. Controlar que cuando se carga una línea solo puede haber un producto o combo, no ambos --
CREATE OR REPLACE FUNCTION controlLinea() RETURNS TRIGGER AS $funcemp$
DECLARE
	combo integer ;
	producto integer;
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

-- Actualiza la calificacion del producto cuando se inserta un comentario
create or replace function actualizarCalificacion() returns trigger as $$
declare
	calif float;
	sumatoria float;
	dividendo integer;
begin
	calif = new.calificacion;
	sumatoria = (select sum(calificacion)
		from comentario
		where producto = new.producto)
	;
	dividendo := (
		select count(producto)
		from comentario
		where producto = new.producto
	);
	dividendo = dividendo + 1;
	sumatoria = sumatoria + calif;
	calif = sumatoria / dividendo;
	update producto set calificacion = calif
		where codigo = new.producto;
	return new;
end;$$ language plpgsql;

create trigger triggerActCalific before insert or update on comentario
for each row execute procedure actualizarCalificacion();