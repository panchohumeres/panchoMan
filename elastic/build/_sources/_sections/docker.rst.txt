=====================================
Elasticsearch: Docker
=====================================

Documentación para implementar Elasticsearch en Docker y Docker-compose.

---------------------------------------------------------------------------

Ejemplos detallados
---------------------

    .. toctree::
        :maxdepth: 2
        :caption: Contenidos:

        1. SSL Interno <../_sections/example-docker-ssl>
        2. SSL con Certbot y proxy NGINX / TSL <../_sections/example-docker-proxy-ssl>

.. _caso_ssl_docker:

Caso SSL interno
----------------------------------------------------------------------------------------------------------

* Caso de comunicaciones SSL i.e. **TSL** (Transport Layer Security) y **Http**, gestionados con certificados auto-firmados creados con herramientas de Elasticsearch.
* Maneja comunicaciones entre nodos a nivel de capa **TSL** y **HTTP**.
* Se usa X-Pack.
* Ver: :ref:`ejemplo_ssl_docker` para ver ejemplo implementado (con archivos docker-compose).
* Asume Variables de entorno especificadas para este docker-compose en particular: :ref:`ejemplo_ssl_docker`

Probar acceso a host elasticsearch, desde el contenedor de elasticsearch
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* 1. Ingresar al contenedor del nodo principal de Elasticsearch.

    .. code-block:: bash

        #Docker-compose, bash
        docker-compose exec <nombre_contenedor_elasticsearch_nodo_principal> bash


    .. code-block:: bash

        curl --cacert {CERTS_PATH}/certs/ca/ca.crt https://{USER}:{PSSWD}@{HOST}:{PUERTO}
        
        #POR LO GENERAL CERTS_PATH=/usr/share/elasticsearch/config/certificates 
        curl --cacert /usr/share/elasticsearch/config/certificates/certs/ca/ca.crt https://{USER}:{PSSWD}@{HOST}:{PUERTO}


Probar Conexión desde Host (sin entrar en Contenedor):
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

    curl --cacert {VOLUMEN_EXTERNO}/certs/ca/ca.crt https://{USER}:{PSSWD}@{HOST}:{PUERTO}/_cat/indices

Listar todos los índices
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

    curl --cacert {VOLUMEN_EXTERNO}/certs/ca/ca.crt https://{USER}:{PSSWD}@{HOST}:{PUERTO}/_cat/indices

.. _caso_ssl_docker_proxy:

Caso SSL con comunicaciones HTTP manejadas por Proxy
----------------------------------------------------------

**Referencias:** https://discuss.elastic.co/t/setting-https-for-kibana-with-nginx-and-a-fqdn/205010

En este caso:
    * Las comunicaciones **HTTP(S)** son gestionadas por certificados generados por una autoridad externa (como CERTBOT de Let's Encrypt).
    * Por ende, los **certificados auto-firmados de X-Pack" de Elasticsearch, **NO** se usan para habilitar SSL en la conexión al endpoint de Elasticsearch.
    * Los **certificados auto-firmados de X-Pack" de Elasticsearch** **SÓLO** se usan para comunicaciones internas entre nodos o con Kibana.
    * Por ende **NO** se puede consultar Elasticsearch desde el **host** (usando **\\"locaholst\\"** u otras IP o dominios internos).
    * Ver: :ref:`ejemplo_ssl_docker_proxy`

* **EN ESTE CASO** Consultas como:

.. code-block:: bash

    curl --cacert /usr/share/elasticsearch/config/certificates/certs/ca/ca.crt https://{USER}:{PSSWD}@{HOST}:{PUERTO}

Van a **generar errores** como este:

.. code-block:: bash

    [root@a442067776e0b elasticsearch]# curl -u {USER}:{PSSWD} https://localhost:9200 --cacert /usr/share/elasticsearch/config/certificates/ca/ca.crt
    curl: (35) SSL received a record that exceeded the maximum permissible length.

Por ende se debe consultar la **DNS** u **DNS** asingada a través del **servidor proxy**:

.. code-block:: bash
    curl -u elastic:mypsswd https://{DNS}

    #Ó (SI ES QUE FQDN NO APUNTA A {HOST}:{PUERTO}
    curl -u elastic:mypsswd https://{DNS}:{PUERTO}