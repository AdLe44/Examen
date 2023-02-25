<?php
    session_start();
    if(isset($_SESSION["vjDataSesion"])){
        /* guarda registro de que entro en login */
        header("views/dashboard.php", true, 0);
    } else {
        session_destroy();
        header("views/login.php", true, 0);
    }
?>