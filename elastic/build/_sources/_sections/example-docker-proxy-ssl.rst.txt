
.. _ejemplo_ssl_docker_proxy:

============================================================
Elasticsearch: Ejemplo Docker SSL Interno / Proxy NGINX
============================================================

Basado en Ejemplo Certbot-Docker-Nginx:
    - https://panchohumeres.gitlab.io/ssl_tsl_man/_sections/certbot-docker.html
    - https://panchohumeres.gitlab.io/docker_man_page/_sections/special-cases.html#
    - https://panchohumeres.gitlab.io/nginx_man/_sections/docker.html#templating-de-configuracion-caso-2

Ejemplo de configuración Docker-Compose de Elasticsearch **DETRÁS DE PROXY** NGINX:
    - **2 Nodos**
    - **\\"es01\\" Nodo Principal.**

**Diferencias** respecto de configuración mostrada en: :ref:`ejemplo_ssl_docker`.:
    - **T** ransport **L** ayer **S** ecurity (comunicación interna de Elasticsearch), manejada con certificados auto-firmados de Elasticsearch.
    - **Http** \\"layer\\" o comunicaciones **\\"http\\"** manejada por certificados generados por **Certbot Let's Encrypt**.

A continuación se muestran **\\"snippets\\"** de las **diferencias** en secciones de código respecto de la configuración de ejemplo mostrada en: 
    - :ref:`ejemplo_ssl_docker`

.env
---------

.. code-block:: bash

    COMPOSE_PROJECT_NAME=elastic_network
    CERTS_DIR=/usr/share/elasticsearch/config/certificates 
    ELASTIC_PASSWORD=mypasswd1
    KIBANA_PASSWORD=mypasswd2
    KIBANA_GUEST_AUTH="base64hash"
    HOST_DATA_PATH=../data_path
    ELASTIC_PORT=9200
    KIBANA_PORT=5601
    LOCALHOST=0.0.0.0
    NGINX_FRONT_END_PORT=8080
    DOMAIN_KIBANA=kibana.mydomain.com
    DOMAIN_ELASTIC=elastic.mydomain.com
    SERVER_NAME_KIBANA=kibana_name
    SERVER_NAME_ELASTIC=elastic_name

docker-compose.yml
------------------------

.. code-block:: bash

    es01:
        #container_name: es01
        image: docker.elastic.co/elasticsearch/elasticsearch:7.2.0
        environment:
        - node.name=es01
        - discovery.seed_hosts=es01,es02
        - cluster.initial_master_nodes=es01,es02
        - ELASTIC_PASSWORD=$ELASTIC_PASSWORD 
        - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
        - xpack.security.enabled=true
        - xpack.security.transport.ssl.enabled=true
        - xpack.security.transport.ssl.verification_mode=certificate 
        - xpack.security.transport.ssl.certificate_authorities=$CERTS_DIR/ca/ca.crt
        - xpack.security.transport.ssl.certificate=$CERTS_DIR/es01/es01.crt
        - xpack.security.transport.ssl.key=$CERTS_DIR/es01/es01.key
        - xpack.security.authc.anonymous.roles=dashboard_only_custom
        - xpack.security.authc.anonymous.authz_exception=true

        volumes: ['${HOST_DATA_PATH}/data01:/usr/share/elasticsearch/data','certs:$CERTS_DIR']
        ports:
        - ${ELASTIC_PORT}:9200 #default: 9200
        healthcheck:
        test: curl --cacert $CERTS_DIR/ca/ca.crt -s https://localhost:9200 >/dev/null; if [[ $$? == 52 ]]; then echo 0; else echo 1; fi
        interval: 30s
        timeout: 10s
        retries: 5

    es02:
        #container_name: es02#
        image: docker.elastic.co/elasticsearch/elasticsearch:7.2.0
        environment:
        - node.name=es02
        - discovery.seed_hosts=es01,es02
        - cluster.initial_master_nodes=es01,es02
        - ELASTIC_PASSWORD=$ELASTIC_PASSWORD
        - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
        - xpack.security.enabled=true
        - xpack.security.transport.ssl.enabled=true
        - xpack.security.transport.ssl.verification_mode=certificate 
        - xpack.security.transport.ssl.certificate_authorities=$CERTS_DIR/ca/ca.crt
        - xpack.security.transport.ssl.certificate=$CERTS_DIR/es02/es02.crt
        - xpack.security.transport.ssl.key=$CERTS_DIR/es02/es02.key
        volumes: ['${HOST_DATA_PATH}/data02:/usr/share/elasticsearch/data','certs:$CERTS_DIR']

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