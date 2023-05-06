# Cambios a Copala 06/05/2023

Se realizaron los siguientes cambios en el proyecto Copala:

- Modificación en la generación de documentos "contrato" para el proyecto CORONADO. Se agregó la cláusula dependiente de financiamiento.

- Modificación en el documento plantilla con las siguientes variables:
    - ${financiada_valoración_medica_titulo}
    - ${financiada_valoración_medica_texto}
    - ${financiada_valoración_medica_titulo_us}
    - ${financiada_valoración_medica_texto_us}

- Modificación en la consulta de contrato word para obtener el campo "tipo_pago_saldo":
    ```php
    public function contrato_word($id_venta)
    {
        return $this->db->select("SELECT a.fecha_terminacion, a.fecha_cierre, a.divisa, f.nombre AS nombre_modelo, b.nombre AS nombre_cliente,a.total,d.costo AS cuota,DAY(a.fecha_cierre) AS dia, DATE_FORMAT(a.fecha_cierre, '%D') AS day, MONTHNAME(a.fecha_cierre) AS month, CASE MONTHNAME(a.fecha_cierre) WHEN 'January' THEN 'Enero' WHEN 'February' THEN 'Febrero' WHEN 'March' THEN 'Marzo' WHEN 'April' THEN 'Abril'  WHEN 'May' THEN 'Mayo' WHEN 'June' THEN 'Junio' WHEN 'July' THEN 'Julio' WHEN 'August' THEN 'Agosto' WHEN 'September' THEN 'Septiembre' WHEN 'October' THEN 'Octubre' WHEN 'November' THEN 'Noviembre' WHEN 'December' THEN 'Diciembre' END AS mes, YEAR(a.fecha_cierre) AS ano, a.referencia, (a.total) AS deposito, f.tipo_casa, f.mcasa, f.mterrazas, (f.mcasa * 10.7639) AS fcasa, (f.mterrazas * 10.7639) AS fterrazas, DAY(a.fecha_licencias) AS dia_licencia, DATE_FORMAT(a.fecha_licencias, '%D') AS dia_licencia_us, MONTHNAME(a.fecha_licencias) AS mes_licencia_us, CASE MONTHNAME(a.fecha_licencias) WHEN 'January' THEN 'Enero' WHEN 'February' THEN 'Febrero' WHEN 'March' THEN 'Marzo' WHEN 'April' THEN 'Abril'  WHEN 'May' THEN 'Mayo' WHEN 'June' THEN 'Junio' WHEN 'July' THEN 'Julio' WHEN 'August' THEN 'Agosto' WHEN 'September' THEN 'Septiembre' WHEN 'October' THEN 'Octubre' WHEN 'November' THEN 'Noviembre' WHEN 'December' THEN 'Diciembre' END AS mes_licencia, YEAR(a.fecha_licencias) AS ano_licencia, DAY(a.fecha_terminacion) AS dia_terminacion, DATE_FORMAT(a.fecha_terminacion, '%D') AS dia_terminacion_us, MONTHNAME(a.fecha_terminacion) AS mes_terminacion_us, CASE MONTHNAME(a.fecha_terminacion) WHEN 'January' THEN 'Enero' WHEN 'February' THEN 'Febrero' WHEN 'March' THEN 'Marzo' WHEN 'April' THEN 'Abril'  WHEN 'May' THEN 'Mayo' WHEN 'June' THEN 'Junio' WHEN 'July' THEN 'Julio' WHEN 'August' THEN 'Agosto' WHEN 'September' THEN 'Septiembre' WHEN 'October' THEN 'Octubre' WHEN 'November' THEN 'Noviembre' WHEN 'December' THEN 'Diciembre' END AS mes_terminacion, YEAR(a.fecha_terminacion) AS ano_terminacion,gc.genero_espaniol,gc.genero_ingles,gc.pronombre, a.tipo_pago_saldo FROM venta a JOIN cliente b ON a.id_cliente = b.id_cliente LEFT JOIN cuotas_venta c ON a.id_venta = c.id_venta LEFT JOIN cuotas d ON c.id_cuotas = d.id_cuotas  JOIN anticipo e ON a.id_venta = e.id_venta JOIN casa f ON a.id_casa = f.id_casa LEFT JOIN genero_clientes gc ON b.genero=gc.id_genero WHERE a.id_venta = :id_venta", array('id_venta' => $id_venta));
	}
- Se agregaron las siguientes líneas dentro de la función "contrato()" en el archivo contratos.php del controlador:
    ```php
    // Validar información de financiamiento para texto en contrato
    /* Declaración de variables */
    $financiada_valoración_medica_titulo = "";
    $financiada_valoración_medica_titulo_us = "";
    $financiada_valoración_medica_texto = "";
    $financiada_valoración_medica_texto_us = "";

    /* Llenado de información */
    if ($contrato[0]['tipo_pago_saldo'] == "Financiamiento") {
        $financiada_valoración_medica_titulo = "EL PROMITENTE COMPRADOR";
        $financiada_valoración_medica_titulo_us = "PROMISSORY BUYER";
        $financiada_valoración_medica_texto = "es consciente y conforme en que tendrá que hacer las valoraciones médicas y dichas valoraciones deberán ser en todo positivas a efecto de que pueda llevarse a cabo la operación de éste contrato de manera financiada además de servir como soporte para la institución del seguro de vida para dicho financiamiento. Para el caso de que las valoraciones médicas aludidas no sean del todo satisfactorias, el depósito constituido será reembolsado en su totalidad dentro de los 45 días hábiles del dictamen médico emitido y el presente contrato quedará sin efecto alguno para las partes.";
        $financiada_valoración_medica_texto_us = "is aware and agrees that will have to go through medical examination and that the results of such medical evaluations shall be all positive in order to be able to take financing according to this agreement and for support before the life insurance company. In case that the medical evaluations are not completely satisfactory, the safety deposit herein evoked will be reimbursed within 45 labor days after the issuance of the medical report and this agreement will be considered non effective between the parties.";
    }
- Dentro de la misma función, se envían los datos vacíos o llenos, dependiendo del tipo de pago, al documento con la siguiente instrucción:
    ```php  
    // Asignar texto en caso de financiamiento
    $document->setValue('financiada_valoración_medica_titulo', mb_strtoupper($financiada_valoración_medica_titulo, 'UTF-8'));
    $document->setValue('financiada_valoración_medica_titulo_us', mb_strtoupper($financiada_valoración_medica_titulo_us, 'UTF-8'));
    $document->setValue('financiada_valoración_medica_texto', $financiada_valoración_medica_texto);
    $document->setValue('financiada_valoración_medica_texto_us', $financiada_valoración_medica_texto_us);
