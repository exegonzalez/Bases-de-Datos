-- Funciones --
-- 1. Usuario que realizo más compras ente dos fechas --
CREATE OR REPLACE FUNCTION UsuarioMayorCantidadCompras(date, date) RETURNS TABLE (usuario varchar(255), cantidad_compras bigint) AS
$BODY$
DECLARE
BEGIN
	return query (SELECT c.usuario, count(c.usuario) AS mayor_comprador FROM compra c WHERE c.fecha BETWEEN $1 and $2
			 GROUP BY c.usuario ORDER BY mayor_comprador DESC LIMIT 1);
end
$BODY$
LANGUAGE 'plpgsql';

-- 2. Dado un combo, ver cuantos se vendieron en el periodo que estuvo disponible -- 
CREATE OR REPLACE FUNCTION combosVendidosPeriodo(varchar(70)) RETURNS TABLE (codigo integer, cantidad_vendidos bigint) AS
$BODY$
DECLARE
BEGIN
	return query (SELECT c.codigo, count(lc.cantidadproducto) AS mayor_ventas 
	FROM combo c, lineaCombos lc, carrito ca, compra co 
	WHERE c.nombre=$1 and lc.combo=c.codigo and lc.carrito=ca.codigo and co.carrito=ca.codigo and co.fecha BETWEEN c.fechainicio and c.fechafinal
	GROUP BY c.codigo ORDER BY mayor_ventas DESC LIMIT 1);
end
$BODY$
LANGUAGE 'plpgsql';

-- 3. Cantidad de productos de un determinado tipo --
CREATE OR REPLACE FUNCTION cantidadMismoTipo(tipoo int) RETURNS TABLE (tipo int, cantidad bigint) AS
$BODY$ 
DECLARE
BEGIN
	return query(SELECT p.tipo, count(p.tipo) FROM producto p
	group by p.tipo having p.tipo = $1);
end
$BODY$
LANGUAGE 'plpgsql';

-- 6. Producto más solicitado o vendido durante cierto periodo --
CREATE OR REPLACE FUNCTION productoMasVendidoPeriodo(date, date) RETURNS TABLE (producto integer, cantidad_vendidos bigint) AS
$BODY$
DECLARE
BEGIN
	return query (SELECT lp1.producto, SUM(lp1.cantidadproducto) AS unidades_vendidas
	FROM lineaProductos lp1, carrito ca, compra co 
	WHERE lp1.carrito=ca.codigo and ca.codigo=co.carrito and co.fecha between $1 and $2
	GROUP BY lp1.producto ORDER BY unidades_vendidas DESC LIMIT 1);
end
$BODY$
LANGUAGE 'plpgsql';

