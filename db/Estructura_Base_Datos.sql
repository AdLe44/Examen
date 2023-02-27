-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-02-2023 a las 15:29:04
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `examen`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ACCIONES_GENERO` (IN `Id_Acc` INT, IN `Nombre_Acc` VARCHAR(255), IN `Descripcion_Acc` VARCHAR(1079), IN `Opcion` VARCHAR(255))   BEGIN
	DECLARE Bandera INT;
	DECLARE Id_Retorno INT;
    DECLARE Todos_Registros JSON;
    IF LENGTH(IFNULL(Opcion, '')) = 0 THEN
        SELECT JSON_OBJECT(
            'Status', 'Error',
            'Data', null,
            'Message', 'No se recibio una opción a realizar.'
        ) AS Retorno;
    ELSE
        CASE Opcion
            WHEN 'CREATE' THEN
                IF LENGTH(IFNULL(Nombre_Acc, '')) = 0 THEN
                    SELECT JSON_OBJECT(
                        'Status', 'Error',
                        'Data', null,
                        'Message', 'No se envio un nombre.'
                    ) AS Retorno;
                ELSE
                    SELECT COUNT(g.Id) INTO Bandera FROM generos g WHERE g.Nombre = Nombre_Acc;
                    IF(Bandera > 1) THEN
                        SELECT JSON_OBJECT(
                            'Status', 'Error',
                            'Data', null,
                            'Message', 'El nombre insertado ya es usado por otro registro.'
                        ) AS Retorno;
                    ELSE
                        INSERT INTO `generos` (`Nombre`, `Descripcion`) VALUES (Nombre_Acc, Descripcion_Acc);
                        IF ROW_COUNT() > 0 THEN
                            SELECT g.Id INTO Id_Retorno FROM generos g WHERE g.Nombre = Nombre_Acc;
                            SELECT JSON_OBJECT(
                                'Status', 'Ok',
                                'Data', JSON_OBJECT('Id', Id_Retorno),
                                'Message', 'Registro exitoso.'
                            ) AS Retorno;
                        ELSE
                            SELECT JSON_OBJECT(
                                'Status', 'Error',
                                'Data', null,
                                'Message', 'No se pudo realizar el registro.'
                            ) AS Retorno;
                        END IF;
                    END IF;
                END IF;
            WHEN 'READ' THEN
                IF (IFNULL(Id_Acc, 0) = 0) AND (LENGTH(IFNULL(Nombre_Acc, "")) = 0) THEN
                    /* SELECT JSON_ARRAYAGG(
                        JSON_OBJECT(
                            'Id', Id,
                            'Nombre', Nombre,
                            'Descripcion', Descripcion
                        )
                    ) INTO Todos_Registros FROM generos; */
                    SELECT CONCAT('[', GROUP_CONCAT(
                        JSON_OBJECT(
                            'Id', g.Id,
                            'Nombre', g.Nombre,
                            'Descripcion', g.Descripcion
                        )
                    ), ']') INTO Todos_Registros FROM generos g;
                    SELECT JSON_OBJECT(
                        'Status', 'Ok',
                        'Data', Todos_Registros,
                        'Message', 'Datos encontrados.'
                    ) AS Retorno;
                ELSE
                    SELECT COUNT(g.Id) INTO Bandera FROM generos g WHERE g.Id = Id_Acc OR g.Nombre = Nombre_Acc;
                    IF(Bandera < 1) THEN
                        SELECT JSON_OBJECT(
                            'Status', 'Error',
                            'Data', null,
                            'Message', 'No se encontro registro.'
                        ) AS Retorno;
                    ELSE
                        SELECT JSON_OBJECT(
                            'Status', 'Ok',
                            'Data', JSON_OBJECT("Id", g.Id, "Nombre", g.Nombre, "Descripcion", g.Descripcion),
                            'Message', 'Datos encontrados.'
                        ) AS Retorno
                        FROM generos g
                        WHERE g.Id = Id_Acc OR g.Nombre = Nombre_Acc;
                    END IF;
                END IF;
            WHEN 'UPDATE' THEN
                IF IFNULL(Id_Acc, 0) = 0 THEN
                    SELECT JSON_OBJECT(
                        'Status', 'Error',
                        'Data', null,
                        'Message', 'No se envio el ID del género para actualizar.'
                    ) AS Retorno;
                ELSE
                    SELECT COUNT(g.Id) INTO Bandera FROM generos g WHERE g.Id = Id_Acc;
                    IF(Bandera < 1) THEN
                        SELECT JSON_OBJECT(
                            'Status', 'Error',
                            'Data', null,
                            'Message', 'El ID insertado no pertenece a algún registro.'
                        ) AS Retorno;
                    ELSE
                        UPDATE generos SET Nombre = Nombre_Acc, Descripcion = Descripcion_Acc  WHERE Id = Id_Acc;
                        IF ROW_COUNT() > 0 THEN
                            SELECT g.Id INTO Id_Retorno FROM generos g WHERE g.Id = Id_Acc;
                            SELECT JSON_OBJECT(
                                'Status', 'Ok',
                                'Data', JSON_OBJECT('Id', Id_Retorno),
                                'Message', 'Actualización exitosa.'
                            ) AS Retorno;
                        ELSE
                            SELECT JSON_OBJECT(
                                'Status', 'Error',
                                'Data', null,
                                'Message', 'No se pudo realizar la actualización.'
                            ) AS Retorno;
                        END IF;
                    END IF;
                END IF;
            WHEN 'DELETE' THEN
                IF IFNULL(Id_Acc, 0) = 0 THEN
                    SELECT JSON_OBJECT(
                        'Status', 'Error',
                        'Data', null,
                        'Message', 'No se envio el ID del género para actualizar.'
                    ) AS Retorno;
                ELSE
                    SELECT COUNT(g.Id) INTO Bandera FROM generos g WHERE g.Id = Id_Acc;
                    IF(Bandera < 1) THEN
                        SELECT JSON_OBJECT(
                            'Status', 'Error',
                            'Data', null,
                            'Message', 'El ID insertado no pertenece a algún registro.'
                        ) AS Retorno;
                    ELSE
                        DELETE FROM generos WHERE Id = Id_Acc;
                        IF ROW_COUNT() > 0 THEN
                            SELECT g.Id INTO Id_Retorno FROM generos g WHERE g.Id = Id_Acc;
                            SELECT JSON_OBJECT(
                                'Status', 'Ok',
                                'Data', JSON_OBJECT(),
                                'Message', 'Borado exitoso.'
                            ) AS Retorno;
                        ELSE
                            SELECT JSON_OBJECT(
                                'Status', 'Error',
                                'Data', null,
                                'Message', 'No se pudo realizar el borrado.'
                            ) AS Retorno;
                        END IF;
                    END IF;
                END IF;
            ELSE
                SELECT JSON_OBJECT(
                    'Status', 'Error',
                    'Data', null,
                    'Message', 'No se recibio una opción valida a realizar.'
                ) AS Retorno;
            END CASE;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ACCIONES_INDIVIDUO` (IN `Id_Acc` INT, IN `Nombre_Acc` VARCHAR(255), IN `Edad_Acc` INT, IN `Direccion_Acc` INT, IN `Genero_Acc` INT, IN `Salario_Acc` FLOAT(12,2), IN `Opcion` VARCHAR(255))   BEGIN
	DECLARE Bandera INT;
	DECLARE Id_Retorno INT;
    DECLARE Todos_Registros JSON;
    IF LENGTH(IFNULL(Opcion, '')) = 0 THEN
        SELECT JSON_OBJECT(
            'Status', 'Error',
            'Data', null,
            'Message', 'No se recibio una opción a realizar.'
        ) AS Retorno;
    ELSE
        CASE Opcion
            WHEN 'CREATE' THEN
                IF LENGTH(IFNULL(Nombre_Acc, '')) = 0 THEN
                    SELECT JSON_OBJECT(
                        'Status', 'Error',
                        'Data', null,
                        'Message', 'No se envio un nombre.'
                    ) AS Retorno;
                ELSE
                    SELECT COUNT(i.Id) INTO Bandera FROM individuos i WHERE i.Nombre = Nombre_Acc;
                    IF(Bandera > 1) THEN
                        SELECT JSON_OBJECT(
                            'Status', 'Error',
                            'Data', null,
                            'Message', 'El nombre insertado ya es usado por otro registro.'
                        ) AS Retorno;
                    ELSE
                        INSERT INTO `individuos` (`Nombre`, `Edad`, `Direccion`, `Genero`, `Salario`)
                            VALUES (Nombre_Acc, Edad_Acc, Direccion_Acc, Genero_Acc, Salario_Acc);
                        IF ROW_COUNT() > 0 THEN
                            SELECT i.Id INTO Id_Retorno FROM individuos i WHERE i.Nombre = Nombre_Acc;
                            SELECT JSON_OBJECT(
                                'Status', 'Ok',
                                'Data', JSON_OBJECT('Id', Id_Retorno),
                                'Message', 'Registro exitoso.'
                            ) AS Retorno;
                        ELSE
                            SELECT JSON_OBJECT(
                                'Status', 'Error',
                                'Data', null,
                                'Message', 'No se pudo realizar el registro.'
                            ) AS Retorno;
                        END IF;
                    END IF;
                END IF;
            WHEN 'READ' THEN
                IF (IFNULL(Id_Acc, 0) = 0) AND (LENGTH(IFNULL(Nombre_Acc, "")) = 0) THEN
                    SELECT CONCAT('[', GROUP_CONCAT(
                        JSON_OBJECT(
                            'Id', i.Id,
                            'Nombre', i.Nombre,
                            'Edad', i.Edad,
                            'Direccion', (
                                SELECT JSON_OBJECT(
                                    'Id', d.Id,
                                    'Nombre_Calle', d.Nombre_Calle,
                                    'Numero_Exterior', d.Numero_Exterior,
                                    'Numero_Interior', d.Numero_Interior,
                                    'Colonia_Barrio', d.Colonia_Barrio,
                                    'Codigo_Postal', d.Codigo_Postal,
                                    'Ciudad_Localidad', d.Ciudad_Localidad,
                                    'Estado_Provincia', d.Estado_Provincia,
                                    'Pais', d.Pais
                                )
                                FROM direcciones d
                                WHERE d.Id = i.Direccion
                            ),
                            'Genero', (
                                SELECT JSON_OBJECT(
                                    'Id', g.Id,
                                    'Nombre', g.Nombre,
                                    'Descripcion', g.Descripcion
                                )
                                FROM generos g
                                WHERE g.Id = i.Genero
                            ),
                            'Salario', i.Salario
                        )
                    ), ']') INTO Todos_Registros FROM individuos i;
                    SELECT JSON_OBJECT(
                        'Status', 'Ok',
                        'Data', Todos_Registros,
                        'Message', 'Datos encontrados.'
                    ) AS Retorno;
                ELSE
                    SELECT COUNT(i.Id) INTO Bandera FROM individuos i WHERE i.Id = Id_Acc OR i.Nombre = Nombre_Acc;
                    IF(Bandera < 1) THEN
                        SELECT JSON_OBJECT(
                            'Status', 'Error',
                            'Data', null,
                            'Message', 'No se encontro registro.'
                        ) AS Retorno;
                    ELSE
                        SELECT JSON_OBJECT(
                            'Status', 'Ok',
                            'Data', JSON_OBJECT(
                                'Id', i.Id,
                                'Nombre', i.Nombre,
                                'Edad', i.Edad,
                                'Direccion', (
                                    SELECT JSON_OBJECT(
                                        'Id', d.Id,
                                        'Nombre_Calle', d.Nombre_Calle,
                                        'Numero_Exterior', d.Numero_Exterior,
                                        'Numero_Interior', d.Numero_Interior,
                                        'Colonia_Barrio', d.Colonia_Barrio,
                                        'Codigo_Postal', d.Codigo_Postal,
                                        'Ciudad_Localidad', d.Ciudad_Localidad,
                                        'Estado_Provincia', d.Estado_Provincia,
                                        'Pais', d.Pais
                                    )
                                    FROM direcciones d
                                    WHERE d.Id = i.Direccion
                                ),
                                'Genero', (
                                    SELECT JSON_OBJECT(
                                        'Id', g.Id,
                                        'Nombre', g.Nombre,
                                        'Descripcion', g.Descripcion
                                    )
                                    FROM generos g
                                    WHERE g.Id = i.Genero
                                ),
                                'Salario', i.Salario
                            ),
                            'Message', 'Datos encontrados.'
                        ) AS Retorno
                        FROM individuos i
                        WHERE i.Id = Id_Acc OR i.Nombre = Nombre_Acc;
                    END IF;
                END IF;
            WHEN 'UPDATE' THEN
                IF IFNULL(Id_Acc, 0) = 0 THEN
                    SELECT JSON_OBJECT(
                        'Status', 'Error',
                        'Data', null,
                        'Message', 'No se envio el ID del género para actualizar.'
                    ) AS Retorno;
                ELSE
                    SELECT COUNT(i.Id) INTO Bandera FROM individuos i WHERE i.Id = Id_Acc;
                    IF(Bandera < 1) THEN
                        SELECT JSON_OBJECT(
                            'Status', 'Error',
                            'Data', null,
                            'Message', 'El ID insertado no pertenece a algún registro.'
                        ) AS Retorno;
                    ELSE
                        UPDATE individuos
                            SET Nombre = Nombre_Acc,
                                Edad = Edad_Acc,
                                Direccion = Direccion_Acc,
                                Genero = Genero_Acc,
                                Salario = Salario_Acc
                            WHERE Id = Id_Acc;
                        IF ROW_COUNT() > 0 THEN
                            SELECT i.Id INTO Id_Retorno FROM individuos i WHERE i.Id = Id_Acc;
                            SELECT JSON_OBJECT(
                                'Status', 'Ok',
                                'Data', JSON_OBJECT('Id', Id_Retorno),
                                'Message', 'Actualización exitosa.'
                            ) AS Retorno;
                        ELSE
                            SELECT JSON_OBJECT(
                                'Status', 'Error',
                                'Data', null,
                                'Message', 'No se pudo realizar la actualización.'
                            ) AS Retorno;
                        END IF;
                    END IF;
                END IF;
            WHEN 'DELETE' THEN
                IF IFNULL(Id_Acc, 0) = 0 THEN
                    SELECT JSON_OBJECT(
                        'Status', 'Error',
                        'Data', null,
                        'Message', 'No se envio el ID del género para actualizar.'
                    ) AS Retorno;
                ELSE
                    SELECT COUNT(i.Id) INTO Bandera FROM individuos i WHERE i.Id = Id_Acc;
                    IF(Bandera < 1) THEN
                        SELECT JSON_OBJECT(
                            'Status', 'Error',
                            'Data', null,
                            'Message', 'El ID insertado no pertenece a algún registro.'
                        ) AS Retorno;
                    ELSE
                        DELETE FROM individuos WHERE Id = Id_Acc;
                        IF ROW_COUNT() > 0 THEN
                            SELECT i.Id INTO Id_Retorno FROM individuos i WHERE i.Id = Id_Acc;
                            SELECT JSON_OBJECT(
                                'Status', 'Ok',
                                'Data', JSON_OBJECT(),
                                'Message', 'Borado exitoso.'
                            ) AS Retorno;
                        ELSE
                            SELECT JSON_OBJECT(
                                'Status', 'Error',
                                'Data', null,
                                'Message', 'No se pudo realizar el borrado.'
                            ) AS Retorno;
                        END IF;
                    END IF;
                END IF;
            ELSE
                SELECT JSON_OBJECT(
                    'Status', 'Error',
                    'Data', null,
                    'Message', 'No se recibio una opción valida a realizar.'
                ) AS Retorno;
            END CASE;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direcciones`
--

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

--
-- Volcado de datos para la tabla `direcciones`
--

INSERT INTO `direcciones` (`Id`, `Nombre_Calle`, `Numero_Exterior`, `Numero_Interior`, `Colonia_Barrio`, `Codigo_Postal`, `Ciudad_Localidad`, `Estado_Provincia`, `Pais`) VALUES
(1, 'Mar de cortes', 320, NULL, 'Villa Carey', 82134, 'Mazatlan', 'Sinaloa', 'Mexico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `generos`
--

CREATE TABLE `generos` (
  `Id` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` varchar(1079) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `generos`
