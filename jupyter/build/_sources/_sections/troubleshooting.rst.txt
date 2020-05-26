=====================================
Jupyter Notebook: Troubleshooting
=====================================

Problemas comunes en Jupyter Notebook, y soluciónes

------------------------------------------------------

.. _kernel_not_connected:

Kernel \\"Not Connected\\" en Servidor remoto
------------------------------------------------

**Referencias**:
    - https://github.com/jupyter/notebook/issues/4757
    - https://github.com/jupyter/notebook/issues/2664
    - https://github.com/jupyter/notebook/issues/625
    - https://github.com/jupyter/jupyter/issues/79
    - https://github.com/jupyter/notebook/issues/5024

**Problema:** Notebook en **servidor remoto NO** se conecta. Las otras funciones de Jupyter funcionan correctamente (crear notebooks o carpetas, subir archivos, etc.).

.. image:: https://panchoman.s3-sa-east-1.amazonaws.com/jupyter-not-connected.png
    :alt: jupyter-not-connected

**Mensajes de Error**:
    - En Docker:
        .. code-block:: bash

            [W 06:57:35.645 NotebookApp] 404 GET /nbextensions/widgets/notebook/js/extension.js?v=20200327084013 (172.18.0.1) 1.76ms referer=https://hola.com/notebooks/Untitled13.ipynb?kernel_name=python3

            [W 06:44:04.603 NotebookApp] 403 POST /GponForm/diag_Form?images/ (172.18.0.13): '_xsrf' argument missing from POST

            [W 06:37:35.963 NotebookApp] 404 GET /Report.docx (172.18.0.13) 2.05ms referer=None

            [W 06:30:29.023 NotebookApp] Replacing stale connection: 12345:7789

**Solución:**
    - Correr servidor Jupyter con **opción** :code:`NotebookApp.allow_origin='*'`. Ver :ref:`NotebookApp.allow_origin`: y :ref:`editar_config_linea_comando`:.
    - En caso de estar usando Jupyter en **Docker-compose** detrás de un **\\"reverse_proxy\\"** **NGINX** y **SSL**, se recomienda seguir la configuración detallada acá: :ref:`nginx.conf_reverse_proxy_nginx_docker_compose`:
    - En caso de tener protegido el servidor Jupyter con **SSL / TSL**, **NO olvidar** consultar el dominio o URL con **\\"https:\\"**.