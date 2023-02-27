<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
        <!-- Icons -->
        <script src="https://kit.fontawesome.com/24e03733fb.js" crossorigin="anonymous"></script>
        <!-- CSS -->
        <link href="../config/default.css" rel="stylesheet">
        <link href="./config/css/inicio.css" rel="stylesheet">
        <link rel="icon" href="../resource/imgs/logo.png">
        <title>INICIO</title>
    </head>
    <body>
        <div class="container mt-5">
            <div class="card text-center mb-3">
                <div class="card-header">
                    Acciones
                </div>
                <div class="card-body">
                    <button class="btn btn-primary" type="button" onclick="llenarTablaIndividuos()">
                        <span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
                        Loading...
                    </button>
                </div>
                <div class="card-footer text-muted">
                    <!--  -->
                </div>
            </div>
            <div class="card text-center mb-3">
                <div class="card-header">
                    Individuos
                </div>
                <div class="card-body">
                    <table class="table table-hover" id="tabla_registros_individuos">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Edad</th>
                                <th scope="col">Direccion</th>
                                <th scope="col">Genero</th>
                                <th scope="col">Salario</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="table-active">
                                <th scope="row">3</th>
                                <td>Larry the Bird</td>
                                <td>@twitter</td>
                                <td>@twitter</td>
                                <td>@twitter</td>
                                <td>@twitter</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="card-footer text-muted">
                    <!--  -->
                </div>
            </div>
            <div class="card text-center mb-3">
                <div class="card-header">
                    Total de salarios
                </div>
                <div class="card-body">
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="Total_Salarios">Totalizado de Salarios: </span>
                        <label class="form-control" aria-describedby="Total_Salarios" id=""></label>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="Salario_Promedio_General">Salario Promedio General: </span>
                        <label class="form-control" aria-describedby="Salario_Promedio_General" id=""></label>
                    </div>
                    <div class="card text-center mb-3">
                        <div class="card-header">
                            Salario Promedio Por Genero:
                        </div>
                        <div class="card-body">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="Genero_Hombre">Hombre: </span>
                                <label class="form-control" aria-describedby="Genero_Hombre" id=""></label>
                            </div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="Genero_Mujer">Mujer: </span>
                                <label class="form-control" aria-describedby="Genero_Mujer" id=""></label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer text-muted">
                    <!--  -->
                </div>
            </div>
        </div>
        <script src="./config/js/inicio.js" ></script>
    </body>
</html>