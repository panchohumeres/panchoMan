=====================================
Docker: Networking
=====================================

Namespaces
----------------------------------------------

**Referencias**: https://pythonspeed.com/articles/docker-connection-refused/
    
Cada contenedor tiene su propia red. Por ejemplo:

.. code-block:: bash

    $ docker run --rm -it busybox
    / # ifconfig
    eth0      Link encap:Ethernet  HWaddr 02:42:AC:11:00:02
            inet addr:172.17.0.2  Bcast:172.17.255.255  Mask:255.255.0.0

    lo        Link encap:Local Loopback
            inet addr:127.0.0.1  Mask:255.0.0.0

- Este contenedor tiene **dos interfaces**, **\\"eth0\\" y \\"lo\\"**.
- Estas **interfaces son independientes a las del host**, son propias al contenedor.
- Para entender **interfaces** en linux, ver: https://panchohumeres.gitlab.io/linux_man/_sections/networking.html

.. _redirección_de_puertos:

Redirección de Puertos
----------------------------------------------

**Referencias**: https://pythonspeed.com/articles/docker-connection-refused/

Al correr Docker con la opción **\\"-p 5000:5000\\"**, redireccionará desde todas las interfaces donde el **\\"deamon\\"** (i.e. proceso) está corriendo, a la **IP externa** del contenedor.
Esto significa:

    - Redirigir tráfico desde el **puerto 5000** en **todas las interfaces** del **namespace default**, al puerto 5000 de la **interfaz externa** del contenedor.
    - **\\"8080:80\\"** p.ej. mapea el puerto 8080 en **todas las interfaces** del **namespace default** con el puerto 80 en la **interfaz externa** del contenedor.

.. code-block:: bash

    $ docker run --rm -p 5000:5000 example
    * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)

Con la opción **\\"--bind\\"**, se escucha en **todas las interfaces del contenedor**: Ejemplo:

.. code-block:: bash

    $ docker run -p 8000:8000 -it python:3.7-slim python3 -m http.server --bind 0.0.0.0

El esquema de conexión desde el browser al localhost sería este:

.. image:: https://d33wubrfki0l68.cloudfront.net/2aa3f7cbeb5bcfc6d8e24903d8c7df97d5693a14/43003/assets/docker-connection-refused/docker-portforward-listen-everywhere.svg
    :alt: localhost-networking

Fuente Imagen: [1]_.

**\\"localhost\\"** en Docker-Compose:
------------------------------------------

**Referencias:** https://github.com/moby/moby/issues/1143

Usar comando Linux para obtener la IP del **localhost**:

    .. code-block:: bash

        ip route | awk '/^default via /{print $3}'

        #Pasar el valor a alguna variable
        export LOCALHOST=$(ip route | awk '/^default via /{print $3}')

Se sugiere incluir este comando en un script **ENTRYPOINT** para **Docker-compose**.



.. [1] Itamar Turner-Trauring, https://pythonspeed.com/articles/docker-connection-refused/

