<?php
    require_once "settings.config.php";
    try {
        $pdo = new PDO($DNS, $UserName, $Password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {
        echo 'Error de conexión: ' . $e->getMessage();
    }
?>