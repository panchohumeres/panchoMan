=====================================
Jupyter Notebooks: Casos Especiales
=====================================


Docker-Compose con NGINX y reverse-proxy
--------------------------------------------------------------------------

**Referencias**:
    - https://github.com/jupyter/notebook/issues/4757
    - https://github.com/jupyter/notebook/issues/2664
    - https://github.com/jupyter/notebook/issues/625
    - https://github.com/jupyter/jupyter/issues/79

    - Ejemplo basado en caso de implementación de **NGINX** en **Docker-compose** con **Certbot** (Let's encrypt), que permite montar un stack de tecnologías usando a NGINX como servidor y con renovación automatizada de certificados **SSL**:
        Ver ejemplo en: https://panchohumeres.gitlab.io/nginx_man/_sections/docker.html#templating-de-configuracion-caso-2

    - A continuación se detallan secciones de archivos de configuración **docker-compose.yml**, **nginx.conf** y **.env**, para que el servidor Jupyter Notebook protegido con **SSL** funcione correctamente. Los detalles de estas configuraciones verlas en la referencia anteriormente mencionada.
    - **NO OLVIDAR CONSULTAR LA URL CON \\"HTTPS\\"**, caso contrario se puede dar un error como este: :ref:`kernel_not_connected`:

.env
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Variables de entorno clave en archivo **.env**:

    .. code-block:: bash

        JUPYTER_ALLOW_ORIGIN=*

docker-compose.yml
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    .. code-block:: bash

        version: "3"
        #inaugurando rama staging

        services:

        jupyter:
            build:
            context: ./jupyter
            ports:
            - ${JUPYTER_PORT}:8888 #default 8888
            command: jupyter-notebook --NotebookApp.password=${JUPYTER_PSSWD} --NotebookApp.allow_origin=${JUPYTER_ALLOW_ORIGIN}
            environment:
            - ELASTIC_USER=$ELASTIC_USER
            - ELASTIC_PASSWD=$ELASTIC_PASSWORD
            - ELASTIC_PORT=$ELASTIC_PORT
            volumes:
            - ./notebooks:/home/jovyan/work
            - ${HOST_DATA_PATH}:/data
            - certs:/certs
            - ./jupyter_config:/home/jovyan/.jupyter/
            - ./backup_utils/kibana:/home/jovyan/work/backup_kibana

        certbot:
            image: certbot/certbot
            restart: unless-stopped
            volumes: ['${HOST_DATA_PATH}/certbot/conf:/etc/letsencrypt','${HOST_DATA_PATH}/certbot/www:/var/www/certbot']
            entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;'"
        
        nginx:
            build:
            context: ./nginx
            environment:
            - LISTEN_PORT=80
            - DOMAIN_KIBANA=$DOMAIN_KIBANA
            - DOMAIN_ELASTIC=$DOMAIN_ELASTIC
            - DOMAIN_JUPYTER=$DOMAIN_JUPYTER
            - JUPYTER_PORT=${JUPYTER_PORT}
            - KIBANA_PORT=${KIBANA_PORT}
            - ELASTIC_PORT=${ELASTIC_PORT}
            - SERVER_NAME_KIBANA=$SERVER_NAME_KIBANA
            - SERVER_NAME_ELASTIC=$SERVER_NAME_ELASTIC
            - SERVER_NAME_JUPYTER=$SERVER_NAME_JUPYTER
            volumes: ['${PWD}/nginx-config/conf:/etc/nginx/conf.d','${HOST_DATA_PATH}/certbot/conf:/etc/letsencrypt','${HOST_DATA_PATH}/certbot/www:/var/www/certbot',
            '${PWD}/nginx-config/sites-enabled:/etc/nginx/sites-enabled']
            ports:
            - "80:80"
            - "443:443"
            command: "/bin/sh -c 'while :; do sleep 6h & wait $${!}; nginx -s reload; done & nginx -g \"daemon off;\"'"

        wait_until_ready:
            image: docker.elastic.co/elasticsearch/elasticsearch:7.2.0
            command: /usr/bin/true
            depends_on: ["es01"]

        volumes:
        certs:
            driver: local
            driver_opts:
            type: none
            device: $PWD/${HOST_DATA_PATH}/certs
            o: bind
        http_certs:
            driver: local
            driver_opts:
            type: none
            device: $PWD/${HOST_DATA_PATH}/http_certs
            o: bind

.. _nginx.conf_reverse_proxy_nginx_docker_compose:

nginx.conf
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    .. code-block:: bash

        upstream ${SERVER_NAME_JUPYTER} {
                ip_hash;
                server ${LOCALHOST}:${JUPYTER_PORT} fail_timeout=5580s max_fails=1000;
        }
        server {



                listen 80;
                server_name ${DOMAIN_JUPYTER};
                server_tokens off;
                #return 301 https://$host$request_uri;
            location /.well-known/acme-challenge/ {
                root /var/www/certbot;
            }
                location / {
                    proxy_pass http://${SERVER_NAME_JUPYTER};
                }
        }

        server {
            listen 443 ssl;
            server_name ${DOMAIN_JUPYTER};
            server_tokens off;

            ssl_certificate /etc/letsencrypt/live/${DOMAIN_JUPYTER}/fullchain.pem;
            ssl_certificate_key /etc/letsencrypt/live/${DOMAIN_JUPYTER}/privkey.pem;
            include /etc/letsencrypt/options-ssl-nginx.conf;
            ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

            location / {
                proxy_pass  http://${SERVER_NAME_JUPYTER};
                proxy_set_header    Host                $http_host;
                proxy_set_header    X-Real-IP           $remote_addr;
                proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
            }

        location ~ /api/kernels/ {
        proxy_pass http://${SERVER_NAME_JUPYTER};
        proxy_set_header Host $http_host;
        # websocket support
        proxy_http_version 1.1;
        proxy_set_header Upgrade "websocket";
        proxy_set_header Connection "Upgrade";
        proxy_read_timeout 86400;
        }
        location ~ /terminals/ {
        proxy_pass http://${SERVER_NAME_JUPYTER};
        proxy_set_header Host $http_host;
        # websocket support
        proxy_http_version 1.1;
        proxy_set_header Upgrade "websocket";
        proxy_set_header Connection "Upgrade";
        proxy_read_timeout 86400;
        }

        }
