=====================================
NGINX: Docker
=====================================

Comandos de utilidad en NGINX:
    En Docker y Docker-Compose

----------------------------------------------

*  Revisar mapeo de "IP:puertos" en el contenedor:

    1. Ingresar al contenedor, usando alguno de los siguientes comando (dependiendo si se está utilizando Docker o Docker-compose, bash o sh y el nombre del contenedor).
        * docker-compose exec nginx bash
        * docker-compose exec nginx sh
        * docker exec -it nginx bash
        * docker exec -it nginx bash
    2.  
        .. code-block:: bash
            
            netstat -an|grep LISTEN

    * Ejemplo resultado:

        .. code-block:: bash

            tcp        0      0 127.0.0.11:36775        0.0.0.0:*               LISTEN 


    * **Referencia:** https://serverfault.com/questions/769578/curl-56-recv-failure-connection-reset-by-peer-when-hitting-docker-container

* Revisar mapeo de puertos desde el host:

    .. code-block:: bash

        sudo netstat -tulpn | grep :80

    Ejemplo resultado:

    .. code-block:: bash

        tcp6       0      0 :::80                   :::*                    LISTEN      11708/docker-proxy

    * **Referencia**: https://docs.docker.com/network/network-tutorial-host/

----------------------------------------------

Templating de configuración:
    En Docker y Docker-Compose
    * **Referencias:** https://thepracticalsysadmin.com/templated-nginx-configuration-with-bash-and-docker/

----------------------------------------------

1. Crear un archivo template de configuración con variables, con variables a ser sustituidas de la siguiente manera:
    :code:`${parameter}`

    Ejemplo:

    .. code-block:: bash

        events {}

        http {
        error_log stderr;
        access_log /dev/stdout;

        upstream upstream_servers {
            server ${UPSTREAM};
        }

        server {
            listen ${LISTEN_PORT};
            server_name ${SERVER_NAME};
            resolver ${RESOLVER};
            set ${ESC}upstream ${UPSTREAM};

            # Allow injecting extra configuration into the server block
            ${SERVER_EXTRA_CONF}

            location / {
            proxy_pass ${ESC}upstream;
            }
        }
        }

2. Crear un Dockerfile que haga referencia al template, y substituya las variables con **"envsubst"**:

    .. code-block:: bash

        FROM nginx:alpine

        ENV LISTEN_PORT=8080 \
        SERVER_NAME=_ \
        RESOLVER=8.8.8.8 \
        UPSTREAM=icanhazip.com:80 \
        UPSTREAM_PROTO=http \
        ESC='$'

        COPY nginx.tmpl /etc/nginx/nginx.tmpl

        CMD /bin/sh -c "envsubst < /etc/nginx/nginx.tmpl > /etc/nginx/nginx.conf && nginx -g 'daemon off;' || cat /etc/nginx/nginx.conf"

3. Si se desea integrarlo en un Docker-Compose:

    .. code-block:: bash

        version: '3'
        services:
        nginx_proxy:
            build:
            context: .
            dockerfile: Dockerfile
            # Only test the configuration
            #command: /bin/sh -c "envsubst < /etc/nginx/nginx.tmpl > /etc/nginx/nginx.conf && cat /etc/nginx/nginx.conf"
            volumes:
            - "./nginx.tmpl:/etc/nginx/nginx.tmpl"
            ports:
            - 80:80
            environment:
            - SERVER_NAME=_
            - LISTEN_PORT=80
            - UPSTREAM=test1.com
            - UPSTREAM_PROTO=https
            # Override the resolver
            - RESOLVER=4.2.2.2
            # The following would add an escape if it isn't in the Dockerfile
            # - ESC=$$    