--

INSERT INTO `generos` (`Id`, `Nombre`, `Descripcion`) VALUES
(5, 'Mujer', 'Sexo femenino natural'),
(7, 'Hombre', 'Sexo masculino natural');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `individuos`
--

CREATE TABLE `individuos` (
  `Id` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Edad` int(11) NOT NULL,
  `Direccion` int(11) NOT NULL,
  `Genero` int(11) NOT NULL,
  `Salario` float(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `individuos`
--

INSERT INTO `individuos` (`Id`, `Nombre`, `Edad`, `Direccion`, `Genero`, `Salario`) VALUES
(1, 'Manuel Adrián Millán Leal', 23, 1, 7, 18500.50);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `generos`
--
ALTER TABLE `generos`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `individuos`
--
ALTER TABLE `individuos`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Direccion` (`Direccion`),
  ADD KEY `Genero` (`Genero`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `generos`
--
ALTER TABLE `generos`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `individuos`
--
ALTER TABLE `individuos`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `individuos`
--
ALTER TABLE `individuos`
  ADD CONSTRAINT `individuos_ibfk_2` FOREIGN KEY (`Direccion`) REFERENCES `direcciones` (`Id`),
  ADD CONSTRAINT `individuos_ibfk_3` FOREIGN KEY (`Genero`) REFERENCES `generos` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
