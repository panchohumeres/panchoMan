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


SSL y Proxy:
-----------------------------------------------------------------

Ejemplo que muestra como encriptar tráfico **HTTP** entre NGINX y un bloque :code:`upstream` o **servidores proxy**.

**Basado en:** https://docs.nginx.com/nginx/admin-guide/security-controls/securing-http-traffic-upstream/
**Directivas empleadas:* :ref:`directivas_proxy_pass_relacionadas`

1. En este ejemplo, :code:`https` en la directiva :code:`proxy_pass` especifica que el tráfico **redirigido** por NGINX hacia los bloques :code:`upstream` esté protegida con esquema **\\"https\\"**.
2. Cuando una conexión **segura** (\\"https\\") es pasada por NGINX a :code:`upstream` por primera vez, el proceso de **\\"handshake\\"** completo es ejecutado.
3. Las siguientes **directivas** definen la ubicación de los **certificados** en formato PEM requeridos por el servidor :code:`upstream`. También definen (opcional) protocolos y métodos de encriptación.
    - :code:`proxy_ssl_certificate`
    - :code:`proxy_ssl_certificate_key` 
    - :code:`proxy_ssl_certificate_key`
    - :code:`proxy_ssl_protocols`
    - :code:`proxy_ssl_ciphers`
4. La autoridad(es) **\\"CA\\"** especificada(s) anteriormente son utilizadas para verificar el certificado en :code:`upstream`.
5. La directiva :code:`proxy_ssl_verify_depth` especifica que dos certificados en la cadena de certficados son verificados.
6. Cada vez que NGINX pase una conexión a un bloque :code:`upstream`, los parámetros de la sesión van a ser **reutilizados** gracias a la directiva :code:`proxy_ssl_session_reuse`.

.. code-block:: bash

    http {
        #...
        upstream backend.example.com {
            server backend1.example.com:443;
            server backend2.example.com:443;
    }

        server {
            listen      80;
            server_name www.example.com;
            #...

            location /upstream {

                #LLAMAR AL SERVIDOR UPSTREAM CON HTTPS CON LA DIRECTIVA "proxy_pass"
                proxy_pass                    https://backend.example.com;

                #AGREGAR CERTIFICADOS CON LAS DIRECTIVAS "proxy_ssl_certificate" y "proxy_ssl_certificate_key"
                proxy_ssl_certificate         /etc/nginx/client.pem;
                proxy_ssl_certificate_key     /etc/nginx/client.key;

                #OPCIONAL: DEFINIR PROTOCOLS Y MÉTODOS DE ENCRIPTACIÓN
                proxy_ssl_protocols           TLSv1 TLSv1.1 TLSv1.2;
                proxy_ssl_ciphers             HIGH:!aNULL:!MD5;

                #AGREGAR "CA" (Certificate Authority) CON DIRECTIVA "proxy_ssl_trusted_certificate"
                proxy_ssl_trusted_certificate /etc/nginx/trusted_ca_cert.crt;

                #OPCIONALMENTE INCLUIR DIRECTIVAS "proxy_ssl_verify" Y "proxy_ssl_verify_depth" PARA ...
                #QUE NGINX REVISE LA VALIDEZ DE LOS CERTIFICADOS
                proxy_ssl_verify        on;
                proxy_ssl_verify_depth  2;

                #REUTILIZAR HANDSHAKE EN CACHE (PARA NO HACER UNO NUEVO CON CADA CONEXIÓN, QUE USA MUCHA CPU)
                proxy_ssl_session_reuse on;
            }
        }


        #PARA CADA SERVIDOR MENCIONADO EN "upstream", TAMBIÉN SE DEBEN ESPECIFICAR RUTAS A LOS CERTIFICADOS
        server {
            listen      443 ssl;
            server_name backend1.example.com;

            ssl_certificate        /etc/ssl/certs/server.crt;
            ssl_certificate_key    /etc/ssl/certs/server.key;
            
            #RUTA A CERTIFICADO DE CLIENTE
            ssl_client_certificate /etc/ssl/certs/ca.crt;
            
            ssl_verify_client      optional;

            location /yourapp {
                proxy_pass http://url_to_app.com;
            #...
            }

        server {
            listen      443 ssl;
            server_name backend2.example.com;

            ssl_certificate        /etc/ssl/certs/server.crt;
            ssl_certificate_key    /etc/ssl/certs/server.key;
            ssl_client_certificate /etc/ssl/certs/ca.crt;
            ssl_verify_client      optional;

            location /yourapp {
                proxy_pass http://url_to_app.com;
            #...
            }
        }
    }