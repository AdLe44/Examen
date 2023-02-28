function agregarDireccion(){
    let inputNombreCalle = document.getElementById("Nombre_Calle_Acc");
    let inputNumeroExterior = document.getElementById("Numero_Exterior_Acc");
    let imputNumeroInterior = document.getElementById("Numero_Interior_Acc");
    let inputColoniaBarrio = document.getElementById("Colonia_Barrio_Acc");
    let inputCodigoPostal = document.getElementById("Codigo_Postal_Acc");
    let inputCiudadLocalidad = document.getElementById("Ciudad_Localidad_Acc");
    let inputEstadoProvincia = document.getElementById("Estado_Provincia_Acc");
    let inputPais = document.getElementById("Pais_Acc");
    let contenedorErroresDirecciones = document.getElementById("contenedor_errores_direcciones");
    let data = {
        'Nombre_Calle_Acc': inputNombreCalle.value,
        'Numero_Exterior_Acc': inputNumeroExterior.value,
        'Numero_Interior_Acc': imputNumeroInterior.value,
        'Colonia_Barrio_Acc': inputColoniaBarrio.value,
        'Codigo_Postal_Acc': inputCodigoPostal.value,
        'Ciudad_Localidad_Acc': inputCiudadLocalidad.value,
        'Estado_Provincia_Acc': inputEstadoProvincia.value,
        'Pais_Acc': inputPais.value
    }
    validarDatosDireccion(data, (estado, mensaje)=>{
        if(estado){
            let datos = {
                ID: null,
                NOMBRE_CALLE: inputNombreCalle.value,
                NUMERO_EXTERIOR: inputNumeroExterior.value,
                NUMERO_INTERIOR: imputNumeroInterior.value,
                COLONIA_BARRIO: inputColoniaBarrio.value,
                CODIGO_POSTAL: inputCodigoPostal.value,
                CIUDAD_LOCALIDAD: inputCiudadLocalidad.value,
                ESTADO_PROVINCIA: inputEstadoProvincia.value,
                PAIS: inputPais.value,
                OPCION: "CREATE"
            };
            console.log(datos);
            llamarProcDirecciones(datos, (estado,retorno)=>{
                if(estado){
                    limpiarCamposDireccion();
                    $('#modal_add_direccion').modal('hide');
                }else{
                    contenedorErroresDirecciones.innerHTML = '<div class="alert alert-warning" role="alert"><i class="fa-solid fa-triangle-exclamation"></i> '+retorno+'</div>';
                }
            })
        }else{
            console.error(mensaje);
            contenedorErroresDirecciones.innerHTML = '<div class="alert alert-danger" role="alert">'+mensaje+'</div>';
        }
    });
}
function validarDatosDireccion(data, callback){
    let regexNumero = /^\d+$/;
    if(!data.Nombre_Calle_Acc) return callback(false, 'No se han introducido el nombre de la calle');
    if(!data.Numero_Exterior_Acc) return callback(false, 'No se han introducido el número exterior');
    if(!data.Colonia_Barrio_Acc) return callback(false, 'No se han introducido la colonia o barrio');
    if(!data.Codigo_Postal_Acc) return callback(false, 'No se han introducido el código postal');
    if(!data.Ciudad_Localidad_Acc) return callback(false, 'No se han introducido la ciudad o localidad');
    if(!data.Estado_Provincia_Acc) return callback(false, 'No se han introducido el estado o provincia');
    if(!data.Pais_Acc) return callback(false, 'No se han introducido el pais');
    if(!regexNumero.test(data.Numero_Exterior_Acc)) return callback(false, 'El numero exterior no es valido');
    if(!regexNumero.test(data.Codigo_Postal_Acc)) return callback(false, 'El codigo postal no es valido');
    return callback(true, '');
}
function limpiarCamposDireccion(){
    let inputNombreCalle = document.getElementById("Nombre_Calle_Acc");
    let inputNumeroExterior = document.getElementById("Numero_Exterior_Acc");
    let imputNumeroInterior = document.getElementById("Numero_Interior_Acc");
    let inputColoniaBarrio = document.getElementById("Colonia_Barrio_Acc");
    let inputCodigoPostal = document.getElementById("Codigo_Postal_Acc");
    let inputCiudadLocalidad = document.getElementById("Ciudad_Localidad_Acc");
    let inputEstadoProvincia = document.getElementById("Estado_Provincia_Acc");
    let inputPais = document.getElementById("Pais_Acc");
    let contenedorErroresDirecciones = document.getElementById("contenedor_errores_direcciones");
    inputNombreCalle.value = "";
    inputNumeroExterior.value = "";
    imputNumeroInterior.value = "";
    inputColoniaBarrio.value = "";
    inputCodigoPostal.value = "";
    inputCiudadLocalidad.value = "";
    inputEstadoProvincia.value = "";
    inputPais.value = "";
    contenedorErroresDirecciones.innerHTML = "";
}