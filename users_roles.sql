-- Creacion de Usuarios --
CREATE USER AdministradorStock PASSWORD '12345';
CREATE USER AdministradorVentas PASSWORD '12345';

-- Otorgamos los Roles a los Usuarios -- 
GRANT ALL ON combo TO AdministradorVentas;
GRANT select ON producto, compra, usuario TO AdministradorVentas;
GRANT ALL on producto, proveedor TO AdministradorStock;

-- Otorgamos permisos a los atributos del tipo SERIAL de las tablas -- 
GRANT USAGE, SELECT ON SEQUENCE combo_codigo_seq, producto_codigo_seq, compra_codigo_seq TO AdministradorVentas;
GRANT USAGE, SELECT ON SEQUENCE producto_codigo_seq TO AdministradorStock;
