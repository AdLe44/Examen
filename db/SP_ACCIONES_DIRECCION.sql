DELIMITER //
CREATE PROCEDURE SP_ACCIONES_DIRECCION(
    IN Id_Acc INT,
	IN Nombre_Calle_Acc VARCHAR(255),
	IN Numero_Exterior_Acc INT,
	IN Numero_Interior_Acc INT,
	IN Colonia_Barrio_Acc VARCHAR(255),
	IN Codigo_Postal_Acc INT,
	IN Ciudad_Localidad_Acc VARCHAR(255),
	IN Estado_Provincia_Acc VARCHAR(255),
	IN Pais_Acc VARCHAR(255),
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
                IF  LENGTH(IFNULL(Nombre_Calle_Acc, '')) = 0 OR
                    IFNULL(Numero_Exterior_Acc, 0) = 0 OR
                    LENGTH(IFNULL(Colonia_Barrio_Acc, '')) = 0 OR
                    IFNULL(Codigo_Postal_Acc, 0) = 0 OR
                    LENGTH(IFNULL(Ciudad_Localidad_Acc, '')) = 0 OR
                    LENGTH(IFNULL(Estado_Provincia_Acc, '')) = 0 OR
                    LENGTH(IFNULL(Pais_Acc, '')) = 0 THEN
                    SELECT JSON_OBJECT(
                        'Status', 'Error',
                        'Data', null,
                        'Message', 'No se envio uno de los datos obligatorios.'
                    ) AS Retorno;
                ELSE
                    INSERT INTO direcciones (Nombre_Calle, Numero_Exterior, Numero_Interior, Colonia_Barrio, Codigo_Postal, Ciudad_Localidad, Estado_Provincia, Pais) 
                        VALUES (Nombre_Calle_Acc, Numero_Exterior_Acc, Numero_Interior_Acc, Colonia_Barrio_Acc, Codigo_Postal_Acc, Ciudad_Localidad_Acc, Estado_Provincia_Acc, Pais_Acc);
                    IF ROW_COUNT() > 0 THEN
                        SELECT  Id INTO Id_Retorno FROM direcciones WHERE Id = LAST_INSERT_ID();
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
            WHEN 'READ' THEN
                IF IFNULL(Id_Acc, 0) = 0 THEN
                    SELECT CONCAT('[', GROUP_CONCAT(
                        JSON_OBJECT(
                            'Id', Id,
                            'Nombre_Calle', Nombre_Calle,
                            'Numero_Exterior', Numero_Exterior,
                            'Colonia_Barrio', Colonia_Barrio,
                            'Codigo_Postal', Codigo_Postal,
                            'Ciudad_Localidad', Ciudad_Localidad,
                            'Estado_Provincia', Estado_Provincia,
                            'Pais', Pais
                        )
                    ), ']') INTO Todos_Registros FROM direcciones;
                    SELECT JSON_OBJECT(
                        'Status', 'Ok',
                        'Data', Todos_Registros,
                        'Message', 'Datos encontrados.'
                    ) AS Retorno;
                ELSE
                    SELECT COUNT(Id) INTO Bandera FROM direcciones WHERE Id = Id_Acc;
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
                                'Id', Id,
                                'Nombre_Calle', Nombre_Calle,
                                'Numero_Exterior', Numero_Exterior,
                                'Colonia_Barrio', Colonia_Barrio,
                                'Codigo_Postal', Codigo_Postal,
                                'Ciudad_Localidad', Ciudad_Localidad,
                                'Estado_Provincia', Estado_Provincia,
                                'Pais', Pais
                            ),
                            'Message', 'Datos encontrados.'
                        ) AS Retorno
                        FROM direcciones
                        WHERE Id = Id_Acc;
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
                    SELECT COUNT(Id) INTO Bandera FROM direcciones WHERE Id = Id_Acc;
                    IF(Bandera < 1) THEN
                        SELECT JSON_OBJECT(
                            'Status', 'Error',
                            'Data', null,
                            'Message', 'El ID insertado no pertenece a algún registro.'
                        ) AS Retorno;
                    ELSE
                        UPDATE direcciones
                            SET Nombre_Calle = Nombre_Calle_Acc,
                                Numero_Exterior = Numero_Exterior_Acc,
                                Numero_Interior = Numero_Interior_Acc,
                                Colonia_Barrio = Colonia_Barrio_Acc,
                                Codigo_Postal = Codigo_Postal_Acc,
                                Ciudad_Localidad = Ciudad_Localidad_Acc,
                                Estado_Provincia = Estado_Provincia_Acc,
                                Pais = Pais_Acc
                            WHERE Id = Id_Acc;
                        IF ROW_COUNT() > 0 THEN
                            SELECT Id INTO Id_Retorno FROM direcciones WHERE Id = Id_Acc;
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
                    SELECT COUNT(Id) INTO Bandera FROM direcciones WHERE Id = Id_Acc;
                    IF(Bandera < 1) THEN
                        SELECT JSON_OBJECT(
                            'Status', 'Error',
                            'Data', null,
                            'Message', 'El ID insertado no pertenece a algún registro.'
                        ) AS Retorno;
                    ELSE
                        DELETE FROM direcciones WHERE Id = Id_Acc;
                        IF ROW_COUNT() > 0 THEN
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

CALL SP_ACCIONES_DIRECCION (NULL, 'Mar de cortez', 320, NULL, 'Villa Carey', 82134, 'Mazatlán', 'Sinaloa', 'México', 'CREATE')

CALL SP_ACCIONES_DIRECCION (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'READ')