-- Vistas --
-- 2. Producto del cual se vendieron más unidades -- 
CREATE VIEW lineaProductos AS SELECT * FROM linea WHERE producto is not null;

CREATE VIEW sumaProductos AS SELECT lp1.producto, SUM(lp1.cantidadproducto) AS unidades_compradas
FROM lineaProductos lp1, carrito ca, compra co 
WHERE lp1.carrito=ca.codigo and ca.codigo=co.carrito
GROUP BY lp1.producto ORDER BY unidades_compradas DESC LIMIT 1;

-- 4. Proveedor que provee más productos --
CREATE VIEW proveedorMasProductos AS SELECT p.proveedor, COUNT(p.proveedor) AS productos_provistos
FROM producto p GROUP BY p.proveedor ORDER BY productos_provistos DESC LIMIT 1;

-- 5. Listado de productos que pertenecen a más de un combo --
CREATE VIEW productosMuchosCombos AS SELECT distinct pxc1.producto FROM productoxcombo pxc1, productoxcombo pxc2
WHERE pxc1.producto=pxc2.producto and pxc1.combo!=pxc2.combo;

-- 7. Listado de productos que estan por debajo del stock minimo disponible --
CREATE VIEW debajoStockMin AS SELECT p.codigo, p.nombre, p.tipo, p.proveedor FROM producto p where p.stock < p.stockmin;
