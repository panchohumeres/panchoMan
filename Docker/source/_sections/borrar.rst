=====================================
Docker: Borrar
=====================================

Instrucciones específicas para **borrar Contenedores, Imágenes y Volúmenes**.

----------------------------------------------

Borrar Volúmenes en Docker-compose:
--------------------------------------

**Referencias**: 
    - https://docs.docker.com/compose/reference/down/
    - https://stackoverflow.com/questions/34658836/docker-is-in-volume-in-use-but-there-arent-any-docker-containers
    
Borrar contenedores y sus volúmenes:

    .. code-block:: bash

        docker-compose down --volumes

