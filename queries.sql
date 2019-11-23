-- Consultas --
-- 1. Usuario que realizo más compras ente dos fechas --
select u.email, u.nombre, u.apellido, u.nombreuser, f.cantidad_compras from UsuarioMayorCantidadCompras('2000-01-01','2020-01-01') f, usuario u where u.email=f.usuario;

-- 2. Dado un combo, ver cuantos se vendieron en el periodo que estuvo disponible -- 
select c.codigo, c.nombre, c.precio, c.descripcion, cvp.cantidad_vendidos from combosVendidosPeriodo('Combo de Mate Calabaza y bombilla Pico Loro') cvp, combo c where cvp.codigo=c.codigo;

-- 3. Cantidad de productos de un determinado tipo --
select * from cantidadmismotipo(4)

<<<<<<< Updated upstream
-- 4. Proveedor que provee más productos --
select p.cuit, p.nombre, p.email, p.direccion, pmp.productos_provistos from proveedor p, proveedorMasProductos pmp where pmp.proveedor=p.cuit;

-- 5. Listado de productos que pertenecen a más de un combo --
select p.codigo, p.nombre, p.tipo, p.proveedor from productosMuchosCombos pmc, producto p where pmc.producto=p.codigo;

-- 6. Producto más solicitado o vendido durante cierto periodo --
select p.codigo, p.nombre, p.tipo, p.proveedor, pmvp.cantidad_vendidos from productoMasVendidoPeriodo('2000-01-01','2020-01-01') pmvp, producto p
where pmvp.producto=p.codigo

-- 7. Listado de productos que estan por debajo del stock minimo disponible --
select * from debajoStockMin;
=======
select p.codigo, p.nombre, p.tipo, p.proveedor, s.unidades_compradas from sumaProductos s, producto p where s.producto=p.codigo
*/

-- 3 Cantidad productos del mismo tipo
--select * from cantidadmismotipo(4)

-- Listado de productos que estan por debajo del stock minimo disponible
/*
create view debajoStockMin AS select p.nombre from producto p where p.stock < p.stockmin;

select * from debajoStockMin;
*/

-- controlar que cuando se cargue una linea solo se tenga un producto o combo
create trigger trigger_func_li before insert or update on linea 
for each row execute procedure func_li();

insert into linea(cantidadproducto, totalproducto, producto, combo, carrito) values(12, 334, 2, null, 3);

>>>>>>> Stashed changes
