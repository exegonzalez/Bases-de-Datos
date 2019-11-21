/*
-- Consultas --
-- 1. Usuario que realizo más compras ente dos fechas --
select u.email, u.nombre, u.apellido, u.nombreuser, f.cantidad_compras from UsuarioMayorCantidadCompras('2000-01-01','2020-01-01') f, usuario u where u.email=f.usuario;

-- 2. Producto del cual se vendieron más unidades -- 
select p.codigo, p.nombre, p.tipo, p.proveedor, s.unidades_compradas from sumaProductos s, producto p where s.producto=p.codigo;

-- 4. Proveedor que provee más productos
select p.cuit, p.nombre, p.email, p.direccion, pmp.productos_provistos from proveedor p, proveedorMasProductos pmp where pmp.proveedor=p.cuit;

-- 5. Listado de productos que pertenecen a más de un combo
select p.codigo, p.nombre, p.tipo, p.proveedor from productosMuchosCombos pmc, producto p where pmc.producto=p.codigo;
*/
