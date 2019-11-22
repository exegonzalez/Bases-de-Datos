-- TRIGGER
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