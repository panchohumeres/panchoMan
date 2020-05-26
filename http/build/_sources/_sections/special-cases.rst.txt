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

* **CERTBOT** (Let's Encrypt) en Docker con NGINX. Ver:
    - PanchoMan SSL / TSL: https://panchohumeres.gitlab.io/ssl_tsl_man/_sections/certbot-docker.html
    - Repo Github: https://github.com/wmnnd/nginx-certbot
    - Fork de repo Github en panchoMan: https://github.com/panchohumeres/nginx-certbot
    - Artículo Medium: https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71
