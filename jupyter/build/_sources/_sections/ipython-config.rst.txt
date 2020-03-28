=====================================
Jupyter Notebooks: Configuración
=====================================

.. _directorio_ipython:

Directorio Ipython
======================
**Referencias**: https://ipython.readthedocs.io/en/latest/config/intro.html#ipythondir

Ipython guarda sus archivos de configuración, historia de comandos y extensiones- por defecto en el directorio :code:`~/.ipython/`.

----------------------------------------------------------------------------------

:code:`IPYTHONDIR`
--------------------------------------------------------------------------

Variable de entorno, cuyo contenido es una ruta o path, que indica donde Ipython va a guardar la data de usuarios. Ipython lo creará si es que no existe.

:code:`--ipython-dir=<path>`
--------------------------------------------------------------------------

Este comando puede usarse para sobreescribir el valor de :code:`IPYTHONDIR` por defecto.

Mostrar valor de :code:`IPYTHONDIR`
-----------------------------------------

* :code:`ipython locate` en Shell Linux.
* :code:`IPython.paths.get_ipython_dir() ` en Python.


