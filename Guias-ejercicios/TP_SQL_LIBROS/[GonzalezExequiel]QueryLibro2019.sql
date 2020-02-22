--a) Aquellos ejemplares que jamás hayan sido retirados.
create view ejemplaresPrestados as
select distinct e.idInventario as ejemplarPrestado from ejemplar e, prestamo p where p.idInventario=e.idInventario;

SELECT distinct isbn from ejemplar WHERE idInventario NOT IN (select ejemplarPrestado from ejemplaresPrestados)

--b) Los libros pertenecientes a la categoría Marketing para los que haya habido pedidos insatisfechos.
create view librosMarketing as
select  cl.isbn as libroMarketing from categoria c, categoriaLibro cl where cl.idcategoria=c.idcategoria and c.categoria='Marketing';

select distinct l.isbn, l.titulo, l.fPublicacion, l.paginas, l.editorial from librosMarketing lm, libro l, pedidoinsatisfecho pi
where lm.libroMarketing=pi.isbn and lm.libroMarketing=l.isbn

--c) Los alumnos de Concepción del Uruguay que hayan retirado al menos dos libros durante los años 1988 al 1991.
create view alumnosCDU as
select distinct u.dni as alumnocdu from alumno a, usuario u, localidad l where 
u.dni=a.dni and u.idLocalidad=l.idLocalidad and l.localidad='CONCEPCION DEL URUGUAY';

create view prestadosMasDosVeces as
select distinct p1.dni as prestadoDos from prestamo p1, prestamo p2 where 
p1.dni=p2.dni and p1.fechaprestamo >= '1989-01-01' 
and p1.fechaprestamo<='1991-12-31' and p1.idInventario!=p2.idInventario;

select a.alumnoCDU from alumnosCDU a, prestadosMasDosVeces pmdv where a.alumnoCDU=pmdv.prestadoDos 

--d) Listar los departamentos de los cuales dependen todos aquellos investigadores que hayan
--retirado libros editados por 'Sudamericana'.
create view ejemplaresLibrosSudamericana as
select distinct e.idInventario as ejemplaresSud from ejemplar e, libro l where 
l.editorial='Sudamericana' and e.isbn=l.isbn;

create view prestamosInvestigadores as
select distinct p.dni as investigadores from prestamo p, ejemplaresLibrosSudamericana els, investigador i where 
p.dni=i.dni and els.ejemplaresSud=p.idInventario;

create view participaProyecto as
select distinct py.idDepartamento as proyectos from prestamosInvestigadores pi, participa p, proyecto py where 
pi.investigadores=p.dni and p.idProyecto=py.idProyecto;

select d.departamento from participaProyecto pp, departamento d where pp.proyectos=d.idDepartamento

--e) El título de aquellos libros que hayan sido retirados tanto por docentes que dictan una
--determinada materia como por alumnos que cursan la misma.
create view prestamosProfesores as
select distinct p.idInventario as idprestamo, d.idMateria as materias from dicta d, prestamo p where p.dni=d.dni;

create view prestamosAlumnos as
select distinct p.idInventario as idprestamo, c.idMateria as materias from cursa c, prestamo p where p.dni=c.dni;

create view librosPrestados as
select distinct e.isbn as isbn from ejemplar e, prestamosProfesores pp, prestamosAlumnos pa where 
pp.idprestamo=pa.idprestamo and pp.materias=pa.materias and e.idInventario=pp.idprestamo;

select distinct l.titulo from librosPrestados lp, libro l where lp.isbn=l.isbn;

--f) El nombre de los usuarios a los que se les ha vencido el plazo para devolver algún libro, y
--que con posterioridad a la fecha de vencimiento hayan retirado algún otro.
create view ejemplaresVencidos as
select distinct p1.dni as dni from prestamo p1, prestamo p2 where 
p1.dni=p2.dni and (p1.fechaLimite<p1.fechaDevolucion or p1.fechaDevolucion=null) and 
p2.fechaPrestamo>p1.fechaLimite;

select u.nombre from usuario u, ejemplaresVencidos ev where u.dni=ev.dni;

--g) Los docentes que dictan alguna materia en todas las carreras a las que dicha materia pertenece.
create view carreraxmateria as
select distinct idmateria,idcarrera from dicta order by idmateria;

create view diferenciacarreraxmateria as
select distinct d.dni,d.idmateria,d.idcarrera from dicta d, carreraxmateria cxm
except
select dni,idmateria,idcarrera from dicta;

create view diferenciadicta as
select distinct dni,idmateria from dicta 
except 
select distinct dni,idmateria from diferenciacarreraxmateria;

select u.nombre from diferenciadicta dd, usuario u where dd.dni = u.dni

--h) Aquellos libros para los que existe más de un ejemplar, tal que al menos dos de esos ejemplares se hayan 
-- encontrado prestados en forma simultánea en un determinado momento. Para simplificar, considerar solamente 
-- aquellos préstamos en los que el libro ya haya sido devuelto.

create view librosvariosejemplares as
select distinct e1.idInventario as id1, e2.idInventario as id2 from ejemplar e1, ejemplar e2 
where e1.idInventario<>e2.idInventario and e1.isbn=e2.isbn;

create view librosDevueltos as
select fechaprestamo,idinventario,fechadevolucion from prestamo where fechadevolucion is not null;

create view ejemplaresSimultaneamente as
select ld1.idinventario as id1,ld2.idinventario as id2 from librosDevueltos ld1, librosDevueltos ld2 
where ld1.idinventario<>ld2.idinventario and ld1.fechaprestamo<ld2.fechadevolucion and ld2.fechaprestamo<ld1.fechaprestamo; 

create view variosEjemplaresSimultaneamente as
select lve.id1, lve.id2 from librosvariosejemplares lve, ejemplaresSimultaneamente es where lve.id1=es.id1 and lve.id2=es.id2;

select l.isbn, l.titulo from libro l, variosEjemplaresSimultaneamente ves, ejemplar e where
ves.id1=e.idInventario and e.isbn=l.isbn;


