=====================================
Jupyter Notebooks: Configuración
=====================================

**Referencias:** 
    - https://jupyter.readthedocs.io/en/latest/projects/config.html
    - https://jupyter-notebook.readthedocs.io/en/stable/config_overview.html

Introducción
--------------------------------------------------------------------------

    * Las **aplicaciones** Jupyter tienen un sistema de **configuración común**, y un **directorio** de configuración común.
    * Por defecto el **directorio** de configuración es :code:`~/.jupyter`.
    * **Kernels**: Si es que los kernels usan archivos de configuración propios, éstos comúnmente estarán organizados en directorios separados para cada Kernel. Por ejemplo, el kernel de Ipython busca archivos en su propio directorio de configuración: :ref:`directorio_ipython`.

Archivo \\"Ipython config\\" (Configuración)
-----------------------------------------------------

    * Para generar un archivo de configuración con valores por defecto, ejecutar: :code:`jupyter {application} --generate-config`.
    * El archivo generado se va a llamar: :code:`jupyter_application_config.py`.
    * Este archivo tiene todas las opciones comentadas (deshabilitadas).
    * Editando este archivo se pueden configurar atributos como: :code:`c.NotebookApp.port = 8754`.
    * Para agregar configuraciones se pueden usar comandos utilizados con **listas** en python, como :code:`append, extend, prepend(), add, update`. Por ejemplo:
        :code:`c.TemplateExporter.template_path.append('./templates')`.

.. _editar_config_linea_comando:

Configurar Opciones desde la Línea de Comandos
-----------------------------------------------------

    * Las opciones también pueden ser configuradas desde la línea de comandos linux, p.ej.: 
        :code:`jupyter notebook --NotebookApp.port=8754`
    * Para ver las opciones abreviadas:

            .. code-block:: bash

                jupyter {application} --help       # Just the short options
                jupyter {application} --help-all   # Includes options without short names

Sub-secciones:
===================

.. toctree::
   :maxdepth: 2
   :caption: Sub-secciones:

   1. Opciones Configuración  <../_sections/config-options>
   2. Directorio Ipython <../_sections/ipython-config>