DELIMITER //
CREATE PROCEDURE SP_ACCIONES_INDIVIDUO(
    IN Id_Acc INT,
	IN Nombre_Acc VARCHAR(255),
	IN Edad_Acc INT,
	IN Direccion_Acc INT,
	IN Genero_Acc INT,
	IN Salario_Acc FLOAT(12,2),
    IN Opcion VARCHAR(255)
)
BEGIN
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
END //
DELIMITER ;

CALL SP_ACCIONES_INDIVIDUO (NULL,'Manuel Adrián Millán Leal', 23, 2, 1, 18500.50, 'CREATE');
CALL SP_ACCIONES_INDIVIDUO (1,'Manuel Adrián Millán Leal', 23, 2, 2, 18500.50, 'UPDATE');

CALL SP_ACCIONES_INDIVIDUO (NULL,NULL, NULL, NULL, NULL, NULL, 'READ');
