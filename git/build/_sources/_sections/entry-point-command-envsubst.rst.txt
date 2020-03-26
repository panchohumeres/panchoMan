=====================================
Docker: Entrypoint y Command
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

    .. code-block:: bash

        #!/usr/bin/env sh
        set -eu #output para cada paso del script
        envsubst '${API_HOST} ${API_PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf