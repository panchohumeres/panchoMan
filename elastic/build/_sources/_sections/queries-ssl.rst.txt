=====================================
Elasticsearch: Queries SSL / TSL
=====================================

Ejemplos de Queries usando certificados SSL / TSL

----------------------------------------------


## Probar acceso a host elasticsearch, desde el contenedor de elasticsearch

* 1. docker-compose exec es01 bash
* 2. 
    curl --cacert {CERTS_DIR}/certificates/ca/ca.crt https://{USER}:{PSSWD}@localhost:9200
* 3. Ejemplo respuesta esperada: 
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
* Asume Variables de entorno especificadas para este docker-compose en particular.

## Probar acceso a host elasticsearch, desde el host (sin entrar a contenedores)
curl --cacert {VOLUMEN_EXTERNO}/certs/ca/ca.crt https://{USER}:{PSSWD}@localhost:9200

## Listar todos los índices

https://www.elastic.co/guide/en/elasticsearch/reference/7.5/cat-indices.html
curl --cacert {VOLUMEN_EXTERNO}/certs/ca/ca.crt https://{USER}:{PSSWD}@localhost:9200/_cat/indices


curl http://localhost:9200/_aliases