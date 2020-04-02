=====================================
NGINX: Directivas
=====================================

Diccionario de directivas:
    Instrucciones utilizadas en archivos de configuración NGINX (.conf, etc.)

----------------------------------------------


**if**
------------

**Referencias**: http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#if
Evalúa una condición (**condition**), y si es verdadera (**true**), se ejecutan las directivas especificadas entre corchetes **\\"{...}\\"**. La solicitud es redirigida a la directiva al interior del bloque **\\"{.....}\\"**.
    
    - Si es el **nombre de una variable**, se evalúa si **existe**. **\\"false\\"** es un **string vacío** o **\\"0\\"** (cero).
    - **Operadores de nombre de variable**: **\\"=\\" y \\"!=\\"**.

.. code-block:: bash

    if (condition) { ... } #SINTAXIS
    — #DEFAULT (NINGUNO)
    server, location #CONTEXTO

Ejemplos: 

.. code-block:: bash

    if ($http_user_agent ~ MSIE) {
        rewrite ^(.*)$ /msie/$1 break;
    }

    if ($http_cookie ~* "id=([^;]+)(?:;|$)") {
        set $id $1;
    }

    if ($request_method = POST) {
        return 405;
    }

    if ($slow) {
        limit_rate 10k;
    }

    if ($invalid_referer) {
        return 403;
    }


.. _directiva_return:

**return**
---------------

    **Referencias:** http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#return

    Deja de procesar solicitud y responde con el código (**\\"code\\"**) especificado al cliente.
        - Para los códigos **301, 302, 303, 307, y 308** se puede especificar una **URI de redirección**.
        - Para los otros códigos se puede responder con un **texto**.

        Sintaxis:	:code:`return code [text];`
                    :code:`return code URL;`
                    :code:`return URL;`

        Default:	Ninguno

        Contexto: :code:`server, location, if`

    * Parámetros:
        :code:`server_name_in_redirect on | off;`
        Habilita o deshabilita el uso del nombre del servidor especificado por la directiva **server_name**.
        
        - Cuando este parámetro está en **\\"off\\"**, el nombre del **\\"Host\\"** del **header** de la solicitud. Ver: :ref:`como_nginx_procesa_solicitudes`. Si este campo no está presente, se usa la **IP** del servidor.
        - Valor por **defecto**: **\\"off\\"**.
        - Se usa en **redirecciones \\"absolutas\\"** (no relativas): http://nginx.org/en/docs/http/ngx_http_core_module.html#absolute_redirect 
        - Ver: http://nginx.org/en/docs/http/ngx_http_core_module.html#server_name_in_redirect




**server_name**
----------------

    Ver: :ref:`como_nginx_procesa_solicitudes`


**proxy_pass** y relacionados
------------------------------

    Define el protocolo y dirección de un **\\"servidor proxy\\"**.
    Como protocolos se pueden especificar **\\"http\\" o \\"https\\"**.
    Las direcciones se pueden especificar como **dominio** o **dirección IP**.Se puede especificar un *puerto** opcional. Ejemplo:
        
        :code:`proxy_pass http://localhost:8000/uri/;`
    
    También se pueden especificar como **UNIX-domain socket**, después de la palabra **\\"unix\\"** y comillas. Ejemplo:
        
        :code:`proxy_pass http://unix:/tmp/backend.socket:/uri/;`


    Sintaxis:	:code:`proxy_pass URL;`

    Default:	Ninguno

    Contexto: :code:`location, if in location, limit_except`

    Ver: http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_pass

.. _directivas_proxy_pass_relacionadas:

Directivas relacionadas (**proxy_pass**)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* **proxy_ssl_certificate**:

    **Sintaxis**:	:code:`proxy_ssl_certificate file;`
    **Default**:	Ninguno
    **Contexto**:	:code:`http, server, location`

    Especifica un archivo ( :code:`file` )  con el **certificado** en formato **PEM** usado para autenticarse a un **servidor proxy HTTPS**.

* **proxy_ssl_certificate_key**:

    **Sintaxis**:	:code:`proxy_ssl_certificate_key file;`
    **Default**:	Ninguno
    **Contexto**:	:code:`http, server, location`

    Especifica un archivo ( :code:`file` ) con la llave o **\\"key\\"** en formato **PEM** usado para autenticarse a un **servidor proxy HTTPS**.

* **proxy_ssl_trusted_certificate**:

    **Sintaxis**:	:code:`proxy_ssl_trusted_certificate file;`
    **Default**:	Ninguno
    **Contexto**:	:code:`http, server, location`

    Especifica un archivo ( :code:`file` ) con **Autoridades de Certificados** o **\\"CA\\"** en formato **PEM** usado para verificar la autoridad **CA** de un **servidor proxy HTTPS**.

