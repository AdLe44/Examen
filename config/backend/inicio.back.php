<?php
    require_once "../db/PDO.php";
    $id = $_POST['ID']  == 'null' ? null : $_POST['ID'];
    $nombre = $_POST['NOMBRE']  == 'null' ? null : $_POST['NOMBRE'];
    $descripcion = $_POST['DESCRIPCION']  == 'null' ? null : $_POST['DESCRIPCION'];
    $opcion = $_POST['OPCION'];
    $stmt = $pdo->prepare("CALL SP_ACCIONES_GENERO(:Id_Acc, :Nombre_Acc, :Descripcion_Acc, :Opcion)");
    $stmt->bindParam(":Id_Acc", $id, PDO::PARAM_INT);
    $stmt->bindParam(":Nombre_Acc", $nombre, PDO::PARAM_STR);
    $stmt->bindParam(":Descripcion_Acc", $descripcion, PDO::PARAM_STR);
    $stmt->bindParam(":Opcion", $opcion, PDO::PARAM_STR);
    $stmt->execute();
    $resultado = $stmt->fetch(PDO::FETCH_ASSOC);
    $resultado_json = json_encode($resultado);
    echo $resultado_json;
?>