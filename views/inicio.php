<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- SheetJS -->
        <script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
        <!-- FileSaver.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
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
                    <div class="container" id="contenedor_errores"></div>
                    <div class="container d-flex">
                        <div class="input-group mb-3" id="contenedor_nombre_acc">
                            <span class="input-group-text" id="span_nombre_acc">Nombre:</span>
                            <input  type="text"
                                    class="form-control"
                                    placeholder="Nombre"
                                    aria-label="Nombre"
                                    id="Nombre_Acc"
                                    name="Nombre_Acc"
                                    aria-describedby="span_nombre_acc">
                        </div>
                        <div class="input-group mb-3" id="contenedor_genero_acc">
                            <span class="input-group-text" id="span_genero_acc">Genero:</span>
                            <select class="form-select form-control"
                                    aria-label="Genero"
                                    id="Genero_Acc"
                                    name="Genero_Acc"
                                    aria-describedby="span_genero_acc">
                            </select>
                            <button class="btn btn-outline-secondary"
                                    type="button"
                                    id="span_genero_acc"><i class="fa-sharp fa-solid fa-plus"></i>
                            </button>
                        </div>
                        <div class="input-group mb-3" id="contenedor_edad_acc">
                            <span class="input-group-text" id="span_edad_acc">Edad:</span>
                            <input  type="text"
                                    class="form-control"
                                    placeholder="Edad"
                                    aria-label="Edad"
                                    id="Edad_Acc"
                                    name="Edad_Acc"
                                    aria-describedby="span_edad_acc">
                        </div>
                    </div>
                    <div class="container d-flex">
                        <div class="input-group mb-3" id="contenedor_direccion_acc">
                            <span class="input-group-text" id="span_direccion_acc">Dirección:</span>
                            <input  type="text"
                                    class="form-control"
                                    placeholder="Dirección"
                                    aria-label="Dirección"
                                    id="Direccion_Acc"
                                    name="Direccion_Acc"
                                    aria-describedby="span_direccion_acc"
                                    readonly
                                    data-bs-toggle="modal"
                                    data-bs-target="#modal_select_direccion"
                                    onclick="llenarDirecciones()">
                            <button class="btn btn-outline-secondary"
                                    type="button"
                                    id="span_direccion_acc"><i class="fa-sharp fa-solid fa-plus"></i>
                            </button>
                        </div>
                        <div class="input-group mb-3" id="contenedor_salario_acc">
                            <span class="input-group-text" id="span_salario_acc">Salario:</span>
                            <input  type="text"
                                    class="form-control"
                                    placeholder="Salario"
                                    aria-label="Salario"
                                    id="Salario_Acc"
                                    name="Salario_Acc"
                                    aria-describedby="span_salario_acc">
                        </div>
                    </div>
                </div>
                <div class="card-footer text-muted d-flex">
                    <!-- <button class="btn btn-light" type="button" onclick="llenarTablaIndividuos()">
                        <span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
                        Loading...
                    </button> -->
                    <button class="btn btn-light" type="button" onclick="llenarTablaIndividuos()">
                        <i class="fa-solid fa-magnifying-glass"></i> Buscar registros
                    </button>
                    <button class="btn btn-light" type="button" onclick="agregarRegistro()">
                        <i class="fa-sharp fa-solid fa-plus"></i> Agregar registro
                    </button>
                    <button class="btn btn-light" type="button" onclick="editarRegistro()">
                        <i class="fa-solid fa-pen-to-square"></i> Editar registro
                    </button>
                    <button class="btn btn-light" type="button" onclick="eliminarRegistro()">
                        <i class="fa-sharp fa-solid fa-trash"></i> Eliminar registro
                    </button>
                    <button class="btn btn-light ms-auto" type="button" onclick="limpiarPantalla()">
                        <i class="fa-solid fa-eraser"></i> Limpiar pantalla
                    </button>
                </div>
            </div>
            <div class="card text-center mb-3" id="card_tabla_registros">
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
                        <tbody><tr><td colspan="6">No se encontraron registros</td></tr></tbody>
                    </table>
                </div>
                <div class="card-footer text-muted d-flex">
                    <button class="btn btn-light" type="button" onclick="exportarAExcel()">
                        <i class="fa-solid fa-file-excel"></i> Exportar a excel
                    </button>
                </div>
            </div>
            <div class="card text-center mb-3" id="card_tabla_totales">
                <div class="card-header">
                    Total de salarios
                </div>
                <div class="card-body">
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="Total_Salarios">Totalizado de Salarios: </span>
                        <label class="form-control" aria-describedby="Total_Salarios" id="Show_Total_Salarios"></label>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="Salario_Promedio_General">Salario Promedio General: </span>
                        <label class="form-control" aria-describedby="Salario_Promedio_General" id="Show_Salario_Promedio_General"></label>
                    </div>
                    <div class="card text-center mb-3">
                        <div class="card-header">
                            Salario Promedio Por Genero:
                        </div>
                        <div class="card-body">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="Genero_Hombre">Hombre: </span>
                                <label class="form-control" aria-describedby="Genero_Hombre" id="Show_Genero_Hombre"></label>
                            </div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="Genero_Mujer">Mujer: </span>
                                <label class="form-control" aria-describedby="Genero_Mujer" id="Show_Genero_Mujer"></label>
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
        <?php include './view/modules/modal_select_direccion.php'; ?>
    </body>
</html>