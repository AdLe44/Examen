CREATE TABLE `direcciones` (
  `Id` int(11) NOT NULL,
  `Nombre_Calle` varchar(255) NOT NULL,
  `Numero_Exterior` int(11) NOT NULL,
  `Numero_Interior` int(11) DEFAULT NULL,
  `Colonia_Barrio` varchar(255) NOT NULL,
  `Codigo_Postal` int(11) NOT NULL,
  `Ciudad_Localidad` varchar(255) NOT NULL,
  `Estado_Provincia` varchar(255) NOT NULL,
  `Pais` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `generos` (
  `Id` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` varchar(1079) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `individuos` (
  `Id` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Edad` int(11) NOT NULL,
  `Direccion` int(11) NOT NULL,
  `Genero` int(11) NOT NULL,
  `Salario` float(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `direcciones`
  ADD PRIMARY KEY (`Id`);

ALTER TABLE `generos`
  ADD PRIMARY KEY (`Id`);

ALTER TABLE `individuos`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Direccion` (`Direccion`),
  ADD KEY `Genero` (`Genero`);

ALTER TABLE `direcciones`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `generos`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

ALTER TABLE `individuos`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `individuos`
  ADD CONSTRAINT `individuos_ibfk_2` FOREIGN KEY (`Direccion`) REFERENCES `direcciones` (`Id`),
  ADD CONSTRAINT `individuos_ibfk_3` FOREIGN KEY (`Genero`) REFERENCES `generos` (`Id`);
COMMIT;