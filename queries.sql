/*
-- Consultas --
-- 1. Usuario que realizo más compras ente dos fechas --
select u.email, u.nombre, u.apellido, u.nombreuser, f.cantidad_compras from UsuarioMayorCantidadCompras('2000-01-01','2020-01-01') f, usuario u where u.email=f.usuario;

-- 2. Producto del cual se vendieron más unidades -- 
CREATE VIEW lineaProductos AS SELECT * FROM linea WHERE producto is not null;

CREATE VIEW sumaProductos AS SELECT lp1.producto, SUM(lp1.cantidadproducto) AS unidades_compradas
FROM lineaProductos lp1 GROUP BY lp1.producto ORDER BY unidades_compradas DESC LIMIT 1;

select p.codigo, p.nombre, p.tipo, p.proveedor, s.unidades_compradas from sumaProductos s, producto p where s.producto=p.codigo
*/