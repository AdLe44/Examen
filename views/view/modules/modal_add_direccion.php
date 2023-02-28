<div class="modal fade" id="modal_add_direccion" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Agregar dirección</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="limpiarCamposDireccion()"></button>
            </div>
            <div class="modal-body">
                <div class="container" id="contenedor_errores_direcciones"></div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="span_nombre_calle_acc">Nombre de la calle:</span>
                    <input  type="text"
                            class="form-control"
                            placeholder="Nombre calle"
                            aria-label="Nombre calle"
                            id="Nombre_Calle_Acc"
                            name="Nombre_Calle_Acc"
                            aria-describedby="span_nombre_calle_acc">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="span_numero_exterior_acc">Número exterior:</span>
                    <input  type="text"
                            class="form-control"
                            placeholder="Número exterior"
                            aria-label="Número exterior"
                            id="Numero_Exterior_Acc"
                            name="Numero_Exterior_Acc"
                            aria-describedby="span_numero_exterior_acc">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="span_numero_interior_acc">Número interior:</span>
                    <input  type="text"
                            class="form-control"
                            placeholder="Número interior"
                            aria-label="Número interior"
                            id="Numero_Interior_Acc"
                            name="Numero_Interior_Acc"
                            aria-describedby="span_numero_interior_acc">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="span_colonia_barrio_acc">Colonia o barrio:</span>
                    <input  type="text"
                            class="form-control"
                            placeholder="Colonia o barrio"
                            aria-label="Colonia o barrio"
                            id="Colonia_Barrio_Acc"
                            name="Colonia_Barrio_Acc"
                            aria-describedby="span_colonia_barrio_acc">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="span_codigo_postal_acc">Código postal:</span>
                    <input  type="text"
                            class="form-control"
                            placeholder="Código postal"
                            aria-label="Código postal"
                            id="Codigo_Postal_Acc"
                            name="Codigo_Postal_Acc"
                            aria-describedby="span_codigo_postal_acc">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="span_ciudad_localidad_acc">Ciudad o localidad:</span>
                    <input  type="text"
                            class="form-control"
                            placeholder="Ciudad o localidad"
                            aria-label="Ciudad o localidad"
                            id="Ciudad_Localidad_Acc"
                            name="Ciudad_Localidad_Acc"
                            aria-describedby="span_ciudad_localidad_acc">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="span_estado_provincia_acc">Estado o provincia:</span>
                    <input  type="text"
                            class="form-control"
                            placeholder="Estado o provincia"
                            aria-label="Estado o provincia"
                            id="Estado_Provincia_Acc"
                            name="Estado_Provincia_Acc"
                            aria-describedby="span_estado_provincia_acc">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="span_pais_acc">Pais:</span>
                    <input  type="text"
                            class="form-control"
                            placeholder="Pais"
                            aria-label="Pais"
                            id="Pais_Acc"
                            name="Pais_Acc"
                            aria-describedby="span_pais_acc">
                </div>
            </div>
            <div class="modal-footer text-muted">
                <button class="btn btn-light" type="button" onclick="agregarDireccion()">
                    <i class="fa-sharp fa-solid fa-plus"></i> Agregar dirección
                </button>
            </div>
        </div>
    </div>
</div>
<script src="./view/modules/js/modal_add_direccion.js" ></script>