CREATE TABLE `follows` (
  `following_user_id` integer,
  `followed_user_id` integer,
  `created_at` timestamp
);

CREATE TABLE `users` (
  `id` integer PRIMARY KEY,
  `username` varchar(255),
  `role` varchar(255),
  `created_at` timestamp
);

CREATE TABLE `posts` (
  `id` integer PRIMARY KEY,
  `title` varchar(255),
  `body` text COMMENT 'Content of the post',
  `user_id` integer,
  `status` varchar(255),
  `created_at` timestamp
);

CREATE TABLE `cliente` (
  `Id_Cliente` int(11) PRIMARY KEY NOT NULL,
  `CI_Cliente` varchar(100) NOT NULL,
  `Nombre_Cliente` varchar(100) NOT NULL,
  `Apellido_Cliente` varchar(100) NOT NULL,
  `Telefono_Cliente` varchar(100) NOT NULL,
  `Direccion_Cliente` varchar(100) NOT NULL,
  `Estado_Cliente` int(2) NOT NULL DEFAULT 1,
  `Dateadd_Cliente` datetime NOT NULL DEFAULT (current_timestamp()),
  `Id_Usuario` int(11) NOT NULL
);

CREATE TABLE `configuracion` (
  `Id_Conf` int(11) PRIMARY KEY NOT NULL,
  `CI_Conf` varchar(20) NOT NULL,
  `Nombre_Conf` varchar(100) NOT NULL,
  `RazonSocial_Conf` varchar(100) NOT NULL,
  `Telefono_Conf` varchar(20) NOT NULL,
  `Email_Conf` varchar(20) NOT NULL,
  `Direccion_Conf` text NOT NULL,
  `IVA_Conf` decimal(10,0) NOT NULL
);

CREATE TABLE `factura` (
  `Id_Factura` int(11) PRIMARY KEY NOT NULL,
  `Fecha_Factura` datetime NOT NULL DEFAULT (current_timestamp()),
  `Id_Usuario_Fac` int(11) NOT NULL,
  `Id_Cliente_Fac` int(11) NOT NULL,
  `Total_Fac` decimal(10,2) NOT NULL,
  `Estado_Fac` int(2) NOT NULL DEFAULT 1
);

CREATE TABLE `factura_detalle` (
  `Id_Factura_Det` int(11) PRIMARY KEY NOT NULL,
  `Id_Factura` int(11) NOT NULL,
  `Id_Producto_Fac_Det` int(11) NOT NULL,
  `Cantidad_Fac_Det` int(11) NOT NULL,
  `PrecioTotal_Fac_Det` decimal(10,2) NOT NULL
);

CREATE TABLE `factura_temp` (
  `Id_Factura_Temp` int(11) PRIMARY KEY NOT NULL,
  `Id_Factura_Temp_Usuario` int(11) NOT NULL,
  `Id_Factura_Temp_Prod` int(11) NOT NULL,
  `Cantidad_Factura_Temp` int(11) NOT NULL,
  `Precio_Venta_Temp` decimal(10,2) NOT NULL
);

CREATE TABLE `kardex` (
  `Id_Kardex` int(11) PRIMARY KEY NOT NULL,
  `Id_Usuario` int(11) NOT NULL,
  `Id_Material` int(11) NOT NULL,
  `Fecha_K` datetime NOT NULL DEFAULT (current_timestamp()),
  `Desc_K` varchar(100) NOT NULL,
  `Valor_Unit_K` float NOT NULL,
  `Cantidad_Ent_K` float NOT NULL,
  `Valor_Ent_K` float NOT NULL,
  `Cantidad_Sal_K` float NOT NULL,
  `Valor_Sal_K` float NOT NULL,
  `Cantidad_Saldo_k` float NOT NULL,
  `Valor_Saldo_K` float NOT NULL
);

CREATE TABLE `material` (
  `Id_Material` int(11) PRIMARY KEY NOT NULL,
  `Id_Unidad` int(11) NOT NULL,
  `Id_Usuario` int(11) NOT NULL,
  `Nombre_Material` varchar(50) NOT NULL,
  `CostoPorUnidad_Material` float NOT NULL,
  `Existencia_Material` float NOT NULL,
  `Estado_Material` int(2) NOT NULL DEFAULT 1,
  `Dateadd_Material` datetime NOT NULL DEFAULT (current_timestamp())
);

CREATE TABLE `producto` (
  `Id_Producto` int(11) PRIMARY KEY NOT NULL,
  `Id_Usuario_Prod` int(11) NOT NULL,
  `Id_Proveedor` INT(11),
  `Desc_Producto` varchar(50) NOT NULL,
  `Existencia_Prod` int(11) NOT NULL,
  `PrecioUnit_Prod` decimal(10,2) NOT NULL,
  `Foto_Prod` text NOT NULL,
  `dateadd_Prod` datetime NOT NULL DEFAULT (current_timestamp()),
  `Estado_Prod` int(2) NOT NULL DEFAULT 1
);

CREATE TABLE `producto_detalle` (
  `Id_Producto_Detalle` int(11) PRIMARY KEY NOT NULL,
  `Id_Producto_Prod` int(11) NOT NULL,
  `Id_Material_Prod_Detalle` int(11) NOT NULL,
  `Existencia_Prod_Detalle` decimal(10,2) NOT NULL,
  `PrecioUnit_Prod_Detalle` decimal(10,2) NOT NULL
);

