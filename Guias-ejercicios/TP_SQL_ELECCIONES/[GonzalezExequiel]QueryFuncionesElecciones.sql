-- Ejercicio realizado en clases.
CREATE OR REPLACE FUNCTION porcentajemesas() 
RETURNS SETOF float4 AS
$BODY$
DECLARE
BEGIN
	return query (select cast((select count(v.nromesa) from votosxmesa v) * 100 / (select count(m.nromesa) from mesa m) as float4));
end;
$BODY$
LANGUAGE 'plpgsql';

select * from porcentajemesas();

--a) % de votos obtenidos por una lista xx en el circuito “Suburbio norte”
create view circuitosuburbionorte as
select m.nromesa from mesa m,escuela e, circuito c where m.idesc = e.idesc and e.idcircuito = c.idcircuito 
and c.nombrecirc = 'SUBURBIO NORTE';

create view totalvotospartidomesa as
select distinct v.nromesa,sum (votospartido) as votospartido from votosmesapartido v group by v.nromesa;

CREATE OR REPLACE FUNCTION porcentajeListaSuburbioNorte(partido varchar) RETURNS TABLE (nombrep varchar, porcentaje numeric) AS
$BODY$
BEGIN
	return query select p.nombrep, sum(v.votospartido) * 100 / (select sum(votospartido) 
	from totalvotospartidomesa) as porcentaje from circuitosuburbionorte csn, votosmesapartido v, partido p
	where v.nropartido = p.nrop and v.nromesa = csn.nromesa and p.nombrep = partido group by p.nombrep;
end
$BODY$
LANGUAGE 'plpgsql';

select * from porcentajeListaSuburbioNorte('VIVA ER');

--b) Modifique la función anterior para que se le pueda pasar por parámetro un circuito.
CREATE OR REPLACE FUNCTION mesasCircuito(circuito varchar) RETURNS TABLE (nromesa varchar) AS
$BODY$
BEGIN
	return query 
	select m.nromesa from mesa m,escuela e, circuito c where m.idesc = e.idesc and e.idcircuito = c.idcircuito 
	and c.nombrecirc = circuito;
end
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION porcentajeListaCircuitoSuburbioNorte(partido varchar, circuito varchar) RETURNS TABLE (nombrep varchar, porcentaje numeric) AS
$BODY$
BEGIN
return query 
	select p.nombrep, sum(v.votospartido) * 100 / (select sum(votospartido) 
	from totalvotospartidomesa) as porcentaje from (select * from mesasCircuito (circuito)) mc, votosmesapartido v, partido p
	where v.nropartido = p.nrop and v.nromesa = mc.nromesa and p.nombrep = partido
	group by p.nombrep;
end
$BODY$
LANGUAGE 'plpgsql';

select * from porcentajeListaCircuitoSuburbioNorte('VIVA ER','SUBURBIO NORTE');

--c) Lista ganadora por circuito
create view votosPartidoDistrito as 
select c.nombrecirc, nropartido, sum (vmp.votospartido) as votos
from mesa m, votosmesapartido vmp,circuito c, escuela e
where m.nromesa = vmp.nromesa and m.idesc = e.idesc and e.idcircuito = c.idcircuito group by c.nombrecirc, nropartido;

create view ganadorVotosxDistrito as 
select nombrecirc,max (votos) as votos from votosPartidoDistrito group by nombrecirc;

CREATE OR REPLACE FUNCTION listaGanadoraCircuito() RETURNS TABLE (nombrecirc varchar, nombrep varchar) AS
$BODY$
BEGIN
	return query select vpd.nombrecirc, p.nombrep 
	from votosPartidoDistrito vpd, partido p,ganadorVotosxDistrito gvd
	where vpd.nropartido = p.nrop and vpd.votos = gvd.votos and vpd.nombrecirc = gvd.nombrecirc;
end
$BODY$
LANGUAGE 'plpgsql';

select * from listaGanadoraCircuito();

--d) Primeras cuatro fuerzas por escuela
create view votosxescxpartido as
select p.nombrep nombre, e.nombreescuela, sum(vmp.votospartido) votos, p.nrop
from escuela e, votosmesapartido vmp, mesa m, partido p 
where e.idesc = m.idesc and vmp.nromesa = m.nromesa and p.nrop = vmp.nropartido
group by e.nombreescuela, p.nombrep, p.nrop;

CREATE OR REPLACE FUNCTION primerasCuatroFuerzasEScuela() RETURNS TABLE (nombre varchar, votos bigint, nombreescuela varchar) AS
$BODY$
BEGIN
	return query select vt.nombre, vt.votos, vt.nombreescuela
	from votosxescxpartido vt where ( select count(*) from votosxescxpartido as v
	where v.nombreescuela = vt.nombreescuela and v.votos >= vt.votos) <= 4 
	order by vt.nombreescuela,vt.votos DESC;
end
$BODY$
LANGUAGE 'plpgsql';

select * from primerasCuatroFuerzasEScuela();

--e) Partidos que hayan alcanzado al menos el x% de los votos
create view porcentajelistas as
select p.nombrep,sum (v.votospartido)*100.0/(select sum (votostotales) from totalvotosmesa) as porcentaje
from votosmesapartido v, partido p
where v.nropartido = p.nrop group by p.nombrep;

CREATE OR REPLACE FUNCTION porcentajepartido(prc float) 
RETURNS SETOF porcentajelistas AS
$BODY$
DECLARE
tabla porcentajelistas% rowtype;
BEGIN
	for tabla in select nombrep from porcentajelistas as pl
	where (pl.porcentaje >= prc)
	loop
		return next tabla;
	end loop;
	return;
end
$BODY$
LANGUAGE 'plpgsql';

select porcentajepartido(5.0);