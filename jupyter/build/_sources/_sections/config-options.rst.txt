=====================================
Jupyter Notebooks: Configuración
=====================================

Opciones de Configuración
==============================

.. _NotebookApp.allow_origin:

:code:`NotebookApp.allow_origin`
------------------------------------

    **Referencias:** https://ipython.org/ipython-doc/3/config/options/notebook.html

    * Configura el **\\"Header http\\"** (que dominios o origines pueden acceder al servidor Jupyter).
    * Ver: https://panchohumeres.gitlab.io/http_man/_sections/CORS.html#que-es-cors
    * Valor por defecto : **\\'\\'**.
    * Usar :code:`*` para permitir que cualquier origen acceda al servidor.
    * Tiene precedencia sobre :code:`allow_origin_pat`.
