=====================================
Kibana: Casos Especiales
=====================================

Ejemplos de configuraciones para Casos de Uso Especiales.

---------------------------------------------------------------


Front-end by-paseando pantalla de autenticación
---------------------------------------------------------------

Front-end auto-autenticado protegido con SSL, usando NGINX.

**Referencias:**
    - https://serverfault.com/questions/828130/how-to-run-nginx-ssl-on-non-standard-port
    - https://discuss.elastic.co/t/auto-authenticating-to-iframe-embedded-kibana-dashboard/46091
    - https://medium.com/@saurabhiiti123/anonymous-access-to-kibana-dashboard-using-nginx-a-workaround-a1896b44c4c8

Ejemplo basado en configuración **Certbot** (Let's Encrypt), con protección automatizada SSL para contenedores Docker:
    - https://panchohumeres.gitlab.io/ssl_tsl_man/_sections/certbot-docker.html
    - https://github.com/panchohumeres/nginx-certbot
    - https://panchohumeres.gitlab.io/nginx_man/_sections/cases.html#ssl-y-proxy

Ejemplo de **variables de entorno** (reemplazar usando envsubst).
    Ver: https://panchohumeres.gitlab.io/nginx_man/_sections/docker.html#templating-de-configuracion-caso-2

.. code-block:: bash

    DOMAIN_KIBANA=kibana.mydomain.com
    SERVER_NAME_KIBANA=kibana
    KIBANA_GUEST_PORT=8080

Ejemplo de archivo de configuración NGINX (**\\"nginx.conf\\"**).

.. code-block:: bash

    upstream ${SERVER_NAME_KIBANA} {
            ip_hash;
            server ${LOCALHOST}:${KIBANA_PORT} fail_timeout=5580s max_fails=1000;
    }


    server {
            listen 80;
            server_name ${DOMAIN_KIBANA};
            server_tokens off;
            #return 301 https://$host$request_uri;
                location /.well-known/acme-challenge/ {
            root /var/www/certbot;
        }
            
            location / {
                proxy_pass http://${SERVER_NAME_KIBANA};
            }

    }


    server {
        listen 443 ssl;
        server_name ${DOMAIN_KIBANA};
        server_tokens off;

        ssl_certificate /etc/letsencrypt/live/${DOMAIN_KIBANA}/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/${DOMAIN_KIBANA}/privkey.pem;
        include /etc/letsencrypt/options-ssl-nginx.conf;
        ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

        location / {
            proxy_pass  http://${SERVER_NAME_KIBANA};
            proxy_set_header    Host                $http_host;
            proxy_set_header    X-Real-IP           $remote_addr;
            proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
        }

    }

    server {
        listen 8080 ssl;
    server_name ${DOMAIN_KIBANA}:${KIBANA_GUEST_PORT};
    server_tokens off;

        ssl_certificate /etc/letsencrypt/live/${DOMAIN_KIBANA}/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/${DOMAIN_KIBANA}/privkey.pem;
        include /etc/letsencrypt/options-ssl-nginx.conf;
        ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

        location / {
        proxy_pass  http://${SERVER_NAME_KIBANA};
            proxy_set_header    Host                $http_host;
            proxy_set_header    X-Real-IP           $remote_addr;
            proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
            proxy_set_header  Authorization ${KIBANA_GUEST_AUTH};
        }

    }
