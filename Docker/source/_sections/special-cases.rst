=====================================
Docker: Casos Especiales
=====================================

Ejemplos de casos especiales:

----------------------------------------------------------------------------

* Usar Bash con distribuciones "Alpine" (**que no tienen bash**):
    https://stackoverflow.com/questions/40944479/how-to-use-bash-with-an-alpine-based-docker-image/40944512

    1. Instalar Bash:

        .. code-block:: docker

            RUN apk update && apk add bash

            #Ó

            RUN apk add --update bash

    2. Cambiar a shell Bash:

        .. code-block:: docker    
        
            SHELL ["/bin/bash", "-c"]
