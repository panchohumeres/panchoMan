=====================================
Docker: PS
=====================================

Comandos y fórmulas para listar contenedores

----------------------------------------------

**Referencias:**
    https://docs.docker.com/engine/reference/commandline/ps/

Listar contenedores
---------------------

.. code-block:: bash

    #LISTAR CONTENEDORES ACTIVOS
    docker ps

    #LISTAR CONTENEDORES ACTIVOS Y NO-ACTIVOS
    docker ps -a
    #ó
    docker ps --all


Filtros
-------------------

**Sintaxis**:
    - :code:`docker ps -f "key=value"`

Ejemplo:
    - :code:`docker ps --filter "label=color"`

Diccionario de Opciones:

    +---------+-------------------------------------------------------------------------+
    | Key     |        Descripción                                                      |
    +=========+=========================================================================+
    | id      | ID del Contenedor                                                       |
    +---------+-------------------------------------------------------------------------+
    | name    | Nombre del Contenedor                                                   |
    +---------+-------------------------------------------------------------------------+
    | exited  | Número entero representando el código de \\"exit\\" del contenedor.     |
    +---------+-------------------------------------------------------------------------+
    | status  |  Uno de code:`restarting, running, removing, paused, exited, dead`      |
    +---------+-------------------------------------------------------------------------+
    | volume  |  Filtra contenedores activos que hayan montado un determinado volumen   |
    +---------+-------------------------------------------------------------------------+
    | network |  Filtra contenedores activos conectados a una red en particular         |
    +---------+-------------------------------------------------------------------------+


Mostrar uso espacio en disco por contenedores
----------------------------------------------

.. code-block:: bash

    docker ps -s

    #RESULTADO ESPERADO:
    CONTAINER ID   IMAGE          COMMAND                  CREATED        STATUS       PORTS   NAMES        SIZE                                                                                      SIZE
    e90b8831a4b8   nginx          "/bin/bash -c 'mkdir "   11 weeks ago   Up 4 hours           my_nginx     35.58 kB (virtual 109.2 MB)
    00c6131c5e30   telegraf:1.5   "/entrypoint.sh"         11 weeks ago   Up 11 weeks          my_telegraf  0 B (virtual 209.5 MB)

* **\\"size\\"** es el espacio en disco que ocupa la capa \\"sobreescribible\\".
* **\\"virtual size\\"** es el espacio en disco que ocupa la capa \\"sobreescribible y read-only\\".