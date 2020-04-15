==============================================
Kibana: Index Patterns
==============================================

.. _index_pattern_conceptos:

Conceptos
--------------

* Para poder crear visualizaciones para un(os) índice(s) (**\\"index\\"**) de Elasticsearch, en particular, **primero** es necesario crear un **\\"index pattern\\"**, una entidad que hace disponibles los datos de un(os) índice(s) para generar visualizaciones en kibana.
* Se sugiere **primero revisar los fundamentos de Elasticsearch** (conceptos de **\\"documentos\\" e \\"índices\\"**):
    - https://panchohumeres.gitlab.io/elastic_man/_sections/fundamentos.html


.. _crear_index_pattern:

Crear \\"Index Pattern\\"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Pasos para crear un **\\"index pattern\\"**:
    1. Hacer click en el botón de **\\"settings\\"** (o configuración) de Kibana (esquina inferior izquierda):
        
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/settings_icon_kibana.png
            :alt: settings-button 

    2. Hacer click en el botón **\\"Create index pattern\\"**:
        
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/create_index_pattern_button.png
            :alt: create-index-pattern-button

    3. Se va a desplegar un listado de los **índices disponibles**:
        
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_panel_choose_index.png
            :alt: create-index-pattern-index-list


    4. Escribir el nombre del **índice** en la casilla **\\"Index pattern\\"**, tiene que **coincidir exactamente**. 

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_create_index_pattern_filling_box_1.png
            :alt: create-index-pattern-fill-box

        Alternativamente, usar el wildcard **\\"*\\"**, para incluir **cualquier índice que coincida parcialmente con el texto**:

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_create_index_pattern_filling_box_2.png
            :alt: create-index-pattern-fill-box-*

        **Más referencias al respecto:**
            - https://www.elastic.co/guide/en/kibana/current/tutorial-define-index.html

    5. Luego hacer click en **\\"Next Step\\"**.

    6. **Si es que Kibana detecta un campo con data temporal** en el(los) índice(s) incluido en el **\\"index pattern\\"**, seleccionar el **campo** que se desea utiliza como **filtro de tiempo por defecto:**

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_index_pattern_select_time_field.png
            :alt: create-index-pattern-select-time-field

    7. Hacker click en el botón **\\"Create index pattern\\"** para finalizar:
        
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/create_index_pattern_widget_kibana.png
            :alt: create-index-pattern-final

.. _index_pattern_listado_de_campos:

Listado de Campos
---------------------

* Ya sea al **finalizar la creación de un \\"Index Pattern\\"**, o a través del menú **\\"Settings\\"---->\\"Index Patterns\\"**, se puede acceder al listado de campos y otros parámetros de referencia sobre un **\\"Index Pattern\\"**:

    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_index_pattern_fields_list.png
        :alt: create-index-pattern-fields-list

* Este listado contiene el listado de **\\Index Patterns\\**, los **campos disponibles**, y sus **características**.
* Entre las opciones que permite este panel, están:
    - **Borrar** un \\"Index Pattern\\":
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_delete_index_pattern_icon.png
            :alt: delete-index-pattern  

    - **Actualizar o refrescar** un \\"Index Pattern\\", paso necesario cuando ha cambiado la data de un índice sustancialmente (nuevo campo, data-type del campo, etc.):
        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/kibana_reload_index_pattern_icon.png
            :alt: delete-index-pattern  