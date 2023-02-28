<?php
    require_once "../db/PDO.php";
    $id = $_POST['ID']  == 'null' ? null : $_POST['ID'];
    $nombre_calle = $_POST['NOMBRE_CALLE']  == 'null' ? null : $_POST['NOMBRE_CALLE'];
    $numero_exterior = $_POST['NUMERO_EXTERIOR']  == 'null' ? null : $_POST['NUMERO_EXTERIOR'];
    $numero_interior = $_POST['NUMERO_INTERIOR']  == 'null' ? null : $_POST['NUMERO_INTERIOR'];
    $colonia_barrio = $_POST['COLONIA_BARRIO']  == 'null' ? null : $_POST['COLONIA_BARRIO'];
    $codigo_postal = $_POST['CODIGO_POSTAL']  == 'null' ? null : $_POST['CODIGO_POSTAL'];
    $ciudad_localidad = $_POST['CIUDAD_LOCALIDAD']  == 'null' ? null : $_POST['CIUDAD_LOCALIDAD'];
    $estado_provincia = $_POST['ESTADO_PROVINCIA']  == 'null' ? null : $_POST['ESTADO_PROVINCIA'];
    $pais = $_POST['PAIS']  == 'null' ? null : $_POST['PAIS'];
    $opcion = $_POST['OPCION'];
    $stmt = $pdo->prepare("CALL SP_ACCIONES_DIRECCION(:Id_Acc, :Nombre_Calle_Acc, :Numero_Exterior_Acc, :Numero_Interior_Acc, :Colonia_Barrio_Acc, :Codigo_Postal_Acc, :Ciudad_Localidad_Acc, :Estado_Provincia_Acc, :Pais_Acc, :Opcion)");
    $stmt->bindParam(":Id_Acc", $id, PDO::PARAM_INT);
    $stmt->bindParam(":Nombre_Calle_Acc", $nombre_calle, PDO::PARAM_STR);
    $stmt->bindParam(":Numero_Exterior_Acc", $numero_exterior, PDO::PARAM_STR);
    $stmt->bindParam(":Numero_Interior_Acc", $numero_interior, PDO::PARAM_STR);
    $stmt->bindParam(":Colonia_Barrio_Acc", $colonia_barrio, PDO::PARAM_STR);
    $stmt->bindParam(":Codigo_Postal_Acc", $codigo_postal, PDO::PARAM_STR);
    $stmt->bindParam(":Ciudad_Localidad_Acc", $ciudad_localidad, PDO::PARAM_STR);
    $stmt->bindParam(":Estado_Provincia_Acc", $estado_provincia, PDO::PARAM_STR);
    $stmt->bindParam(":Pais_Acc", $pais, PDO::PARAM_STR);
    $stmt->bindParam(":Opcion", $opcion, PDO::PARAM_STR);
    $stmt->execute();
    $resultado = $stmt->fetch(PDO::FETCH_ASSOC);
    $resultado_json = json_encode($resultado);
    echo $resultado_json;
?>