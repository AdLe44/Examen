const XHTTP = new XMLHttpRequest();
let Temp_Registros = [];
let Temp_Generos = [];
let Temp_Direcciones = [];
let Temp_Id_Registro = 0;
let Temp_Id_Direccion = 0;
function llamarProcGeneros(datos, callback){
    XHTTP.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            // Procesar la respuesta del archivo PHP
            if(!this.response) {
                console.error("No se obtubo respuesta del servicio");
                return false;
            }
            let respuestaNoTratada = JSON.parse(this.response);
            if(!respuestaNoTratada.Retorno) {
                console.error("No se obtubo respuesta del servicio");
                return false;
            }
            let respuestaTratada = JSON.parse(respuestaNoTratada.Retorno);
            if(!respuestaTratada.Data) {
                console.error(respuestaTratada.Message);
                return false;
            }
            let dataTratada = JSON.parse(respuestaTratada.Data);
            return callback(dataTratada);
        }
    };
    XHTTP.open("POST", "../config/backend/generos.back.php", true);
    XHTTP.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    XHTTP.send(normalizarDatos(datos));
}
function llamarProcDirecciones(datos, callback){
    XHTTP.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            // Procesar la respuesta del archivo PHP
            if(!this.response) {
                console.error("No se obtubo respuesta del servicio");
                return false;
            }
            let respuestaNoTratada = JSON.parse(this.response);
            if(!respuestaNoTratada.Retorno) {
                console.error("No se obtubo respuesta del servicio");
                return false;
            }
            let respuestaTratada = JSON.parse(respuestaNoTratada.Retorno);
            if(!respuestaTratada.Data) {
                console.error(respuestaTratada.Message);
                return false;
            }
            let dataTratada = JSON.parse(respuestaTratada.Data);
            return callback(dataTratada);
        }
    };
    XHTTP.open("POST", "../config/backend/direcciones.back.php", true);
    XHTTP.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    XHTTP.send(normalizarDatos(datos));
}
function llamarProcIndividuos(datos, callback){
    XHTTP.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            if(!this.response) {
                console.error("No se obtubo respuesta del servicio");
                return callback(false, "No se obtubo respuesta del servicio");
            }
            let respuestaNoTratada = JSON.parse(this.response);
            if(!respuestaNoTratada.Retorno) {
                console.error("No se obtubo respuesta del servicio");
                return callback(false, "No se obtubo el retorno en respuesta del servicio");
            }
            let respuestaTratada = JSON.parse(respuestaNoTratada.Retorno);
            if(!respuestaTratada.Data) {
                console.error(respuestaTratada.Message);
                return callback(false, respuestaTratada.Message);
            }
            if(typeof respuestaTratada.Data == 'string'){
                let dataTratada = JSON.parse(respuestaTratada.Data);
                dataTratada.map((x)=>{
                    x.Direccion = JSON.parse(x.Direccion);
                    x.Genero = JSON.parse(x.Genero);
                });
                return callback(true, dataTratada);
            } else if(typeof respuestaTratada.Data == 'object'){
                return callback(true, null);
            } else {
                console.error("La respuesta no puede ser tratada");
                return callback(false, "La respuesta no puede ser tratada");
            }
        }
    };
    XHTTP.open("POST", "../config/backend/individuos.back.php", true);
    XHTTP.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    XHTTP.send(normalizarDatos(datos));
}
function normalizarDatos(datos){
    return Object.keys(datos).map(function(key) {
        return encodeURIComponent(key) + '=' + encodeURIComponent(datos[key]);
    }).join('&');
}
function agregarRegistro(){
    let inputNombre = document.getElementById("Nombre_Acc");
    let inputEdad = document.getElementById("Edad_Acc");
    let inputGenero = document.getElementById("Genero_Acc");
    let inputSalario = document.getElementById("Salario_Acc");
    if(Temp_Id_Direccion > 0 && inputGenero.value > 0 && Temp_Id_Registro == 0){
        let datos = {
            ID: null,
            NOMBRE: inputNombre.value,
            EDAD: parseInt(inputEdad.value),
            DIRECCION: Temp_Id_Direccion,
            GENERO: inputGenero.value,
            SALARIO: inputSalario.value,
            OPCION: "CREATE"
        };
        llamarProcIndividuos(datos,(estado, retorno)=>{
            if(estado){
                llenarTablaIndividuos();
            } else{
                let contenedorErrores = document.getElementById("contenedor_errores");
                contenedorErrores.innerHTML = '<div class="alert alert-danger" role="alert">'+retorno+'</div>';
            }
        });
    }else if(Temp_Id_Direccion == 0){
        let contenedorErrores = document.getElementById("contenedor_errores");
        contenedorErrores.innerHTML = '<div class="alert alert-warning" role="alert"><i class="fa-solid fa-triangle-exclamation"></i> No se ha seleccionado una dirección.</div>';
    }else if(inputGenero.value == 0){
        let contenedorErrores = document.getElementById("contenedor_errores");
        contenedorErrores.innerHTML = '<div class="alert alert-warning" role="alert"><i class="fa-solid fa-triangle-exclamation"></i> No se ha seleccionado un genero.</div>';
    }else if(Temp_Id_Registro > 0){
        let contenedorErrores = document.getElementById("contenedor_errores");
        contenedorErrores.innerHTML = '<div class="alert alert-warning" role="alert"><i class="fa-solid fa-triangle-exclamation"></i> No se puede agregar un registro seleccionado en la lista.</div>';
    }
}
function editarRegistro(){
    let inputNombre = document.getElementById("Nombre_Acc");
    let inputEdad = document.getElementById("Edad_Acc");
    let inputGenero = document.getElementById("Genero_Acc");
    let inputSalario = document.getElementById("Salario_Acc");
    if(Temp_Id_Direccion > 0 && inputGenero.value > 0 && Temp_Id_Registro > 0){
        let datos = {
            ID: Temp_Id_Registro,
            NOMBRE: inputNombre.value,
            EDAD: parseInt(inputEdad.value),
            DIRECCION: Temp_Id_Direccion,
            GENERO: inputGenero.value,
            SALARIO: inputSalario.value,
            OPCION: "UPDATE"
        };
        llamarProcIndividuos(datos,(estado, retorno)=>{
            if(estado){
                llenarTablaIndividuos();
            } else{
                let contenedorErrores = document.getElementById("contenedor_errores");
                contenedorErrores.innerHTML = '<div class="alert alert-danger" role="alert">'+retorno+'</div>';
            }
        });
    }else if(Temp_Id_Direccion == 0){
        let contenedorErrores = document.getElementById("contenedor_errores");
        contenedorErrores.innerHTML = '<div class="alert alert-warning" role="alert"><i class="fa-solid fa-triangle-exclamation"></i> No se ha seleccionado una dirección.</div>';
    }else if(inputGenero.value == 0){
        let contenedorErrores = document.getElementById("contenedor_errores");
        contenedorErrores.innerHTML = '<div class="alert alert-warning" role="alert"><i class="fa-solid fa-triangle-exclamation"></i> No se ha seleccionado un genero.</div>';
    }else if(Temp_Id_Registro == 0){
        let contenedorErrores = document.getElementById("contenedor_errores");
        contenedorErrores.innerHTML = '<div class="alert alert-warning" role="alert"><i class="fa-solid fa-triangle-exclamation"></i> No se ha seleccionado un usuario de la lista.</div>';
    }
}
function eliminarRegistro(){
    if(confirm('Esta por borrar el registro número: '+Temp_Id_Registro)){
        if(Temp_Id_Registro > 0){
            let datos = {
                ID: Temp_Id_Registro,
                NOMBRE: null,
                EDAD: null,
                DIRECCION: null,
                GENERO: null,
                SALARIO: null,
                OPCION: "DELETE"
            };
            llamarProcIndividuos(datos,(estado, retorno)=>{
                if(estado){
                    llenarTablaIndividuos();
                } else{
                    let contenedorErrores = document.getElementById("contenedor_errores");
                    contenedorErrores.innerHTML = '<div class="alert alert-danger" role="alert">'+retorno+'</div>';
                }
            });
        }else if(Temp_Id_Registro == 0){
            let contenedorErrores = document.getElementById("contenedor_errores");
            contenedorErrores.innerHTML = '<div class="alert alert-warning" role="alert"><i class="fa-solid fa-triangle-exclamation"></i> No se ha seleccionado un usuario de la lista.</div>';
        }
    }
}
function llenarTablaIndividuos(){
    limpiarPantalla();
    let tablaBody = document.querySelector("#tabla_registros_individuos tbody");
    tablaBody.innerHTML = "";
    let datos = {
        ID: null,
        NOMBRE: null,
        EDAD: null,
        DIRECCION: null,
        GENERO: null,
        SALARIO: null,
        OPCION: "READ"
    };
    llamarProcIndividuos(datos,(estado, retorno)=>{
        if(estado){
            Temp_Registros = retorno;
            let totalSalario = 0,
                salarios = [],
                countSalarios = 0,
                promedioSalarioGeneral = 0;
            retorno.forEach(element => {
                let row = document.createElement('tr');
                row.setAttribute('id', 'row_'+element.Id);
                row.onclick = function() {
                    selectElement(element.Id);
                };
                row.innerHTML = '<td>' + element.Id + '</td>' +
                                '<td>' + element.Nombre + '</td>' +
                                '<td>' + element.Edad + " Años" + '</td>' +
                                '<td>' + element.Direccion.Nombre_Calle + '</td>' +
                                '<td>' + element.Genero.Nombre + '</td>' +
                                '<td>' + "$" + element.Salario.toFixed(2) + '</td>';
                tablaBody.appendChild(row);
                salarios.push(parseFloat(element.Salario.toFixed(2)));
            });
            countSalarios = salarios.length;
            salarios.forEach(x=>{
                totalSalario += x;
            });
            promedioSalarioGeneral = totalSalario / countSalarios;
            document.querySelector("#Show_Total_Salarios").innerHTML = "$"+totalSalario.toFixed(2);
            document.querySelector("#Show_Salario_Promedio_General").innerHTML = "$"+promedioSalarioGeneral.toFixed(2);
            let tablaRegistros = document.getElementById("card_tabla_registros");
            let tablaTotales = document.getElementById("card_tabla_totales");
            tablaRegistros.style.display = "block";
            if(countSalarios > 0) tablaTotales.style.display = "block";
        }
    });
}
function selectElement(Id){
    let inputNombre = document.getElementById("Nombre_Acc");
    let inputEdad = document.getElementById("Edad_Acc");
    let inputDireccion = document.getElementById("Direccion_Acc");
    let inputGenero = document.getElementById("Genero_Acc");
    let inputSalario = document.getElementById("Salario_Acc");
    let row_select = document.getElementById('row_'+Id);
    let tablaBody = document.querySelector("#tabla_registros_individuos tbody");
    let trlist = tablaBody.querySelectorAll('tr');
    for(const element of trlist){
        element.classList.remove("table-active");
    }
    row_select.className = "table-active";
    Temp_Registros.forEach(element => {
        if(element.Id == Id){
            Temp_Id_Registro = element.Id;
            inputNombre.value = element.Nombre;
            inputEdad.value = element.Edad;
            Temp_Id_Direccion = element.Direccion.Id;
            inputDireccion.value = element.Direccion.Nombre_Calle+
            ' #'+element.Direccion.Numero_Exterior+
            ', '+element.Direccion.Colonia_Barrio+
            ', '+element.Direccion.Ciudad_Localidad+
            ', '+element.Direccion.Estado_Provincia+
            ', '+element.Direccion.Pais;
            inputGenero.value = element.Genero.Id;
            inputSalario.value = element.Salario;
        }
    });
}
function limpiarPantalla(){
    let inputNombre = document.getElementById("Nombre_Acc");
    let inputEdad = document.getElementById("Edad_Acc");
    let inputDireccion = document.getElementById("Direccion_Acc");
    let inputGenero = document.getElementById("Genero_Acc");
    let inputSalario = document.getElementById("Salario_Acc");
    let tablaRegistros = document.getElementById("card_tabla_registros");
    let tablaTotales = document.getElementById("card_tabla_totales");
    let contenedorErrores = document.getElementById("contenedor_errores");
    contenedorErrores.innerHTML = '';
    inputNombre.value = "";
    inputEdad.value = "";
    inputDireccion.value = "";
    inputGenero.value = 0;
    inputSalario.value = "";
    tablaRegistros.style.display = "none";
    tablaTotales.style.display = "none";
    Temp_Registros = [];
    Temp_Generos = [];
    Temp_Direcciones = [];
    Temp_Id_Registro = 0;
    Temp_Id_Direccion = 0;
}
function llenarGeneros(){
    let datos = {
        ID: null,
        NOMBRE: null,
        DESCRIPCION: null,
        OPCION: "READ"
    };
    llamarProcGeneros(datos,(generos)=>{
        let inputGenero = document.getElementById("Genero_Acc");
        inputGenero.innerHTML = '<option selected value=0>Seleccionar genero...</option>';
        if(generos){
            Temp_Generos = generos;
            generos.forEach(element => {
                inputGenero.innerHTML += '<option value="'+element.Id+'">' + element.Nombre + '</option>';
            });
        }
    })
}
llenarGeneros();