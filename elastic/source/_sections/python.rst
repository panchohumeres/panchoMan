=====================================
Elasticsearch: Python
=====================================

Documentación sobre la API Python de Elasticsearch.

--------------------------------------------------------


Conexión Normal
---------------------

**Referencias:** 
    - https://stackoverflow.com/questions/41119788/user-authentication-in-elasticsearch-query-using-python
    - https://stackoverflow.com/questions/50366668/authentication-in-elasticsearch-using-python

* Importar estas **librerías** para los ejemplos:

    .. code-block:: python

        import requests
        from elasticsearch import Elasticsearch

* **Sin certificados SSL**, o con protección **SSL detrás de algún proxy** (como NGINX).
* Emula solicitudes como: :ref:`ejemplo_ssl_docker_proxy`

    .. code-block:: python
        
        #SOLICITUD AUTENTICACIÓN BÁSICA HTTP
        es = Elasticsearch(['http://{HOST}:{PUERTO}'], http_auth=('user', 'pass'))

        #SOLICITUD AUTENTICACIÓN BÁSICA HTTPS
        es = Elasticsearch(['http://{HOST}:{PUERTO}'], http_auth=('user', 'pass'))

        #FORMA CON TODO LA SOLICITUD EN LA URL
        es = Elasticsearch(hosts="http://elastic:changeme@localhost:9200/")

Conexión SSL (usando archivos de certificados)
---------------------------------------------------

* Emula solicitudes como:
    - :ref:`queries_ssl_curl`
    - :ref:`ejemplo_ssl_docker`

    .. code-block:: python

        from ssl import create_default_context

        ES_HOST = "https://mydomain:9200"
        context = create_default_context(cafile="/certs/ca/ca.crt")
        es = Elasticsearch(
            [ES_HOST],
            http_auth=('elastic',  ),
            scheme="https",
            port=443,
            ssl_context=context,
        )



