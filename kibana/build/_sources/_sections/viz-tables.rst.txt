==============================================
Kibana: Tablas, Ejemplo
==============================================

.. image:: https://panchoman.s3-sa-east-1.amazonaws.com/table-viz-icon.png
    :width: 80

**Data:** Factor de Emisión (Promedio Mensual) para la red eléctrica en Chile, disponible en el portal \\"Minería Abierta\\":
    - http://energiaabierta.cl/visualizaciones/factor-de-emision-sic-sing/
    - http://datos.energiaabierta.cl/dataviews/245974/factor-de-emision-promedio-mensual/
    - http://cne.cloudapi.junar.com/api/v2/datastreams/FACTO-DE-EMISI-PROME-MENSU/data.ajson/?auth_key=YOUR_API_KEY&limit=50&


Requisitos
---------------

1. Haber creado un **índice en Elasticsearch** con la data. Ver: https://panchohumeres.gitlab.io/elastic_man/_sections/fundamentos.html
2. Crear el **\\"Index Pattern\\"** correspondiente en Kibana, ver:
    - **Fundamentos**: :ref:`index_pattern_conceptos`
    - **Crear**: :ref:`crear_index_pattern`

3. Asegurarse que el **\\"Index Pattern\\"** haya sido creado con un **campo de tiempo por defecto**.
    - Ejemplo de lista de campos utilizadas en este ejemplo:
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_index_pattern_field_list_example_factor_emision.png

4. Entender los conceptos fundamentales que definen a una visualización, ver: :doc:`../_sections/visualizaciones`.
5. Haber creado visualización (contenedor), ver: :doc:`../_sections/create-viz`.

Pasos Ejemplo
--------------------

1. **Panel Métricas (\\"Metrics\\"):**

    En este panel se define como se **resume** la data en el **Eje Y**:

    - En **\\"Aggregation\\"** seleccionar **\\"Average\\"** (Promedio). Esta es la agregación que va a ejecutar sobre los **grupos** definidos por **\\"Bucket\\"**.
    - En **\\"Field\\"** seleccionar el campo que contiene la data a resumir, en este caso **\\"factor_emision_avg\\"** equivale al \\"Factor de Emisión Mensual\\" en la data original.
    - Rellenar **\\"Custom Label\\"** con la **etiqueta** de preferencia para el **Eje Y** (en este caso \\"Factor Emisión Promedio (Ton CO2 eq. / MWh\\").

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_example_factor_emision_metrics.png   

2. **Panel Métricas (\\"Buckets\\"):**

    * En este panel se define como se **divide o agrupa** la data en el **Eje X**.
    * En este caso en particular **es una serie de tiempo** (se agrupa con unidades temporales), el **caso más común**.

        - En **\\"Aggregation\\"** seleccionar **\\"Date Histogram\\"** (Histograma definido por unidades de tiempo). 
        - En **\\"Field\\"** seleccionar el campo que contiene data en formato fecha, en este caso **\\"date\\"** , que contiene los meses en formato YYYY-MM (más un residual de Día y Hora configurado a las 12 AM del día 1 por defecto).
        - Definir **intervalo de tiempo** para el histograma en **\\"Minimum Interval\\"**, en este caso **\\"Monthly\\"** para que divida la data en **meses**.
        - Rellenar **\\"Custom Label\\"** con la **etiqueta** de preferencia para el **Eje X** (en este caso \\"Mes\\").

            .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_example_factor_emision_bucket_snippet.png

3. Hacer click en botón \\"Add sub-buckets\\" para agregar un **sub-grupo** o **grupo anidado** (en referencia al grupo definido en paso 2.).

    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_example_viz_add_sub_bucket.png

4. Para este ejemplo, elegir **sub-dividir la serie** de tiempo (**\\"Split Series\\"**):

    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_example_factor_emision_select_bucket_type.png

5. **Panel Sub-Grupos (\\"Split Series\\"):**

    * En este panel se define como se **sub-divide** la data en el **Eje X**.

        - En **\\"Sub aggregation\\"** seleccionar **\\"Terms\\"**, esto va a definir **sub-grupos** en base a los valores únicos presentes en el campo indicado a continuación.
        - En **\\"Field\\"** seleccionar el campo que contiene los **valores únicos que definen los sub-grupos**. En este caso es **\\"year\\"**.
        - **\\"Size\\"** define cuántos sub-grupos se van a mostrar.
        - Rellenar **\\"Custom Label\\"** con la **etiqueta** de preferencia para el **Eje X** (en este caso \\"Año\\").
        - Repetir pasos anteriores (definir un nuevo **\\"Sub bucket\\"**, para el campo **\\"mes\\"**, y **\\"Size\\"** = 12.

            .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_example_factor_emision_table_terms_aggs.png

6. Hacer click en botón **\\"Run\\"** para ver reflejados las agregaciones en la gráfica:

    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_run_viz_button.png

7. Guardar la gráfica, haciendo click en el botón **\\"Save\\"** en la esquina superior izquierda, y definiendo el nombre en el panel de diálogo correspondiente. Luego hacer click en **\\"Confirm Save\\"**:

    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_example_save_viz_factor_emision.png


Resultado
--------------------------------

Tabla que muestra el **Factor de Emisión Mensual**, agrupado por **Fecha, Año, Mes, Sistema** y el **Factor de Emisión Mensual** propiamente tal.
    
    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_example_factor_emision_table_chart.png











