============================
NGINX: Troubleshooting
============================

Errores comunes en NGINX y soluciones.

--------------------------------------------

413 Request Entity Too Large
--------------------------------

**Fuente:** https://www.daveperrett.com/articles/2009/11/18/nginx-error-413-request-entity-too-large/

**Causa:** No se ha **ampliado** el tamaño aceptado por **solicitudes** en la configuración.

**Solución:** Usar la directiva **\\"client_max_body_size xxM\\"**, p.ej. :code:`client_max_body_size 20M;`
    Ejemplo:

        .. code-block:: bash

            http {
                include       mime.types;
                default_type  application/octet-stream;
                sendfile        on;
                keepalive_timeout  65;

                server {
                    client_max_body_size 20M;
                    listen       80;
                    server_name  localhost;

                    # Main location
                    location / {
                        proxy_pass         http://127.0.0.1:8000/;
                    }
                }
            }

ssl3_get_record:wrong version number
-----------------------------------------

**Referencias:**
    - https://stackoverflow.com/questions/53245818/nginx-upstream-to-https-host-ssl3-get-recordwrong-version-number
    - https://discuss.konghq.com/t/ssl-errorssl-routineswrong-version-number-while-ssl-handshaking-to-upstream/5298

**Causas**: 
    -En algún bloque de configuración se **redirige tráfico SSL** a puertos como 80, que **sólo permiten HTTP** y **NO HTTPS**.
        Ejemplo:

            .. code-block:: bash

                upstream: "https://<my-web-host-ip-here>:80/v1/some/page"
    
    - **Discordancias en protocolos** entre directivas como **\\"server\\"**, **\\"location\\"**, **\\"proxy_pass\\"** y **\\upstream\\**.

**Solución**: Depende de cada caso, p.ej:
    - Si se está redirigiendo tráfico SSL a un puerto 80:

        .. code-block:: bash

            server remote-hostname:443;

    - Si se está redirigiendo tráfico desde un **\\"proxy_pass\\"** a un servidor **\\"upstream\\"**, procurar que sigan el mismo protocolo.

