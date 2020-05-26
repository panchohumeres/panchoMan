=====================================
Docker: Troubleshooting
=====================================

.. _connection_refuse_connection_rest_by_peer:

\\"Connection refused\\" o \\"Connection reset by peer\\"
-------------------------------------------------------------------

**Referencias**: https://pythonspeed.com/articles/docker-connection-refused/

**Problema**: Esto se produce por que la red del contedor no se está conectando con la red del host, i.e. no hay redireccionamiento de tráfico. 
Ver: :ref:`redirección_de_puertos`
Como se muestra en el diagrama, esto ocurre en casos en que el **contenedor** está escuchando en la **IP de la red interna**, mientras que la redirección del puerto está llendo hacia **la IP de la red externa del contenedor**.
En este **ejemplo**, el **contenedor** está escuchando en **\\"127.0.0.1\\"**, mientras que la **redirección** del puerto está llendo hacia **\\"127.17.0.2\\"**.

    .. image:: https://d33wubrfki0l68.cloudfront.net/eb92be77f9c223f325cc5937105548e9c0c2111e/b72c8/assets/docker-connection-refused/docker-portforward.svg
        :alt: localhost-networking

    Fuente Imagen: [1]_.

**Solución**:
    Usar opción :code:`--bind` + valor **\\"0.0.0.0\\"**. Esto significa que la red del **contenedor** escuchará en **todas las interfaces**.
    Ejemplo:

    .. code-block:: bash

        $ docker run -p 8000:8000 -it python:3.7-slim python3 -m http.server --bind 0.0.0.0

    Ejemplo de solución don Dockerfile de Flask:
    
    .. code-block:: bash

        FROM python:3.7-slim-stretch
        RUN pip install flask
        COPY . .
        ENV FLASK_APP=exampleapp:app
        CMD ["flask", "run", "--host", "0.0.0.0"]

\\"bash command unexpected EOF while looking for matching\\"
-------------------------------------------------------------------

**Referencias**: https://stackoverflow.com/questions/52515680/bash-command-unexpected-eof-while-looking-for-matching

**Solución**:
   Código mal escapado. Se debe incluir **\\'** dentro de **\\"**. 


Un contenedor se cierra inesperadamente después de ENTRYPOINT
-------------------------------------------------------------------

**Referencias**: https://stackoverflow.com/questions/39864106/docker-interactive-mode-exits-after-entrypoint

**Solución**:
   **ENTRYPOINT / CMD ** tiene que ejecutar un script que se mantenga en el largo plazo, o se cerrará y con esto al contenedor. 


.. [1] Itamar Turner-Trauring, https://pythonspeed.com/articles/docker-connection-refused/

