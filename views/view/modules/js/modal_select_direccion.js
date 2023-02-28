function llenarDirecciones(){
    let listaDirecciones = document.getElementById("lista_direcciones");
    listaDirecciones.innerHTML = "";
    let datos = {
        ID: null,
        NOMBRE_CALLE: null,
        NUMERO_EXTERIOR: null,
        NUMERO_INTERIOR: null,
        COLONIA_BARRIO: null,
        CODIGO_POSTAL: null,
        CIUDAD_LOCALIDAD: null,
        ESTADO_PROVINCIA: null,
        PAIS: null,
        OPCION: "READ"
    };
    llamarProcDirecciones(datos, (retorno)=>{
        if(retorno){
            Temp_Direcciones = retorno;
            retorno.forEach(element => {
                let li = document.createElement('li');
                li.setAttribute('id', 'li_'+element.Id);
                li.setAttribute('data-bs-dismiss', 'modal');
                li.className = "list-group-item";
                li.onclick = function() {
                    selectList(element.Id);
                };
                li.innerHTML = element.Nombre_Calle+
                                ' #'+element.Numero_Exterior+
                                ', '+element.Colonia_Barrio+
                                ', '+element.Ciudad_Localidad+
                                ', '+element.Estado_Provincia+
                                ', '+element.Pais;
                listaDirecciones.appendChild(li);
            });
        }
    })
}
function selectList(Id){
    console.log(Id);
    let listaDirecciones = document.getElementById("lista_direcciones");
    let inputDireccion = document.getElementById("Direccion_Acc");
    let li_select = document.getElementById('li_'+Id);
    let list = listaDirecciones.querySelectorAll('li');/* active */
    for(const element of list){
        element.classList.remove("active");
    }
    li_select.classList.add("active");
    Temp_Direcciones.forEach(element => {
        if(element.Id == Id){
            Temp_Id_Direccion = element.Id;
            inputDireccion.value = element.Nombre_Calle+
            ' #'+element.Numero_Exterior+
            ', '+element.Colonia_Barrio+
            ', '+element.Ciudad_Localidad+
            ', '+element.Estado_Provincia+
            ', '+element.Pais;
        }
    });
}