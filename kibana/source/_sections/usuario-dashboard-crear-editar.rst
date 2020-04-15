==============================================
Kibana: Crear y Editar Dashboards
==============================================

Requisitos
------------------------

* Tener un **\\"Index Pattern\\"** en base a cual se quiere crear la visualización. Referencias sobre \\"Index Patterns\\":
    - **Fundamentos**: :ref:`index_pattern_conceptos`
    - **Crear**: :ref:`crear_index_pattern`
* Haber **creado visualizaciones** para agregar al Dashboard. Ver: 
    - :doc:`../_sections/visualizaciones`
    - :doc:`../_sections/create-viz`
    - :doc:`../_sections/viz-linechart`

* Entender los conceptos y como manipular los filtros de Tiempo, ver: :doc:`../_sections/usuario-dashboard-filtros`
* Definir un **filtro de tiempo** lo **suficientemente amplio** como para contener la data que se desea visualizar.

Crear Dashboard
---------------------------------

    1. Apretar botón dashboards en barra lateral izquierda:

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/icono-dashboard-kibana.png
            :alt: icono-dashboard

    2. Se despliega el listado de los Dashboards:

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/dahsboard-listados.png
            :alt: listado-dashboard

    4. Se despliega el listado de los Dashboards:

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/dahsboard-listados.png

    5. Hacer click en el botón **\\"Create new dashboard\\"**:

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_create_new_dashboard_button.png
    
    6. Hacer click en **\\"Add\\"** en la barra superior izquierda para agregar visualizaciones al Dashboard:
        
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_add_viz_button_dashboard.png

    7. Se desplegará listado de visualizaciones disponibles. Se puede utilizar la barra de búsqueda para filtrar el listado por nombre. Hacer click en las visualizaciones para agregar al Dashboard.
        
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_add_viz_dashboard_panel.png
    
    8. Se desplegará el panel del Dashboard en modo \\"borrador\\", con las **visualizaciones** (dentro de **contenedores o marcos**) que se hayan agregado. Algunas operaciones básicas que se pueden ejecutar:
        
        - En la **esquina inferior derecha** de cada **visualización** se puede **modificar el tamaño de ésta** (más bien de su marco contenedor).
        - En la **esquina superior derecha** de cada **visualización** (ícono tuerca), se puede ir directamente a **editar la visualización en el origen**.
        
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_dashboard_chart_draft.png
    
    9. Hacer click en **\\"Save\\" (menú superior izquierdo, sobre el filtro de tiempo), para desplegar el panel de **guardar Dashboard**. Para **volver a editar** (en modo borrador), hacer click en **\\Edit\\**:
        

Resultado
----------------

    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_dashboard_chart_result.png
