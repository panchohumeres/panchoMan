==============================================
Kibana: Exportar e Importar Data
==============================================

Requisitos
------------------------

* Entender los fundamentos sobre **índices** y **documentos** en **Elasticsearch**. 
    - Ver: https://panchohumeres.gitlab.io/elastic_man/_sections/fundamentos.html
* Tener un **\\"Index Pattern\\"** en base a cual se quiere crear la visualización. Referencias sobre \\"Index Patterns\\":
    - **Fundamentos**: :ref:`index_pattern_conceptos`
    - **Crear**: :ref:`crear_index_pattern`
* Haber **creado visualizaciones** del tipo **\\"Tabla\\"**. Ver: 
    - :doc:`../_sections/visualizaciones`
    - :doc:`../_sections/create-viz`
    - :doc:`../_sections/viz-tables`

* Entender los conceptos y como manipular los filtros de Tiempo, ver: :doc:`../_sections/usuario-dashboard-filtros`
* Definir un **filtro de tiempo** lo **suficientemente amplio** como para contener la data que se desea visualizar.

Exportar Data
---------------------------------

    1. Elegir una visualización de tipo **\\"Tabla\\"**, ya sea el menú de visualizaciones o a través de un dashboard.
    2. Apretar alguno de los botones del Menú **\\"Export\\"** en costado inferior.

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_export_bar.png

    3. Botón **\\"Raw\\"** va a generar como resultado un archivo **.csv** sin formatear la data (p.ej. los campos de fecha están expresados en UNIX Timestamp, o los números enteros no tienen separadores de miles):

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_export_raw.png

    4. Botón **\\"Formatted\\"** va a generar como resultado un archivo **.csv** en formato comprensible por humanos (p.ej. los campos de fecha están expresados en YYYY-MM-DD, o los números enteros tienen separadores de miles):

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_export_formatted.png
        

Importar Data
----------------

    1. Hacer click en botón **\\"Machine Learning\\"** en menú de la izquierda.

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_machine_learning_module.png

    2. En el panel de **\\"Data Visualizer\\"** hacer click en **\\"Upload file\\"** para importar archivo **.csv o .json**.

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_ml_upload_file.png

    3. Kibana **previsualizará** el **contenido** y **propiedades de los campos**:

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_ml_previsualize.png

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_ml_previsualize_2.png

    4. Hacer click en botón **\\"Import\\"** (esquina inferior izquierda):

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_ml_import_data.png

    5. Definir **nombre de índice** al cual se va a importar la data, y hacer click en botón **\\"Import\\"**:

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_ml_import_data_index_name.png

* **Notas:**
    - **NO** se puede **sobreescribir índices existentes**.
    - Kibana **NO** reconocen bien los carácteres latinos (i.e. acentos, ñ, etc.). Se sugiere cambiarlos en la data antes de importarla.
    - Archivos permitidos:
        - **.csv**
        - **.tsv**
        - **.Json**
    - Tamaño permitido: Hasta **100 MB**.
