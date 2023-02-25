<?php
    session_start();
    if(isset($_SESSION["vjDataSesion"])){
        /* guarda registro de que entro en login */
        echo "holi";
        header("Location: views/dashboard.php", true, 0);
    } else {
        session_destroy();
        echo "no holi";
        header("Location: views/login.php", true, 0);
    }
?>