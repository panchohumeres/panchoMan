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