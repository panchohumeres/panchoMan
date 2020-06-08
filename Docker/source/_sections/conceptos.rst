=====================================
Docker: Conceptos y Aclaraciones
=====================================

Conceptos de Docker y aclaraciones.

----------------------------------------------

Especificar volúmenes en Dockerfile y en mapeo
-------------------------------------------------------

**Referencias:**
    https://forums.docker.com/t/whats-the-difference-between-adding-volume-in-a-dockerfile-and-running-an-image-with-volume/17480/6
    
Tienen exactamente el mismo efecto. Por convención se incluye directorio a ser montado como volumen dentro del contenedor en Dockerfile, como guía para recordar que debe ser mapeado a un volumen externo.

\\"Workdir\\":
---------------
    
* Especifica directorio donde cualquier commando RUN, CMD, ENTRYPOINT, COPY y ADD que siguen en el Dockerfile se ejecutan.
* Si no existe el directorio es creado.
* Puede ser usado múltiples veces en un Dockerfile.
* Si se especifica una ruta relativa, ésta será relativa en relación a la directiva WORKDIR anterior.

.. _docker_imaǵenes_y_capas:

Imágenes Docker y Capas:
--------------------------

**Referencias:**
    https://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/
    
* Cuando Docker inicia un contenedor, *inicia una \\"imagen\\" dentro** de éste.
* Esta **\\"imagen\\"** se construye ejecutan una seria de **instrucciones**, las cuales **agregan capas** sobre una **distribución de OS** (sistema operativo).
* La **distribución del OS** es la imagen original, y cada **capa** agregada **crea una nueva imagen**.

.. _shell_y_exec:

\\"Shell\\" y \\"Exec\\":
--------------------------

**Referencias:**
    https://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/

* RUN, CMD y ENTRYPOINT puede ser especificada en formas **\\"shell\\"** y **\\"exec\\"**.

* Formato **\\"Shell\\"**:
    :code:`<instruction> <command>`

    Ejemplos:

    .. code-block:: bash

        RUN apt-get install python3
        CMD echo "Hello world"
        ENTRYPOINT echo "Hello world"

    Cuando la instrucción se ejecuta en **formato \\"shell\\"**, llama a :code:`/bin/sh -c <command>` y un proceso normal de shell se ejecuta.
    Por ejemplo:

    .. code-block:: bash

        #DOCKERFILE
        ENV name John Dow
        ENTRYPOINT echo "Hello, $name"

        #INICIAR CONTENEDOR
        docker run -it <image>

        #RESULTADO (variable $name es expandida).
        Hello, John Dow

    * Formato **\\"Exec\\"**:

        :code:`<instruction> ["executable", "param1", "param2", ...]`

        Ejemplos:

        .. code-block:: bash

            RUN ["apt-get", "install", "python3"]
            CMD ["/bin/echo", "Hello world"]
            ENTRYPOINT ["/bin/echo", "Hello world"]

        Cuando la instrucción se ejecuta en **formato \\"exec\\"**, **ejecuta directamente** el ejecutable, y **NO** se inicia proceso shell.
        Por ejemplo:

        .. code-block:: bash

            #DOCKERFILE
            ENV name John Dow
            ENTRYPOINT ["/bin/echo", "Hello, $name"]

            #INICIAR CONTENEDOR
            docker run -it <image>

            #RESULTADO (variable $name NO es sustituida).
            Hello, $name

    * ¿Cómo **ejecutar Bash en Dockerfile**?:
        Con **formato \\"exec\\"** llamando a :code:`/bin/bash`

        .. code-block:: bash

            #DOCKERFILE
            ENV name John Dow
            ENTRYPOINT ["/bin/bash", "-c", "echo Hello, $name"]

            #INICIAR CONTENEDOR
            docker run -it <image>

            #RESULTADO (variable $name NO es sustituida).
            Hello, John Dow