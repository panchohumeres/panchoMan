=====================================
Elasticsearch: Formato Kibana
=====================================

Ejemplos de Queries usando \\"Developers Tools\\" de Kibana

----------------------------------------------------------------

Histograma
-----------------

.. code-block:: bash

    GET {index}/_search
    {
        "aggs": {
            "time_buckets": {
            "histogram": {
            "field": "field_name",
            "interval": 10000,
                    "min_doc_count": 0
        }
        }
        },
        "size": 0
    }



Percentiles
---------------

.. code-block:: bash

    GET {index}/_search
    {
        "size": 0,
        "aggs" : {
            "load_time_outlier" : {
                "percentiles" : {
                    "field" : "field_name" ,
                    "keyed": false
                }
            }
        }
    }

Histograma filtrados por valores únicos de un campo
--------------------------------------------------------

.. code-block:: bash

    GET {index}/_search
    {"size":0,"aggs":{
            "filters": {
                "terms" : { "field":"field_name" },
                "aggs":{
                "hists":{
                "histogram": {
                "field": "field_name_2",
                "interval": 5000,
                "keyed": false,
                "min_doc_count": 0
            }

                }
            }}}}


Agregados por field_name 
------------------------------------------------------------------------------------------------------------------

devuelve sólo los dos últimos dos resultados rankeados según el field_name

.. code-block:: bash

    GET {index}/_search
    {"size":0,"aggs":{
            "filters": {
                "terms" : {"field":"field_name_0.keyword","size":2,"order" : { "_key" : "desc" }  },
                "aggs":{

    "sum_1": {
        "sum": {
        "field": "field_name"
        }

                }
            }}}}


Agregados por dia
---------------------------

.. code-block:: bash

    GET {index}/_search
    {
    "size": 0,

    "aggs": {
        "field_name_3": {
        "date_histogram": {
            "field": "field_name_0",
            "calendar_interval": "day"
        },
        "aggs": {
            "field_name_4": {
            "sum": {
                "field": "field_name_2"
            }
            }
        }
        },
        "avg_monthly_field_name_4": {
        "avg_bucket": {
            "buckets_path": "field_name_3>field_name_4" 
        }
        }
    }
    }


Agregado promedio por dia x field_name
---------------------------------------------

.. code-block:: bash

    GET {index}/_search
    {"size": 0,

    "aggs": {

            "filters": {
                "terms" : { "field":"field_name" },
                "aggs":{


    "sum_1": {
        "sum": {
        "field": "field_name_5"
        }
    },
    "sum_2": 
    {"cardinality" : {
                "field" : "dia_field_name",
                "precision_threshold": 100
                }}


    ,
    "division": {
        "bucket_script": {
        "buckets_path": {
            "my_var1": "sum_1",
            "my_var2": "sum_2"
        },
        "script": "params.my_var1 / params.my_var2"
        }
    }
    }
    }
    }
    }

dividir dos campos (suma de ellos)
-----------------------------------

.. code-block:: bash

    "aggs": {
    "sum_1": {
        "sum": {
        "field": "flag_barisolve"
        }
    },
    "sum_2": {
        "sum": {
        "field": "flag_anagrafe"
        }
    },
    "division": {
        "bucket_script": {
        "buckets_path": {
            "my_var1": "sum_1",
            "my_var2": "sum_2"
        },
        "script": "params.my_var1 / params.my_var2"
        }
    }
    }



    GET models*/_search
    {
    "query": {
        "match_all": {}
    },
    "size": 0,
    "aggs": {
        "links": {
        "terms": {
            "field": "links.keyword",
            "size": 10
        }

        },
        "bucket_selector": {
            "buckets_path": {
            "key": "links"
            },
            "script": "!key.contains('foo')"
        }
    }
    }


listar index patterns por nombre y ID
------------------------------------------

**Referencias:** https://github.com/elastic/kibana/issues/9212

.. code-block:: bash

    GET .kibana/_search
    { "_source": ["index-pattern.title"], "query": { "term": { "type": "index-pattern" } }}

cambiar time filter field de index patterns

.. code-block:: bash

    POST /.kibana/_update/index-pattern:33e9f0c0-facd-11e9-a07d-2dba5adf8ca0/ 
    { "doc": { "index-pattern": { "timeFieldName" : "field_name_0" } } }
