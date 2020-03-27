=====================================
Docker: ENTRYPOINT, CMD Y RUN
=====================================

Instrucciones para pasar y reemplazar variables de entorno en scripts Bash

----------------------------------------------------------------------------

* Ejemplo nginx.conf:
    https://serverfault.com/questions/577370/how-can-i-use-environment-variables-in-nginx-conf

    /etc/nginx/conf.d/default.conf.template

    .. code-block:: bash

        resolver  127.0.0.11 valid=10s;  # recover from the backend's IP changing

        server {
            listen  80;

            location / {
            root  /usr/share/nginx/html;
        }

        location /api {
            proxy_pass  http://${API_HOST}:${API_PORT};
            proxy_set_header  Host $http_host;
        }
        }


    Ejemplo script bash:

    .. code-block:: bash

        #!/usr/bin/env sh
        set -eu #output para cada paso del script
        envsubst '${API_HOST} ${API_PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
        nginx -g "daemon off;"

    Ejemplo Dockerfile en base a imagen alipne linux:

    .. code-block:: bash

        FROM nginx:1.15-alpine

            RUN envsubst '${LOCALHOST} ${DOMAIN_KIBANA} ${DOMAIN_ELASTIC} ${DOMAIN_JUPYTER} ${SERVER_NAME_KIBANA} ${SERVER_NAME_ELASTIC} ${SERVER_NAME_JUPYTER} ${KIBANA_PORT} ${ELASTIC_PORT} ${JUPYTER_PORT}' < /etc/nginx/conf.d/nginx.conf.template > /etc/nginx/conf.d/nginx.conf
            #OTROS COMANDOS NECESARIOS....

    **OJO!!**: Método **bash o \\"entrypoint\\" NO está testeado**, **preferir** método **Dockerfile**. Método bash genera problemas de networking entre contenedor y el host, ver:

        - :ref:`redirección_de_puertos`
        - :ref:`connection_refuse_connection_rest_by_peer`


