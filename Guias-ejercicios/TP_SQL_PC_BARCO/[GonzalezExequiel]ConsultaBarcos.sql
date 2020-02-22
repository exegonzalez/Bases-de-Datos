--Prueba de vista
--create view vistaprueba as select f.cod from producto f, pc p where (f.cod=p.cod) and (p.veloc>=150)
--select * from vistaprueba

--EJERCICIO 1
--a) ¿Qué modelos de PC tienen una velocidad de al menos 150?
--select f.cod from producto f, pc p where (f.cod=p.cod) and (p.veloc>=150)

--b) ¿Qué fabricantes hacen laptops con un disco duro de al menos un gigabyte?
--select distinct(f.fabricante) from producto f, laptop l where (f.cod=l.cod) and (l.hd>=1)

--c) Hallar el número de modelo y el precio de todos los productos (de cualquier tipo) hechos por el fabricante B. 
/*((select f.cod,p.precio from producto f inner join pc p on (f.cod=p.cod) where (fabricante='B'))UNION
(select f.cod,l.precio from producto f inner join laptop l on (f.cod=l.cod) where (fabricante='B')) UNION
(select f.cod,i.precio from producto f inner join impresora i on (f.cod=i.cod) where (fabricante='B')))*/

--d) Hallar el número de modelo de todas las impresoras color. 
--select cod from impresora where color=true;

--e) Hallar los fabricantes que venden laptops pero no PCs
--(select distinct(f.fabricante) from producto f where f.tipo='Laptop') except (select distinct(f.fabricante) from producto f where f.tipo='Pc');
--select distinct(fabricante) from producto where tipo='Laptop' and fabricante not in (select fabricante from producto where tipo='Pc')

--f) Hallar aquellos tamaños de discos que ocurren en dos o más PCs. 
--select distinct(p.hd) from pc p, pc d where p.cod<>d.cod and p.hd=d.hd;

--g) Hallar pares de modelos de PC tales que ambos posean la misma velocidad y RAM. Un par debe ser listado una sola vez: (i,j) pero no (j,i) 
--select p.cod,c.cod from pc p, pc c where p.cod!=c.cod and p.veloc=c.veloc and p.ram=c.ram and p.cod<c.cod;

--h) Hallar aquellos fabricantes que ofrezcan computadoras (sean PC o laptop) con velocidades de al menos 133.
--select distinct(f.fabricante) from pc p, laptop l, producto f where (f.cod=p.cod and p.veloc>=133) or (f.cod=l.cod and l.veloc>=133);

--i) Hallar los fabricantes de la computadora (PC o laptop) con la máxima velocidad disponible.
--select distinct(p.fabricante) from producto p, pc d, laptop l where 
--(p.cod=d.cod and (select max(d.veloc) as "mayor" from pc d)) or (p.cod=l.cod and (select max(l.veloc) as "mayor" from laptop l))

--EJERCICIO 2
--a) Los nombres y los países de las clases que llevaban cañones de al menos 16 pulgadas de calibre. 
--select clase,pais from clase where calibre>=16;

--b) Hallar los barcos botados antes de 1921
--select nombre from barco where botado<1921;

--c) Hallar los barcos hundidos en la batalla del Atlántico Norte
--select barco from participa where batalla='Atlantico Norte' and resultado='Hundido'

--d) El tratado de Washington de 1921 prohibió los barcos de más de 35000 toneladas. Listar los barcos que violaron el tratado de Washington. 
--select b.nombre from barco b, clase c where c.clase=b.clase and c.desplazamiento>=35000 and b.botado>=1921;

--e) Listar el nombre, el desplazamiento y el número de cañones de los barcos que participaron de la batalla d--e Guadalcanal f
--select b.nombre, c.desplazamiento, c.caniones from barco b, participa p, clase c where b.nombre=p.barco and p.batalla='Guadalcanal' and b.clase=c.clase;

--f) Hallar los países que tuvieron tanto cruceros como acorazados 
--select distinct(c.pais) from clase c, clase b where c.pais=b.pais and c.tipo<>b.tipo;

--g) Hallar los barcos que, siendo dañados en alguna batalla, participaron posteriormente de alguna otra. 
--select p.barco from participa p, participa a, batalla c, batalla d where p.barco=a.barco and p.batalla=c.nombre and a.batalla=d.nombre and c.fecha>d.fecha and p.resultado='Dañado';