CREATE TABLE `producto_temp` (
  `Id_Producto_temp` int(11) PRIMARY KEY NOT NULL,
  `Id_Material_Prod_temp` int(11) NOT NULL,
  `Id_Usuario_Prod_temp` int(11) NOT NULL,
  `Existencia_Prod_temp` int(11) NOT NULL,
  `PrecioUnit_Prod_temp` decimal(10,2) NOT NULL
);

CREATE TABLE `rolusuario` (
  `Id_Rol` int(2) PRIMARY KEY NOT NULL,
  `Rol` varchar(100) NOT NULL
);

CREATE TABLE `unidad` (
  `Id_Unidad` int(11) PRIMARY KEY NOT NULL,
  `Nombre_Unidad` varchar(11) NOT NULL,
  `Nombre_Unidades` varchar(11) NOT NULL
);

CREATE TABLE `usuario` (
  `Id_Usuario` int(11) PRIMARY KEY NOT NULL,
  `Id_Rol_Us` int(11) NOT NULL,
  `Nombre_Usuario` varchar(100) NOT NULL,
  `Apellido_Usuario` varchar(100) NOT NULL,
  `Correo_Usuario` varchar(100) NOT NULL,
  `Usuario` varchar(100) NOT NULL,
  `Clave_Usuario` varchar(100) NOT NULL,
  `Estado_Usuario` int(2) NOT NULL DEFAULT 1,
  `Foto_Usuario` varchar(100) NOT NULL
);

-- Crear la tabla proveedores
CREATE TABLE proveedores (
    Id_Proveedor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Proveedor VARCHAR(100) NOT NULL,
    Telefono_Proveedor VARCHAR(15),
    Email_Proveedor VARCHAR(100),
    Direccion_Proveedor TEXT,
    Estado_Proveedor INT DEFAULT 1 -- 1: Activo, 0: Inactivo
);

-- Modificar la tabla producto para agregar la relación con proveedores
ALTER TABLE `producto`
ADD CONSTRAINT `Producto_Proveedor`
FOREIGN KEY (`Id_Proveedor`) REFERENCES `proveedores` (`Id_Proveedor`);

ALTER TABLE `posts` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `follows` ADD FOREIGN KEY (`following_user_id`) REFERENCES `users` (`id`);

ALTER TABLE `follows` ADD FOREIGN KEY (`followed_user_id`) REFERENCES `users` (`id`);

ALTER TABLE `cliente` ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`Id_Usuario`) REFERENCES `usuario` (`Id_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `factura` ADD CONSTRAINT `Factura-Cliente` FOREIGN KEY (`Id_Cliente_Fac`) REFERENCES `cliente` (`Id_Cliente`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `factura` ADD CONSTRAINT `Factura-Usuario` FOREIGN KEY (`Id_Usuario_Fac`) REFERENCES `usuario` (`Id_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `factura_detalle` ADD CONSTRAINT `FacturaDet-Factura` FOREIGN KEY (`Id_Factura`) REFERENCES `factura` (`Id_Factura`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `factura_detalle` ADD CONSTRAINT `FacturaDet-Producto` FOREIGN KEY (`Id_Producto_Fac_Det`) REFERENCES `producto` (`Id_Producto`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `factura_temp` ADD CONSTRAINT `FacturaTemp-Producto` FOREIGN KEY (`Id_Factura_Temp_Prod`) REFERENCES `producto` (`Id_Producto`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `factura_temp` ADD CONSTRAINT `FacturaTemp-Usuario` FOREIGN KEY (`Id_Factura_Temp_Usuario`) REFERENCES `usuario` (`Id_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `kardex` ADD CONSTRAINT `Kardex-Material` FOREIGN KEY (`Id_Material`) REFERENCES `material` (`Id_Material`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `kardex` ADD CONSTRAINT `Kardex-Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `usuario` (`Id_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `material` ADD CONSTRAINT `Material-Unidad` FOREIGN KEY (`Id_Unidad`) REFERENCES `unidad` (`Id_Unidad`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `material` ADD CONSTRAINT `Material-Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `usuario` (`Id_Usuario`);

ALTER TABLE `producto` ADD CONSTRAINT `Producto-Usuario` FOREIGN KEY (`Id_Usuario_Prod`) REFERENCES `usuario` (`Id_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `producto_detalle` ADD CONSTRAINT `Producto-Material-Detalle` FOREIGN KEY (`Id_Material_Prod_Detalle`) REFERENCES `material` (`Id_Material`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `producto_detalle` ADD CONSTRAINT `Producto-Producto` FOREIGN KEY (`Id_Producto_Prod`) REFERENCES `producto` (`Id_Producto`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `producto_temp` ADD CONSTRAINT `Producto-Material-Temp` FOREIGN KEY (`Id_Material_Prod_temp`) REFERENCES `material` (`Id_Material`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `producto_temp` ADD CONSTRAINT `Producto-Usuario-Temp` FOREIGN KEY (`Id_Usuario_Prod_temp`) REFERENCES `usuario` (`Id_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `usuario` ADD CONSTRAINT `Rol-Usuario` FOREIGN KEY (`Id_Rol_Us`) REFERENCES `rolusuario` (`Id_Rol`) ON DELETE CASCADE ON UPDATE CASCADE;
