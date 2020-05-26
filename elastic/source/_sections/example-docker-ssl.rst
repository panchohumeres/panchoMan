
.. _ejemplo_ssl_docker:

==========================================
Elasticsearch: Ejemplo Docker SSL Interno
==========================================

Ejemplo de configuración Docker-Compose de Elasticsearch con:
    * **2 Nodos**
    * **\\"es01\\" Nodo Principal.**
    * **T** ransport **L** ayer **S** ecurity (comunicación interna de Elasticsearch), manejada con certificados auto-firmados de Elasticsearch.
    * **Http** \\"layer\\" o comunicaciones **\\"http\\"** manejada por certificados auto-firmados generados por Elasticsearch.

**Referencias:** 
    - https://www.elastic.co/guide/en/elasticsearch/reference/current/configuring-tls-docker.html
    - https://www.elastic.co/guide/en/elasticsearch/reference/current/configuring-tls.html

Generar certificados
-----------------------

generar certificados para comunicación interna de elastic-kibana (ejecutar una sóla vez) docker va a generar automáticamente la red especificada en el archivo -env (variable PROJECT_NAME) y los volumenes de certificados

1. crear directorio que va a contener certificados en volumen externo correspondiente (mkdir certs)
2. :code:`docker-compose -f create-certs.yml run --rm create_certs`

.env
---------

.. code-block:: bash

    COMPOSE_PROJECT_NAME=elastic_network
    CERTS_DIR=/usr/share/elasticsearch/config/certificates 
    ELASTIC_PASSWORD=mypasswd1
    KIBANA_PASSWORD=mypasswd2
    JUPYTER_PSSWD='sha1:sha1_hash'
    JUPYTER_ALLOW_ORIGIN=*
    KIBANA_GUEST_AUTH="base64hash"
    HOST_DATA_PATH=../data_path
    ELASTIC_PORT=9200
    KIBANA_PORT=5601
    JUPYTER_PORT=8888

docker-compose.yml
------------------------

.. code-block:: bash

    version: "3"

        services:

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
            - xpack.security.http.ssl.enabled=true
            - xpack.security.http.ssl.key=$CERTS_DIR/es01/es01.key
            - xpack.security.http.ssl.certificate_authorities=$CERTS_DIR/ca/ca.crt
            - xpack.security.http.ssl.certificate=$CERTS_DIR/es01/es01.crt
            - xpack.security.transport.ssl.enabled=true
            - xpack.security.transport.ssl.verification_mode=certificate 
            - xpack.security.transport.ssl.certificate_authorities=$CERTS_DIR/ca/ca.crt
            - xpack.security.transport.ssl.certificate=$CERTS_DIR/es01/es01.crt
            - xpack.security.transport.ssl.key=$CERTS_DIR/es01/es01.key
            - xpack.security.authc.anonymous.roles=dashboard_only_custom
            - xpack.security.authc.anonymous.authz_exception=true

            volumes: ['${HOST_DATA_PATH}/data01:/usr/share/elasticsearch/data', 'certs:$CERTS_DIR']
            ports:
            - ${ELASTIC_PORT}:9200 #default: 9200
            healthcheck:
            test: curl --cacert $CERTS_DIR/ca/ca.crt -s https://localhost:9200 >/dev/null; if [[ $$? == 52 ]]; then echo 0; else echo 1; fi
            interval: 30s
            timeout: 10s
            retries: 5

        es02:
            #container_name: es02
            image: docker.elastic.co/elasticsearch/elasticsearch:7.2.0
            environment:
            - node.name=es02
            - discovery.seed_hosts=es01,es02
            - cluster.initial_master_nodes=es01,es02
            - ELASTIC_PASSWORD=$ELASTIC_PASSWORD
            - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
            - xpack.security.enabled=true
            - xpack.security.http.ssl.enabled=true
            - xpack.security.http.ssl.key=$CERTS_DIR/es02/es02.key
            - xpack.security.http.ssl.certificate_authorities=$CERTS_DIR/ca/ca.crt
            - xpack.security.http.ssl.certificate=$CERTS_DIR/es02/es02.crt
            - xpack.security.transport.ssl.enabled=true
            - xpack.security.transport.ssl.verification_mode=certificate 
            - xpack.security.transport.ssl.certificate_authorities=$CERTS_DIR/ca/ca.crt
            - xpack.security.transport.ssl.certificate=$CERTS_DIR/es02/es02.crt
            - xpack.security.transport.ssl.key=$CERTS_DIR/es02/es02.key
            volumes: ['${HOST_DATA_PATH}/data02:/usr/share/elasticsearch/data', 'certs:$CERTS_DIR']

        nginx:
            image: nginx:latest
            environment:
            - KIBANA_GUEST_AUTH
            ports:
                - ${NGINX_FRONT_END_PORT}:80 #default 8080
            volumes:
                - ${PWD}/nginx-config/:/etc/nginx/conf.d/
            entrypoint: ["sh", "etc/nginx/conf.d/docker-entrypoint.sh"]
            command: ["nginx", "-g", "daemon off;"]
            ulimits:
            nproc: 65535


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