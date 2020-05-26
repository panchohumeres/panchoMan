=====================================
NGINX: Fundamentos
=====================================

.. _como_nginx_procesa_solicitudes:

Cómo NGINX procesa solicitudes:
----------------------------------------------

**Referencias:** http://nginx.org/en/docs/http/request_processing.html

* Servidores virtuales en base a **\\"Nombres\\"**:
    NGINX primero decide cual servidor, definido con la directiva :code:`server {....}`, procesará la solicitud o consulta.
    Ejemplo de tres servidores virtuales que escuchan en el puerto 80:

    .. code-block:: bash

        server {
            listen      80;
            server_name example.org www.example.org;
            ...
        }

        server {
            listen      80;
            server_name example.net www.example.net;
            ...
        }

        server {
            listen      80;
            server_name example.com www.example.com;
            ...
        }

    1. En este ejemplo, NGINX prueba solamente el campo **\\"Host\\"** del **header** o cabecera de la solicitud o **\\"request\\"** del servidor.
    2. Si es que el valor de **\\"Host\\"** == algún nombre de servidor (directiva **\\"server_name\\"**), redirige al servidor correspondiente.
    3. Si es que el valor **\\"Host\\"** **NO coincide** con algún nombre de servidor (directiva **\\"server_name\\"**): Redirige al servidor por defecto, en este caso el primero (compartamiento estándar de NGINX).

    * Sobre campo  **\\"Header\\"** del request:
        .. code-block:: bash

            Host: <host>:<puerto>

            <host> #NOMBRE DEL DOMINIO DEL Servidor PARA VIRTUAL HOSTING (PUEDE SER UNA IP)
            <puerto> #PUERTO (OPCIONAL)--->PUERTO EN QUE ESTÁ ESCUCHANDO (DEFECTO 80)
        
        Ver lo que es el campo **\\"Host\\"** del **header** del **request** acá: 
            - https://developer.mozilla.org/es/docs/Web/HTTP/Headers/Host
            - https://stackoverflow.com/questions/50321842/http-is-an-ip-address-allowed-in-the-host-header-field


*   Servidores virtuales en **\\"MIXTOS\\"**: con **Nombres de Dominios y/o IPs**:
        Ejemplo donde los **servidores virtuales** escuchan a diferentes IP. 
        
        1. En este configuración, NGINX prueba las solicitudes contra las directivas **listen** dentro de los bloques **server**.
        2. Luego prueba campo  **\\"Header\\"** de la solicitud, contra las entradas **server_name** dentro de los bloques **server**.
        3. Si es que **NO** se encuentra **server_name**, la solicitud va a ser tomada por el servidor por **defecto**.
        4. En este caso el servidor por defecto es el primero.
         
            .. code-block:: bash

                server {
                    listen      192.168.1.1:80;
                    server_name example.org www.example.org;
                    ...
                }

                server {
                    listen      192.168.1.1:80;
                    server_name example.net www.example.net;
                    ...
                }

                server {
                    listen      192.168.1.2:80;
                    server_name example.com www.example.com;
                    ...
                }

        5. También se pueden definir servidores por defecto con la directiva **default_server**. Se pueden definir diferentes servidores por **defecto** para diferentes puertos. Ejemplo:

            .. code-block:: bash

                server {
                    listen      192.168.1.1:80;
                    server_name example.org www.example.org;
                    ...
                }

                server {
                    listen      192.168.1.1:80 default_server;
                    server_name example.net www.example.net;
                    ...
                }

                server {
                    listen      192.168.1.2:80 default_server;
                    server_name example.com www.example.com;
                    ...
                }

Redirección:
-----------------

    La manera más simple y efectiva de rediccionar es utilizando la **directiva \\"return\\"**. Más info de la directiva en: :ref:`directiva_return`.
    Se utiliza comúnmente para redireccionar de **http a https**.
    En este caso la solicitud se:
        
        1. Deja de procesar.
        2. Se responde con el código 301 (ver ejemplo). Éste código le dice al browser del cliente que es una **redirección permanente** (lo que hace al browser recordar la dirección, así como los motores de búsqueda).
        3. Dado que este código permite redireccionar a una URI o URL, se apendiza ésta.
    
    Ejemplo:

        .. code-block:: bash

            server {
                listen 80;
                listen [::]:80;
                hostname example.com www.example.com;
                return 301 https://example.com$host$request_uri;
            }

    En este ejemplo todas las solicitudes para **\\"http://example.com\\" o \\"http//www.example.com\\"** son **redirigidas** a **\\"https://example.com\\"**.

    **Referencias:**
        - https://bjornjohansen.no/nginx-redirect
        - https://bjornjohansen.no/redirect-to-https-with-nginx 
        - Ver: :ref:`directiva_return`       


Orden de lineas i.e. Comandos
--------------------------------

**Referencias:** https://serverfault.com/questions/836504/does-order-of-lines-matter-in-nginx

El **ORDEN IMPORTA** en los comandos dentro de directivas, dependiendo del **CONTEXTO**.
P.ej:

    .. code-block:: bash

        server {
        listen 80;
        server_name subdomain.example.com;

        return 301 https://$server_name$request_uri;

        location /.well-known/acme-challenge {
                root /var/www/letsencrypt;
            }
        }

Este ejemplo **falla** debido a que la directiva **\\"return\\"** para el proceso, **dejando sin efecto la directiva \\"location\\" a continuación**.
