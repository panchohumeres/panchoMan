========================================
Linux: Networking
========================================

Interfaces:
-------------

Ejemplo de interfaces:
    - Ver: https://pythonspeed.com/articles/docker-connection-refused/

.. code-block:: bash

    $ ifconfig
    docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
    inet 172.17.0.1

    lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
    inet 127.0.0.1

    wlp0s20u8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
    inet 192.168.7.202

- **\\"docker0\\"** es el proceso Docker.
- **\\"lo\\"** es **\\"loopback interface\\"**, con dirección IPv4 127.0.0.1. Es el propio host o computador, accesible desde la memoria sin intermediación de hardware.
- **\\"wlp0s20u8\\"** es la **tarjeta WiFI**, dirección IPv4 192.168.7.202, encargada de enviar y recibir paquetes a internet.
- El esquema de conexión desde el browser al localhost sería este:

  .. image:: https://d33wubrfki0l68.cloudfront.net/d1dfdbe0a2f8f124011ec3f33e29a251024918f0/e1090/assets/docker-connection-refused/no-docker.svg
        :alt: localhost-networking

Fuente Imagen: [1]_.

Códigos HTTP
------------------

301 Movido Permanentemente
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**\\"Status 301 Moved Permanently\\"**, indica que el recurso ha sido movido permanentemente a la **URL** dada por el **header \\"Location\\".
* El browser redirege a esta nueva URL y actualiza sus links.
* Se recomienda utilizarlo sólo con métodos **\\"GET\\"** o **\\"HEAD\\"**.
* Ver: https://developer.mozilla.org/es/docs/Web/HTTP/Status/301

.. [1] Itamar Turner-Trauring, https://pythonspeed.com/articles/docker-connection-refused/
