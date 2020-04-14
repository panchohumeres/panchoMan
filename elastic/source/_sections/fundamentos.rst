======================================
Elasticsearch: Fundamentos
======================================


Documentos
-----------------------

* La unidad atómica de elastiseach. Corresponde a un **JSON** (**diccionario**), con **llaves** o nombres de \\"variables\\" y sus correspondientes valores.
* Cada **lave** tiene *un* valor correspondiente.
* Las **llaves** o nombres de variables son **comunes** a todos los documentos en el **índice**.
* Los **valores** pueden contener otro **diccionario** (o **JSON**), es decir **documentos anidados** (aunque en estos casos, el documento anidado **NO** se contabiliza como un documento del índice propiamente tal).
* Ejemplo de **UN Documento**:
    - Como **\\"Tabla\\"**:

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/elastic_document_table.png

    - Como **JSON**:
        **Nota:** Documento propiamente tal está dentro de elemento **\\"_source\\"**.

        .. code-block:: json

            {
            "_index": "kibana_sample_data_flights",
            "_type": "_doc",
            "_id": "YPVpFXEB5UWALlwhWs1x",
            "_version": 1,
            "_score": null,
            "_source": {
                "FlightNum": "T1QZM86",
                "DestCountry": "AT",
                "OriginWeather": "Rain",
                "OriginCityName": "Torino",
                "AvgTicketPrice": 528.7028432390307,
                "DistanceMiles": 469.0630980224625,
                "FlightDelay": false,
                "DestWeather": "Damaging Wind",
                "Dest": "Vienna International Airport",
                "FlightDelayType": "No Delay",
                "OriginCountry": "IT",
                "dayOfWeek": 1,
                "DistanceKilometers": 754.8838824238619,
                "timestamp": "2020-04-14T04:49:02",
                "DestLocation": {
                "lat": "48.11029816",
                "lon": "16.56970024"
                },
                "DestAirportID": "VIE",
                "Carrier": "Kibana Airlines",
                "Cancelled": false,
                "FlightTimeMin": 50.32559216159079,
                "Origin": "Turin Airport",
                "OriginLocation": {
                "lat": "45.200802",
                "lon": "7.64963"
                },
                "DestRegion": "AT-9",
                "OriginAirportID": "TO11",
                "OriginRegion": "IT-21",
                "DestCityName": "Vienna",
                "FlightTimeHour": 0.8387598693598465,
                "FlightDelayMin": 0
            },
            "fields": {
                "hour_of_day": [
                4
                ],
                "timestamp": [
                "2020-04-14T04:49:02.000Z"
                ]
            },
            "sort": [
                1586839742000
            ]
            }


Índices
----------------------

Un índice es una colección de documentos. Es como una **\\"Tabla\\"**, por ejemplo:

Listado de documentos de un índice:

    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/elastic_4_documents_list.png

Símil con una **\\"Tabla\\"** o **\\"Planilla\\"**. En **amarillo** se resaltan los 4 documentos correspondientes al ejemplo de arriba:


    .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/elastic_sheet_analog.png