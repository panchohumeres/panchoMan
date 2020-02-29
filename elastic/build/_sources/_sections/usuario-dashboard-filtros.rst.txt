==============================================
Kibana: Filtros para Dashboards, Nivel Usuario
==============================================

Filtros para Dashboards:
    * En esta sección se indica como filtrar el contenido que se despliega en los Dashboards.
    * Los ejemplos están hechos en base al Dashboard mostrado en esta URL: https://d3bhn81c8dm26x.cloudfront.net/
    * Dicho ejemplo es un demo que muestra estadísticas de carga de datasets al Portal de Datos Abiertos del Gobierno de Chile: datos.gob.cl

---------------------------------------------------------------------------------------------------------------------------------------------

**Filtro General de Tiempo**:
El Dashboard como un todo **va a contener los datos filtrados en el filtro general de tiempo**. A este filtro se accede en la barra superior derecha.

----------------------------------------------

    * Se pueden introducir filtros **"relativos"** de tiempo (i.e. La hora actual - X segundos, minutos, horas, días, meses, años, etc.).
    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana-filtros-gen-1.png
            :alt: filtro_gen_1   
    * También se pueden introducir rangos de fechas exactas, o **"absolutas"**.
    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana-filtros-gen-2.png
            :alt: filtro_gen_2    
    * **OJO!:** Los datos que queden excluido por este filtro general **NO SE MOSTRARÁN EN EL DASHBOARD, NI SERÁN REEMPLAZADOS POR FILTROS ESPECÍFICOS".
    * **OJO!:** Apretar botón **"Update"** para aplicar el cambio de filtro.
    * En panel de **"Quick select"** se puede acceder a filtros de fecha generales ingresados anteriormente por el mismo usuario.
    
----------------------------------------------

Pasos para filtrar contenido de un Dashboard:
Ejemplo filtro de **Campo de Texo**:

----------------------------------------------

    1. Apretar **"+ Add Filter"** en barra o espacio superior, al lado del botón de configuración (con forma de tuerca).
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/add_filter_kibana.png
            :alt: add_filter
    2. Se va a desplegar un panel que permite variados filtros por campo, se mostrarán dos ejemplos (campos de texto y numéricos):
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/panel_add_filter_kibana.png
            :alt: add_filter
    3. En este primer ejemplo aplicaremos un filtro sobre un campo de texto, en este el campo **"inst"**, que contiene nombres de instituciones donde se han publicado datasets:
        * Primero se debe seleccionar el campo (Menú **Field**), **OJO: En los campos de texto debe ser el campo con extensión .keyword**. Para los campos de texto Kibana crea un campo duplicado con extensión **.keyword**, que es navegable por la interfaz. Elegir siempre este campo en los casos de campos de texto.
        * Luego se debe seleccionar un operador del Menú **Operator**. Son 6:
            1. **is** = coincidencia exacta con un término
            2. **is not** = campo no contiene el término
            3. **is one of** = contiene algunos de los términos de una lista especificada
            4. **is not one of** = **NO** contiene los términos especificados en una lista
            4. **exists** = elige registros que no sean nulos en este campo
            5. **does no exist** = registros nulos para este campo
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_keyword_filter_1.png
            :alt: keyword_filter_1
    4. En este ejemplo, aplicaremos filtro **N°3, "is one of"**.
        * Luego elegimos libremente de la lista de valores desplegadas en el **Menú "Values"**, la cantidad de valores únicos que deseamos agregar a lista para el filtro.
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_keyword_filter_2.png
            :alt: keyword_filter_2
        * En este ejemplo, se han agregado dos valores **"Comisión Nacional de Energía"** y **"Municipalidad de Puente Alto"**.
        * Esto significa, que para el **campo "inst"**, **SÓLO va a SELECCIONAR** los registros que contengan los valores mencionados anteriormente.

----------------------------------------------

Pasos para filtrar contenido de un Dashboard:
Ejemplo filtro de **Campo Numérico**:

----------------------------------------------

    1. En este caso elegimos un Campo Numérico, como **"mes"** en este ejemplo, que ha sido extraído de la fecha de carga de un dataset, y convertido a valor numérico.
        * Tenemos **dos nuevos posibles operadores: "is between", "is not between".
        * **"is between"** = rango de números entre los que van a caer valores del campo seleccionado
        * **"is not between"** = mismo caso anterio, pero **EXCLUYENDO** un rango de números para los valores del campo seleccionado
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_numeric_filter_1.png
            :alt: numeric_filter_1
    2. En este ejemplo, usamos el **operador "is between"**, para seleccionar un rango (entre meses Agosto y Noviembre p.ej.):
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_numeric_filter_2.png
            :alt: numeric_filter_2

----------------------------------------------

Pasos para filtrar contenido de un Dashboard:
Ejemplo filtro de **Campo de Fecha**:

----------------------------------------------

    1. Mismo caso anterior, sólo que en este caso hay que **introducir valores en formato ""datetime"", según especificación de Elasticsearch**:
        * Más información en: https://www.elastic.co/guide/en/elasticsearch/reference/7.2/common-options.html#date-math
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana-date-filter.png
            :alt: date_filter        