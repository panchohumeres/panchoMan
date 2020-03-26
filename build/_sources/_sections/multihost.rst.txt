=====================================
NGINX: Múltiples Host
=====================================

Ejemplos de configuraciones NGINX:
    Para múltiples host, virtual host o IPs.

----------------------------------------------

* Escuchar varios puertos:
    * **Referencias**: https://serverfault.com/questions/655067/is-it-possible-to-make-nginx-listen-to-different-ports
    
    1. Dos servidores:

        .. code-block:: bash

            server {
            listen       80;
            server_name  example.org  www.example.org;
            root         /var/www/port80/
            }

            server {
                listen       81;
                server_name  example.org  www.example.org;
                root         /var/www/port81/
            }

    2. En un mismo servidor:

            .. code-block:: bash

                server {
                    listen 80;
                    listen 8000;
                    server_name example.org;
                    root /var/www/;
                }