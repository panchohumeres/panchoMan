=====================================
Elasticsearch: Queries SSL / TSL
=====================================

Ejemplos de Queries usando certificados SSL / TSL

---------------------------------------------------

**Referencias:**
    - https://www.elastic.co/guide/en/elasticsearch/reference/7.5/cat-indices.html 

Ejemplo de Respuesta esperada
--------------------------------------------

    .. code-block:: bash

        {
        "name" : "es01",
        "cluster_name" : "docker-cluster",
        "cluster_uuid" : "obw-CSWyRliGmXUbcw6znQ",
        "version" : {
        "number" : "7.2.0",
        "build_flavor" : "default",
        "build_type" : "docker",
        "build_hash" : "508c38a",
        "build_date" : "2019-06-20T15:54:18.811730Z",
        "build_snapshot" : false,
        "lucene_version" : "8.0.0",
        "minimum_wire_compatibility_version" : "6.8.0",
        "minimum_index_compatibility_version" : "6.0.0-beta1"
        },
        "tagline" : "You Know, for Search"
        }


.. _queries_ssl_curl:

curl
-------

Probar acceso a host elasticsearch 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

    curl --cacert {CERTS_DIR}/certificates/ca/ca.crt https://{USER}:{PSSWD}@{HOST}:{PUERTO}


Listar todos los índices
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Rerencias**: https://www.elastic.co/guide/en/elasticsearch/reference/7.5/cat-indices.html

.. code-block:: bash

    curl http://{HOST}:{PUERTO}/_aliases