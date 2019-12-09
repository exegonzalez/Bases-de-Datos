-- 1. Usuario que realizo más compras ente dos fechas --
select * from UsuarioMayorCantidadCompras('2000-01-01','2020-01-01');

-- 2. Dado un combo, ver cuantos se vendieron en el periodo que estuvo disponible -- 
select * from combosVendidosPeriodo('Combo de Mate Calabaza y bombilla Pico Loro');

-- 3. Cantidad de productos de un determinado tipo --
select * from cantidadmismotipo(2);

-- 6. Producto más solicitado o vendido durante cierto periodo --
select * from productoMasVendidoPeriodo('2000-01-01','2020-01-01');