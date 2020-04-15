==============================================
Kibana: Visualizaciones
==============================================

.. |line-chart-icon| image:: https://panchoman.s3-sa-east-1.amazonaws.com/line-chart-kibana-icon.png
  :width: 80

.. |table-chart-icon| image:: https://panchoman.s3-sa-east-1.amazonaws.com/table-viz-icon.png
  :width: 80

Fundamentos
----------------------------------

Se sugiere **primero revisar los fundamentos de Elasticsearch** (conceptos de **\\"documentos\\" e \\"índices\\"**):
    - https://panchohumeres.gitlab.io/elastic_man/_sections/fundamentos.html

**Referencias:**
    - https://logz.io/blog/kibana-tutorial-2/

* Todas las visualizaciones en Kibana están basadas en **\\"Agregaciones\\"** ejecutadas por **Elasticsearch** sobre un **índice**:
* Existen **DOS tipos de Agregaciones**:
    * **\\"Buckets\\"** o **Grupos**: Grupos de documentos según ciertas lógicas definidas por documentos. Por ejemplo:
      
      - **\\"Date Histogram\\"**: Grupos según histogramas de fechas (intervalos que definen grupos se eligen entre **segundo, minuto, hora, día, mes, año, etc.**.
      - **\\"Terms\\"**: Definir grupos según **términos únicos** de un determinado campo (p.ej. nombres de Países o Ciudades).

    * **\\"Métricas\\"**: Usadas para calcular un valor para el conjunto de documentos contenidos en cada **\\"Bucket\\"** o **grupo**. Por ejemplo:
      
      - Media (Promedio)
      - Mínimo
      - Máximo
      - Count (contar número de documentos)
      - Desviación Estándar

* Ejemplo:
    Gráfica de Pie que muestra la distribución de cargas de datasets en el portal de Datos Abiertos del Gobierno de Chile (datos.gob.cl), según la Institución que los cargó.

    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/screenshot_pie_kibana.png

    Por ejemplo, el **\\"Servicio Nacional de Aduanas\\"** tiene **1164** datasets (equivalentes a **documentos**), con un **14%** del total de documentos.

    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/zoom_slice_pie_chart_kibana.png

    Ésta gráfica está definida por los siguientes **parámetros**:
      - **Índice:** **\\"ckan\\"**------> el índice donde se están haciendo las operaciones
      - **Buckets:** Grupos generados a partir de **\\"Terms\\"** (palabras únicas), sobre el **Campo** (\\"Fields\\") **\\"inst\\"**.
        
        - **Nota**: \\"keyword\\" es un convencionalismo utilizado para acceder el valor como texto del campo.
      
      - **Métrica \\"Count\\"**, que **cuenta** la cantidad de documentos contenidos en los grupos definidos por **\\"Buckets\\"**.

    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/zoom_params_pie_chart_kibana.png

Crear Visualizaciones
-------------------------

Ver: :doc:`../_sections/create-viz`

Tipos de Visualizaciones
---------------------------

.. table::
   :align: center
   :widths: auto

   +----------------------+-------------------+------------------------------------+
   | |line-chart-icon|    | Gráfica de Líneas | :doc:`../_sections/viz-linechart`  |
   +----------------------+-------------------+------------------------------------+
   | |table-chart-icon|   |    Tablas         |  :doc:`../_sections/viz-tables`    |                       
   +----------------------+-------------------+------------------------------------+


Índice General
------------------

.. toctree::
    :maxdepth: 2
    :caption: Contenidos:

    1. Crear Visualizaciones <../_sections/create-viz>
    2. Gráfica de Líneas  <../_sections/viz-linechart> 
    3. Tablas <../_sections/viz-tables>






    
        








