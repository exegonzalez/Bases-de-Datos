--a) Porcentaje de mesas escrutadas.
select (select count(v.nromesa) from votosxmesa v) * 100 / (select count(m.nromesa) from mesa m);

CREATE OR REPLACE FUNCTION porcentajemesas() 
RETURNS SETOF float4 AS
$BODY$
DECLARE
BEGIN
	return query (select cast((select count(v.nromesa) from votosxmesa v) * 100 / (select count(m.nromesa) from mesa m) as float4)); as float4
end
$BODY$
LANGUAGE 'plpgsql';

select * from porcentajemesas();

/*
--2a) Cantidad total de votos emitidos agrupados por escuela.
create view totalvotospartidomesa as
select distinct v.nromesa,sum (votospartido) as votospartido from votosmesapartido v group by v.nromesa;

create view totalvotosmesa as 
select distinct m.nromesa,m.idesc,mv.blancos + mv.nulos + mv.recurridos + mv.impugnados + mvp.votospartido as votostotales
from mesa m, votosxmesa mv, totalvotospartidomesa mvp where m.nromesa = mv.nromesa and mv.nromesa = mvp.nromesa;

select e.nombreescuela,sum (t.votostotales) from totalvotosmesa t,escuela e
where t.idesc = e.idesc group by e.nombreescuela;

--b) Cantidad total de votos emitidos agrupados por Circuito.
select c.nombrecirc,sum (t.votostotales) from totalvotosmesa t,escuela e,circuito c 
where t.idesc = e.idesc and c.idcircuito = e.idcircuito group by c.nombrecirc;

--c) Cantidad total de votantes masculinos y femeninos.
create view votantesfemeninos as
select sum(votostotales) f from totalvotosmesa where (nromesa like 'F%'); 

create view votantesmasculinos as
select sum(votostotales) m from totalvotosmesa where (nromesa like 'M%');

select f, m from votantesfemeninos, votantesmasculinos;

--d) % de votos obtenidos por una lista xx en el circuito “Suburbio norte”
create view circuitosuburbionorte as
select m.nromesa from mesa m,escuela e, circuito c where m.idesc = e.idesc and e.idcircuito = c.idcircuito 
and c.nombrecirc = 'SUBURBIO NORTE';

select p.nombrep, sum(v.votospartido) * 100 / (select sum(votospartido) from totalvotospartidomesa) from circuitosuburbionorte cn, votosmesapartido v, partido p
where v.nropartido = p.nrop and v.nromesa = cn.nromesa 
group by p.nombrep;

--e) Cantidad de votos obtenidos por una lista xx en la escuela “92 Tucumán”
create view mesasescuelatucuman as
select m.nromesa from mesa m,escuela e where m.idesc = e.idesc and e.nombreescuela = '92 TUCUMAN';

select p.nombrep,sum (v.votospartido) from mesasescuelatucuman tc, votosmesapartido v, partido p
where v.nropartido = p.nrop and v.nromesa = tc.nromesa
group by p.nombrep;

--f) Cantidad total de votos válidos (sin contar blancos, nulos, recurridos e impugnados).
select sum (votospartido) from totalvotospartidomesa;

--g) % de votos no válidos.
create view votosnovalidos as 
select sum (votostotales) - (select sum (votospartido) from totalvotospartidomesa) as cant from totalvotosmesa;

select cant * 100 /(select sum (votostotales) from totalvotosmesa) from votosnovalidos;

--h) % total de votos obtenidos por cada lista, respecto de la totalidad de los votos.
create view porcentajevotoslistas as
select p.nombrep,sum (v.votospartido) * 100.0 /(select sum (votostotales) from totalvotosmesa) as porcentaje
from votosmesapartido v, partido p
where v.nropartido = p.nrop group by p.nombrep;

select * from porcentajevotoslistas;

--i) % total de votos obtenidos por cada lista, sólo de los votos válidos, esto sin tener en cuenta votos en blanco, nulos, recurridos e impugnados.
Select p.nombrep,sum (v.votospartido) * 100/(select sum (votospartido) from totalvotospartidomesa) as porcentaje
from votosmesapartido v, partido p
where v.nropartido = p.nrop group by p.nombrep

--j) Cantidad total de votos obtenidos por cada lista
create view votosxpartido as
select m.nromesa from mesa m,escuela e where m.idesc = e.idesc;

select p.nombrep, sum (v.votospartido) as cantidad from votosxpartido vp, votosmesapartido v, partido p
where v.nropartido = p.nrop and v.nromesa = vp.nromesa
group by p.nombrep
order by cantidad DESC;

--k) Lista ganadora por circuito
create view votospartidodistrito as 
select c.nombrecirc, nropartido, sum (vmp.votospartido) as votos
from mesa m, votosmesapartido vmp,circuito c, escuela e
where m.nromesa = vmp.nromesa and m.idesc = e.idesc and e.idcircuito = c.idcircuito group by c.nombrecirc, nropartido;

create view ganadorvotosxdistrito as 
select nombrecirc,max (votos) as votos from votospartidodistrito group by nombrecirc;

select vpd.nombrecirc, p.nombrep from votospartidodistrito vpd, partido p,ganadorvotosxdistrito mv
where vpd.nropartido = p.nrop and vpd.votos = mv.votos and vpd.nombrecirc = mv.nombrecirc;

--l) Primeras cuatro fuerzas por escuela
create view votosxescxpartido as
select p.nombrep nombre, e.nombreescuela, sum(vmp.votospartido) votos, p.nrop
from escuela e, votosmesapartido vmp, mesa m, partido p 
where e.idesc = m.idesc and vmp.nromesa = m.nromesa and p.nrop = vmp.nropartido
group by e.nombreescuela, p.nombrep, p.nrop;

select nombre, votos, nombreescuela
from votosxescxpartido
where ( select count(*) from votosxescxpartido as v
where v.nombreescuela = votosxescxpartido.nombreescuela and v.votos >= votosxescxpartido.votos
) <= 4 order by nombreescuela,votos DESC;

--m) Diferencia en votos y en porcentaje entre las dos primeras fuerzas
create view dos_primeros as
select p.nombrep, sum (v.votospartido) votos, sum (v.votospartido) * 100/(select sum (votospartido) from totalvotospartidomesa) as porcentaje 
from votosmesapartido v, partido p
where v.nropartido = p.nrop 
group by p.nombrep order by votos DESC LIMIT 2;

select (d1.votos - d2.votos) dif_votos,(d1.porcentaje - d2.porcentaje) dif_por from dos_primeros d1, dos_primeros d2 
where d1.nombrep != d2.nombrep and d1.votos > d2.votos

--n) Partidos que hayan ganado una escuela
select distinct nombre
from votosxescxpartido
where ( select count(*) from votosxescxpartido as v
where v.nombreescuela = votosxescxpartido.nombreescuela and v.votos >= votosxescxpartido.votos
) <= 1;

--o) Partidos que hayan ganado un circuito
select distinct p.nombrep from votospartidodistrito vpd, partido p,ganadorvotosxdistrito mv
where vpd.nropartido = p.nrop and vpd.votos = mv.votos and vpd.nombrecirc = mv.nombrecirc;

--p) Partidos que hayan alcanzado al menos el x% de los votos
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

select * from porcentajelistas;
select porcentajepartido(26.0);
select porcentajepartido(5.0);*/