=====================================
Docker: ENTRYPOINT, CMD Y RUN
=====================================

* **Referencias**:
    https://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/

Ver Primero
---------------------------------------

- :ref:`docker_imaǵenes_y_capas`
- :ref:`shell_y_exec`

Resumen
----------

* Usar **RUN** para *construir imagen*, **agregando capas sobre la imagen fuente** o original (definidad por **\\"FROM\\"**). Preferido para instalar paquetes y librerías.
* Preferir **ENTRYPOINT** sobre CMD, cuando al momento de **construir imagen** Docker **siempre se requiere ejecutar un comando**.
* Junto con el caso anterior, **adicionalmente** se puede ejecutar **CMD** si se necesita proveer **argumentos por defecto adicionales**, que pueden ser **sobreescritos** desde la línea de comandos cuando inicia el contenedor.
* Preferir **CMD** si se necesita proveer commandos o argumentos **por defecto**, que pueden ser **sobreescritos** desde la línea de comandos cuando el contenedor Docker se inicia.


**RUN**
---------------------------------------

* **\\"RUN\\"** ejecuta comandos en una nueva capa y crea una nueva imagen.
* Generalmente se usa para instalar paquetes o librerías.
* Tiene dos formas:

    .. code-block:: bash

        RUN <command> #(shell form)
        RUN ["executable", "param1", "param2"] #(exec form)

* Ejemplo:

    .. code-block:: bash

        RUN apt-get update && apt-get install -y \
            bzr \
            cvs \
            git \
            mercurial \
            subversion

    **Nota**: :code:`apt-get update` y :code:`apt-get install` se **ejecutan en una sola instrucción RUN**, de lo contrario reutilizarían una imagen anterior, con paquetes más atrasados.


**CMD (Command)**
---------------------------------------

* **\\"CMD\\"** establece **comandos default o parámetros** que pueden ser **sobreescritos** cuando el contenedor **inicia**.
* Tiene tres formas:

    .. code-block:: bash

        CMD ["executable","param1","param2"] #(exec form, preferred)
        
        #configura parámetros por defecto que serán AGREGADOS DESPUÉS de parámetros de ENTRYPOINT
        CMD ["param1","param2"] #(parámetros adicionales para ENTRYPOINT en formato exec)
        
        CMD command param1 param2 #(shell form)

    Por ejemplo:

    .. code-block:: bash

        #-------ejemplo 1---------------
        #DOCKERFILE
        CMD echo "Hello world" 

        #INICIAR CONTENEDOR
        docker run -it <image>

        #RESULTADO.
        Hello world

        #-------ejemplo 2---------------
        #DOCKERFILE
        CMD echo "Hello world" 

        #INICIAR CONTENEDOR
        docker run -it <image> /bin/bash

        #RESULTADO (ejecuta el intérprete interactivo).
        root@7de4bed89922:/#


**ENTRYPOINT**
---------------------------------------

* **\\"ENTRYPOINT\\"** configura un **contenedor que va a correr como ejecutable**.
* Tiene dos formas:

    .. code-block:: bash

        ENTRYPOINT ["executable", "param1", "param2"] #(exec form, preferred)
        ENTRYPOINT command param1 param2 #(shell form)

    Por ejemplo:

    .. code-block:: bash

        #-------FORMATO EXEC---------------
        #DOCKERFILE
        ENTRYPOINT ["/bin/echo", "Hello"]
        CMD ["world"]

        #INICIAR CONTENEDOR--->forma 1
        docker run -it <image>
        #RESULTADO.
        Hello world

        #INICIAR CONTENEDOR--->forma 2
        docker run -it <image> John
        #RESULTADO.
        Hello John

        #-------ejemplo 2---------------
        #DOCKERFILE
        CMD echo "Hello world" 

        #INICIAR CONTENEDOR
        docker run -it <image> /bin/bash

        #RESULTADO (ejecuta el intérprete interactivo).
        root@7de4bed89922:/#

