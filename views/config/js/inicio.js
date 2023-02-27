const XHTTP = new XMLHttpRequest();
function llamarProcGeneros(){
    XHTTP.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            // Procesar la respuesta del archivo PHP
            if(!this.response) return console.error("No se obtubo respuesta del servicio");
            let respuestaNoTratada = JSON.parse(this.response);
            if(!respuestaNoTratada.Retorno) return console.error("No se obtubo respuesta del servicio");
            let respuestaTratada = JSON.parse(respuestaNoTratada.Retorno);
            if(!respuestaTratada.Data) return console.error(respuestaTratada.Message);
            let dataTratada = JSON.parse(respuestaTratada.Data);
            console.log(dataTratada);
        }
    };
    XHTTP.open("POST", "../config/backend/generos.back.php", true);
    XHTTP.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    let datos = {
        ID: null,
        NOMBRE: null,
        DESCRIPCION: null,
        OPCION: "READ"
    };
    XHTTP.send(normalizarDatos(datos));
}
function llamarProcIndividuos(){
    XHTTP.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            // Procesar la respuesta del archivo PHP
            if(!this.response) return console.error("No se obtubo respuesta del servicio");
            let respuestaNoTratada = JSON.parse(this.response);
            if(!respuestaNoTratada.Retorno) return console.error("No se obtubo respuesta del servicio");
            let respuestaTratada = JSON.parse(respuestaNoTratada.Retorno);
            if(!respuestaTratada.Data) return console.error(respuestaTratada.Message);
            let dataTratada = JSON.parse(respuestaTratada.Data);
            console.log(dataTratada);
        }
    };
    XHTTP.open("POST", "../config/backend/individuos.back.php", true);
    XHTTP.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    let datos = {
        ID: null,
        NOMBRE: null,
        EDAD: null,
        DIRECCION: null,
        GENERO: null,
        SALARIO: null,
        OPCION: "READ"
    };
    XHTTP.send(normalizarDatos(datos));
}
function normalizarDatos(datos){
    return Object.keys(datos).map(function(key) {
        return encodeURIComponent(key) + '=' + encodeURIComponent(datos[key]);
    }).join('&');
}