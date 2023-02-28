<?php
    require_once "../db/PDO.php";
    $id = $_POST['ID']  == 'null' ? null : $_POST['ID'];
    $nombre = $_POST['NOMBRE']  == 'null' ? null : $_POST['NOMBRE'];
    $edad = $_POST['EDAD']  == 'null' ? null : $_POST['EDAD'];
    $direccion = $_POST['DIRECCION']  == 'null' ? null : $_POST['DIRECCION'];
    $genero = $_POST['GENERO']  == 'null' ? null : $_POST['GENERO'];
    $salario = $_POST['SALARIO']  == 'null' ? null : $_POST['SALARIO'];
    $opcion = $_POST['OPCION'];
    $stmt = $pdo->prepare("CALL SP_ACCIONES_INDIVIDUO(:Id_Acc, :Nombre_Acc, :Edad_Acc, :Direccion_Acc, :Genero_Acc, :Salario_Acc, :Opcion)");
    $stmt->bindParam(":Id_Acc", $id, PDO::PARAM_INT);
    $stmt->bindParam(":Nombre_Acc", $nombre, PDO::PARAM_STR);
    $stmt->bindParam(":Edad_Acc", $edad, PDO::PARAM_INT);
    $stmt->bindParam(":Direccion_Acc", $direccion, PDO::PARAM_INT);
    $stmt->bindParam(":Genero_Acc", $genero, PDO::PARAM_INT);
    $stmt->bindParam(":Salario_Acc", $salario, PDO::PARAM_STR);
    $stmt->bindParam(":Opcion", $opcion, PDO::PARAM_STR);
    $stmt->execute();
    $resultado = $stmt->fetch(PDO::FETCH_ASSOC);
    $resultado_json = json_encode($resultado);
    echo $resultado_json;
?>