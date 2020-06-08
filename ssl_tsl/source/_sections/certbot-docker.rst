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

        Si hay problemas con los permisos, ejecutar:

        .. code-block:: bash

            chmod +x init-letsencrypt.sh

    3. Levantar contenedor:

        .. code-block:: bash

            docker-compose up


Ejemplo múltiples dominios para múltiples puertos:

**Referencias**:
    * https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71
    * https://sysadmins.co.za/secure-your-elasticsearch-cluster-with-basic-auth-using-nginx-and-ssl-from-letsencrypt/
    * https://serverfault.com/questions/769578/curl-56-recv-failure-connection-reset-by-peer-when-hitting-docker-container
    * https://dev.to/ganesshkumar/self-hosting-multiple-applications-in-a-single-machine-1l3o

-----------------------------------------------------------------------------

    1. Reemplazar archivo **"/data/nginx/app.conf"** o  **"data/nginx/nginx.conf"** (el archivo que esté sirviendo de configuración para el contenedor nginx), por este contenido:
        https://github.com/panchohumeres/nginx-certbot/blob/master/data/nginx/example-multihost-nginx.conf
        
        * Reemplazar los nombres de servidores por correspondientes nombres para identificarlos:
        * En este ejemplo reemplazar **"bi","elastic", y "kibana"**.
        * Reemplazar **"ip_localhost"** con nombre o IP de localhost.
        * Reemplazar el puerto al lado de "ip_localhost" con el correspondiente puerto que va a responder a cada uno de los distintos dominios.
        
        .. code-block:: json

            upstream bi {
            ip_hash;
            server ip_localhost:8888 fail_timeout=5580s max_fails=1000;
            }

            upstream elastic {
                ip_hash;
                server ip_localhost:9200 fail_timeout=5580s max_fails=1000;
            }

            upstream kibana {
                ip_hash;
                server ip_localhost:5601 fail_timeout=5580s max_fails=1000;
            }

        * Reemplazar nombres de dominios con nombres correspondientes.
        * En este caso **"bi.cl", "kibana.cl" y "elastic.cl"**.
        * Cuidar reemplazarlos en todo el archivo.
        * Ejemplos de directivas donde reemplazar:

        .. code-block:: json

            server {
                if ($host = bi.cl) {
                return 301 https://$host$request_uri;
                } # managed by Certbot

                location /.well-known/acme-challenge/ {
                root /var/www/certbot;
                }
            listen 80;
            server_name bi.cl;
            return 301 https://$host$request_uri;
            location / {
            proxy_pass http://bi;
                }
            }

            server {
                listen 443 ssl;
                server_name elastic.cl;
                server_tokens off;

                ssl_certificate /etc/letsencrypt/live/elastic.cl/fullchain.pem;
                ssl_certificate_key /etc/letsencrypt/live/elastic.cl/privkey.pem;
                include /etc/letsencrypt/options-ssl-nginx.conf;
                ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

                location / {
                proxy_pass  http://elastic;
                proxy_set_header    Host                $http_host;
                proxy_set_header    X-Real-IP           $remote_addr;
                proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
            }

        * Crear cada una de estas directivas para cuantos dominios se desee redireccionar.

    2.  Reemplazar en script **"init-letsencrypt.sh"**, nombre de dominio con dominio para el cual se desea crear certificados (los mismos de arriba en 1.):
        
        .. code-block:: bash
        
            domains=(example.org www.example.org)

    4. Correr script:

       .. code-block:: bash

           ./init-letsencrypt.sh

    5. Repetir 2 y 3 para cada uno de los dominios que se desean redireccionar.

    

        