* **proxy_ssl_ciphers**:

    **Sintaxis**:	:code:`proxy_ssl_ciphers ciphers;`
    **Default**:	:code:`proxy_ssl_ciphers DEFAULT;`
    **Contexto**:	:code:`http, server, location`

    - Especifica los métodos de cifrado para las solicitudes al servidor **proxy HTTPS**. Son métodos o algoritumos entendidos por la librería **\\"OpenSSL\\"**.
    - Usar el comando :code:`openssl ciphers` para ver los algoritmos disponibles.

* **proxy_ssl_protocols**:

    **Sintaxis**:	:code:`	proxy_ssl_certificate_key file;`
    **Default**:	:code:`-`
    **Contexto**:	:code:`http, server, location`

    **Habilita** los **protocolos** especificados para las solcitudes a un **servidor proxy HTTPS**.
    


**location**
--------------

    Define configuraciones según una URI de consulta.
    Puede ser definida por **strings** o **expresiones regulares** (precedida en este caso del carácter **\\"~*\\"**.
    Las definiciones de **location** pueden estar **anidadas**.


    Sintaxis:	:code:`location [ = | ~ | ~* | ^~ ] uri { ... }`
                :code:`location @name { ... }`
    
    Default:	Ninguno
    
    Contexto:	:code:`server, location`

    Ejemplo:
        - Solicitud para **\\"/\\"**, va a ser respondida con **configuración A**.
        - Solicitud para **\\"/index.html\\"**, va a ser respondida con **configuración B**.
        - Solicitud para **\\"/documents/document.html\\"**, va a ser respondida con **configuración C**.
        - Solicitud para **\\"/images/1.gif\\"**, va a ser respondida con **configuración D**.
        - Solicitud para **\\"/documents/1.jpg\\"**, va a ser respondida con **configuración D**.

    .. code-block:: bash

        location = / {
            [ configuration A ]
        }

        location / {
            [ configuration B ]
        }

        location /documents/ {
            [ configuration C ]
        }

        location ^~ /images/ {
            [ configuration D ]
        }

        location ~* \.(gif|jpg|jpeg)$ {
            [ configuration E ]
        }

    Ver: http://nginx.org/en/docs/http/ngx_http_core_module.html#location

**listen**
-------------------

    **Referencias**:
        http://nginx.org/en/docs/http/ngx_http_core_module.html#listen

    Forma:

    .. code-block:: bash

        listen address[:port] [default_server] [ssl] [http2 | spdy] [proxy_protocol] [setfib=number] [fastopen=number] [backlog=number] [rcvbuf=size] [sndbuf=size] [accept_filter=filter] [deferred] [bind] [ipv6only=on|off] [reuseport] [so_keepalive=on|off|[keepidle]:[keepintvl]:[keepcnt]];
        listen port [default_server] [ssl] [http2 | spdy] [proxy_protocol] [setfib=number] [fastopen=number] [backlog=number] [rcvbuf=size] [sndbuf=size] [accept_filter=filter] [deferred] [bind] [ipv6only=on|off] [reuseport] [so_keepalive=on|off|[keepidle]:[keepintvl]:[keepcnt]];
        listen unix:path [default_server] [ssl] [http2 | spdy] [proxy_protocol] [backlog=number] [rcvbuf=size] [sndbuf=size] [accept_filter=filter] [deferred] [bind] [so_keepalive=on|off|[keepidle]:[keepintvl]:[keepcnt]];
    
        * Default: :code:`listen *:80 | *:8000;`
        * Contexto: :code:`server` ------------------> dentro de un bloque **server**.

    Configura la **dirección** y **puerto** para la **IP**, o la ruta o **path** para **UNIX-domain socket**, en los cuales el servidor (**server**) aceptará solicitudes.
    Tanto **address** como **port** puede ser especificados en conjunto o por separado.
    Un **address** también puede ser un **hostname**.
    Ejemplo:

    .. code-block:: bash

        listen 127.0.0.1:8000;
        listen 127.0.0.1;
        listen 8000;
        listen *:8000;
        listen localhost:8000;

    Direcciones IPv6 se especifican en corchetes:

    .. code-block:: bash

        listen [::]:8000;
        listen [::1];

    **\\"UNIX-domain sockets\\"** (rutas) son especificadas con el prefijo **"\\unix:"\\**:

        listen unix:/var/run/nginx.sock;

    * Si sólo **address** se especifica, se utiliza por **defecto el puerto 80**.
    * Si es que la **directiva NO existe**, se usa ** *:80** por defecto si nginx corre como **sudo**, o ** *:8000** en caso contrario.


    Parámetros:
        * :code:`default_server`
            Define a cual servidor virtual serán redireccionadas las solicitudes por defecto (si es que campo **\\"Host\\"** de la solicitud del cliente no coincide con ningún **\\"server_name\\"**.
            Ejemplo:

            .. code-block:: bash

                server {
                listen      80 default_server;
                server_name example.net www.example.net;
                ...
                }

            **Referencias**: 
                http://nginx.org/en/docs/http/request_processing.html

                :ref:`como_nginx_procesa_solicitudes`

**server_tokens**
------------------

    Habilita ("on") o deshabilita ("off") emitir versión de NGINX en mensajes de error y el en "Sever response" campo del header.

    .. code-block:: bash

        server_tokens off;

    Ver: https://serverfault.com/questions/696551/how-do-i-check-server-tokens-are-off

            
**upstream**
-----------------
    **Referencias**:
        http://nginx.org/en/docs/http/ngx_http_upstream_module.html

    Permite definir grupos de servidores que puede ser referenciados por directivas como **\\"proxy_pass,fastcgi_pass,uwsgi_pass,scgi_pass,memcached_pass,grpc_pass\\"** etc.

    Configuración de Ejemplo:

    .. code-block:: bash 

        upstream backend {
            server backend1.example.com       weight=5;
            server backend2.example.com:8080;
            server unix:/tmp/backend3;

            server backup1.example.com:8080   backup;
            server backup2.example.com:8080   backup;
            }

            server {
                location / {
                    proxy_pass http://backend;
                }
            }

    Sintaxis: 
    :code:`upstream {name}`
    Define un grupo de servidores. Los servidores pueden escuchar en diferentes puertos. Pueden mezclarse servidores que escuchan en **\\"sockets\\"** **TCP y/o UNIX-domain**.
    Configuración de Ejemplo:
            
        .. code-block:: bash

            upstream backend {
            server backend1.example.com weight=5;
            server 127.0.0.1:8080       max_fails=3 fail_timeout=30s;
            server unix:/tmp/backend3;

            server backup1.example.com  backup;
            }

    * Dentro de la directiva **upstream**: :code:`server address [parameters];` Define la dirección y otros parámetros del servidor. **adress** puede ser un dominio o dirección IP, con un **puerto opcional**.
    * Otros parámetros que se pueden definir:
        * :code:`weight=number`: peso del servidor, para balanceador de carga (default 1)
        * :code:`max_conns=number`: máximo número de conexiones simultáneas permitidas al proxy del servidor (default 0, es decir no hay límite)
        * :code:`max_fails=number`:
            máximo de número permitido de intentos NO exitosos por conectarse con el servidor
            Intento no exitoso es definido por el parámetro "fail_timeout"
            Default == 1
        * :code:`fail_timeout=time`: período de tiempo desde consulta al servidor sin respuesta a partir del cual se considera no disponible
        * :code:`backup`:
            Flag que indica si el servidor es "backup"
            Si es "backup" se le van a redirigir consultas si los servidores "primarios" no están disponibles.
        * :code:`down`: Flag que indica que el servidor no está disponible
        * :code:`resolve`:
            Monitorea cambios de las IP correspondientes al nombre de dominio de un servidor, y automáticamente actualiza la configuración **upstream**.
            Evita la necesidad de resetear el servidor.
            Para que éste parámetro funciones, la directiva **resolver** debe estar especificada en el bloque **\\"http\\"** correspondiente en el bloque **upstream**.
        * :code:`ip_hash;`:
            Especifica que el grupo de servidores dentro del contexto de **upstream**, debe usar un balanceador de carga en base a las IP del cliente.
            Este método asegura que el mismo cliente siempre será redireccionado al mismo servidor, salvo que no esté disponible.
            Si el servidor no está disponible, las consultas del cliente serán pasadas a otros servidor (en la mayoría de los casos el mismo servidor).
            Configuración de Ejemplo:

            .. code-block:: bash

                upstream backend {
                    ip_hash;

                    server backend1.example.com;
                    server backend2.example.com;
                    server backend3.example.com down;
                    server backend4.example.com;
                }
        * :code:`resolver address ... [valid=time] [ipv6=on|off] [status_zone=zone];`:
            Configuración de los nombres de servidores utilizados para resolver nombres de servidores **upstream** en direcciones IP, por ejemplo:
            
            .. code-block:: bash

                resolver 127.0.0.1 [::1]:5353;

                #NGINX cachea los valores usando el valor TTL de una respuesta. El parámetro "valid" permite sobreescribirlo:
                resolver 127.0.0.1 [::1]:5353 valid=30s;

            Ver: https://searchnetworking.techtarget.com/definition/time-to-live

            La dirección puede ser especificada como nombre de dominio o dirección IP, con un puerto opcional.
            Si el **puerto NO es especificado**, se usar el 53.
        * :code:`resolver_timeout time;`: Timeout para resolución de nombres. Por ejemplo: :code:`resolver_timeout 5s;`. Default es 30s.


            



