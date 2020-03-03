=====================================
SSL / TSL: Certbot Docker
=====================================

SSL / TSL Certbot-Docker:
    Documentación relativa a Certbot (Let's Encrypt) en Docker

---------------------------------------------------------------

* **Referencias:**
    * Repo Github: https://github.com/wmnnd/nginx-certbot
    * Fork de repo Github en panchoMan: https://github.com/panchohumeres/nginx-certbot
    * Artículo Medium: https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71

Pasos

**Requisitos**: Instalar Docker-compose y clonar cualquiera de los dos repos.

-----------------------------------------------------------------------------

    1. Modificar archivos de configuración:
            * Reemplazar (ocurrencias de **"example.org"**) y/o agregar dominios y e-mail en archivo "init-letsencrypt.sh".
            * Reemplazar ocurrencias de **"example.org"** con dominios anteriormente reemplazados en paso 1., esta vez en el archivo **"data/nginx/app.conf"**.
    2. Correr script:

       .. code-block:: bash

           ./init-letsencrypt.sh

    3. Levantar contenedor:

        .. code-block:: bash

            docker-compose up
