============================
NGINX: Casos Especiales
============================

Documentación de casos o implementaciones particulares

------------------------------------------------------------


Autenticación Básica (\\"basic auth\\") con reverse proxy:
-----------------------------------------------------------------

**Referencias:** http://shairosenfeld.blogspot.com/2011/03/authorization-header-in-nginx-for.html

* **Intro \\"Basic Authorization\\"**, ver: https://panchohumeres.gitlab.io/http_man/_sections/headers.html#autenticacion-basica-basic-authentication
* Ejemplo:
    1. Parámetros Autenticación:
        - username: \\"king\\", password \\"isnaked\\".
        - base64: \\"a2luZzppc25ha2Vk\\".

    2. Bloque de **location** (:ref:`bloque_location`) original:

        .. code-block:: bash

            location / {
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_pass http://6.6.6.6:80;
            }


    3. Agregar la línea: :code:`proxy_set_header Authorization "Basic a2luZzppc25ha2Vk";`
    4. Nuevo bloque, actualizado:

        .. code-block:: bash

            location / {
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_pass http://6.6.6.6:80;
                proxy_set_header Authorization "Basic a2luZzppc25ha2Vk";
            }
    5. Reiniciar servidor NGINX, ver: :doc:`../_sections/utilidad`
