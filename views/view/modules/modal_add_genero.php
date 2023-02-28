<div class="modal fade" id="modal_add_genero" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Agregar género</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="limpiarCamposGenero()"></button>
            </div>
            <div class="modal-body">
                <div class="container" id="contenedor_errores_genero"></div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="span_nombre_acc">Nombre:</span>
                    <input  type="text"
                            class="form-control"
                            placeholder="Nombre"
                            aria-label="Nombre"
                            id="Nombre_Genero_Acc"
                            name="Nombre_Genero_Acc"
                            aria-describedby="span_nombre_acc">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="span_descripcion_acc">Descripción:</span>
                    <input  type="text"
                            class="form-control"
                            placeholder="Descripción"
                            aria-label="Descripción"
                            id="Descripcion_Genero_Acc"
                            name="Descripcion_Genero_Acc"
                            aria-describedby="span_descripcion_acc">
                </div>
            </div>
            <div class="modal-footer text-muted">
                <button class="btn btn-light" type="button" onclick="agregarGenero()">
                    <i class="fa-sharp fa-solid fa-plus"></i> Agregar género
                </button>
            </div>
        </div>
    </div>
</div>
<script src="./view/modules/js/modal_add_genero.js" ></script>