/*
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
*/
