function agregarGenero(){
    let inputNombre = document.getElementById("Nombre_Genero_Acc");
    let inputDescripcion = document.getElementById("Descripcion_Genero_Acc");
    let contenedorErroresGenero = document.getElementById("contenedor_errores_genero");
    let data = {
        'Nombre_Acc': inputNombre.value,
        'Descripcion_Acc': inputDescripcion.value,
    }
    validarDatosGenero(data, (estado, mensaje)=>{
        if(estado){
            let datos = {
                ID: null,
                NOMBRE: inputNombre.value,
                DESCRIPCION: inputDescripcion.value,
                OPCION: "CREATE"
            };
            llamarProcGeneros(datos, (estado,retorno)=>{
                if(estado){
                    limpiarCamposGenero();
                    llenarGeneros();
                    $('#modal_add_genero').modal('hide');
                }else{
                    contenedorErroresGenero.innerHTML = '<div class="alert alert-warning" role="alert"><i class="fa-solid fa-triangle-exclamation"></i> '+retorno+'</div>';
                }
            })
        }else{
            console.error(mensaje);
            contenedorErroresGenero.innerHTML = '<div class="alert alert-danger" role="alert">'+mensaje+'</div>';
        }
    });
}
function validarDatosGenero(data, callback){
    if(!data.Nombre_Acc) return callback(false, 'No se han introducido el nombre');
    if(!data.Descripcion_Acc) return callback(false, 'No se han introducido la descripción');
    return callback(true, '');
}
function limpiarCamposGenero(){
    let inputNombre = document.getElementById("Nombre_Genero_Acc");
    let inputDescripcion = document.getElementById("Descripcion_Genero_Acc");
    let contenedorErroresGenero = document.getElementById("contenedor_errores_genero");
    inputNombre.value = "";
    inputDescripcion.value = "";
    contenedorErroresGenero.innerHTML = "";
}