DELIMITER //
CREATE PROCEDURE SP_ACCIONES_GENERO(
    IN Id_Acc INT,
	IN Nombre_Acc VARCHAR(255),
	IN Descripcion_Acc VARCHAR(1079),
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
END //
DELIMITER ;

CALL SP_ACCIONES_GENERO (NULL,'Mujer', 'Sexo femenino.', 'CREATE');
CALL SP_ACCIONES_GENERO (NULL,'Hombre', 'Sexo masculino.', 'CREATE');

CALL SP_ACCIONES_GENERO (NULL, NULL, NULL, 'READ');
