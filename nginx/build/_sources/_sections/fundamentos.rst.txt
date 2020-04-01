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

Bloques **\\"Server\\"** y **\\"Location\\"**
-------------------------------------------------------------------------------------------

**Fuentes:** https://www.digitalocean.com/community/tutorials/understanding-nginx-server-and-location-block-selection-algorithms


    * Nginx **divide lógicamente** las **configuraciones** destinadas a servir diferentes contenidos (solicitados) en **bloques**, que conviven en una estructura jerárquica.
    * Cada vez que un **cliente** hace una **solicitud**, Nginx comienza un proceso para determinar **cuál(es) bloque(s) de configuración(es) debe(n) ser usados** para manejar la solicitud.
    * **Tipos de soclicitud** pueden ser definidas en base a la IP, dominios y/o puertos solicitados.


server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    * Un **bloque** define un **\\"servidor virtual\\"** usado para manejar **solicitudes de determinado tipo**.
    * La directiva :code:`listen` a cual **IP y puertos** va a responder el **bloque** de **virtualhost** (servidor virtual).
    * La directiva :code:`listen` puede responder a una de las siguientes configuraciones:
        - {IP}:{Puerto}
        - {IP} --------->por defecto escuchará en el puerto 80
        - {Puerto} --------->escuchará en **cualquier interfaz** en ese puerto
        - {URI} --------> ruta a un socket UNIX (generalmente sólo tiene implicancias si se pasan solicitudes entre servidores).
    * El valor por **defecto** de la directiva :code:`listen` es :code:`0.0.0.0:80`.


    A) Como Nginx decide cual bloque \\"server\\" maneja una solicitud (directiva :code:`listen` ):
        1. NGINX revisa la **IP y puerto de la solicitud**.
        2. Las compara con directiva :code:`listen` dentro de cada **virtualhost** (servidor virtual) para construir una **lista de bloques** que pueden responder a la solicitud.
        3. Si no existe directiva :code:`listen`, usar el valor por defecto :code:`listen` es :code:`0.0.0.0:80`.
            Ejemplos:
                - Bloque con valor :code:`listen` de :code:`111.111.111.111` sin puerto escucha al puerto 80, i.e. :code:`111.111.111.111:80`
                - Bloque con valor :code:`listen` de :code:`8888` sin IP se transforma en :code:`0.0.0.0:8888`.
        4. NGINX elabora una **lista** de servidores virtuales que coinciden con la IP y/o puerto de la solicitud (en base a la directiva :code:`listen`).
            - Esto significa que cualquier **bloque** que use `0.0.0.0` como IP en la directiva :code:`listen`, tiene **menor prioridad** en relación a directivas que coincida con **IP y/o puertos** específicos.
            - 
        5. Si es que **hay sólo una coincidencia**, NGINX redirige a ese **virtualhost** o **bloque**.
        6. Si es que hay **múltiples coincidencias**, NGINX procede a **revisar la directiva :code:`server_name`**, (**PASO B**).

    B) Como NGINX decide cual bloque maneja una solicitud en base a **directiva :code:`server_name`**:
        1. NGINX evalúa la lista de **bloques** obtenida del **paso A)**.
        2. NGINX revisa el **header http \\"Host\\"**. Este \\"header\\" contiene el **dominio o IP** al cual la solicitud quiere llegar.
        3. Primero NGINX intenta encontrar una **coincidencia exacta**. Si hay **multiples coincidencias, elige la primera**.
        4. Si **NO se encuentran coincidencias exactas**, NGINX buscará el \\"wildcard\\" :code:`*` al **principio** de los **\\"strings\\"** especificados en las directivas :code:`server_name`. Si se encuentra **una coincidencia exacta, se usa esa**. Si hay **múltipes coincidencias exactas**, se usa el **string más largo**.
        5. Si **NO hay coincidencias según el paso 4**, NGINX buscará el \\"wildcard\\" :code:`*` al **FINAL** de los **\\"strings\\"** especificados en las directivas :code:`server_name`. Si se encuentra **una coincidencia exacta, se usa esa**. Si hay **múltipes coincidencias exactas**, se usa el **string más largo**.
        6. Si **NO hay coincidencias según el paso 5**, NGINX evalúa **bloques** que definan :code:`server_name` usando **\\"expresiones regulares\\"** (indicadas por el \\"wildcard\\" NGINX buscará el \\"wildcard\\" :code:`~` al **principio** de los **\\"strings\\"** especificados en las directivas. El **primer bloque que coincida** será utilizado.
        7. Si es que *NO hay coincidencias en ninguno de los casos anteriores**, NGINX utiliza el bloque por **defecto**.

.. _bloque_location:

location
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Un **bloque** location existe **dentro de un bloque \\"server\\"**, y define como NGINX debe manejar diferentes **solicitudes** para distintos **recursos y URIs** para el servidor virtual (ie. **\\"parent\\"**). El modelo para subdividir el **espacio de URIs** es bastante flexible.

Locaciones:
    * Forma:
    
        .. code-block:: bash

            location optional_modifier location_match {

                . . .

            }

        :code:`location_match` define la URI para buscar coincidencias. Posibles **valores** para :code:`optional_modifier`:
            - **Ninguno**: La locación es interpretada como **prefijo** (la coincidencia se evalúa en base al **principio de la URI**).
            - :code:`=:`: Se considera coincidencia si la **URI solicitad coincide exactamente con la locación**.
            - :code:`~:`: Importan **UPPERCASE** o **lowercase** (mayúscula o minúscula) para evaluar las coincidencias.
            - :code:`~*`: **NO** importan **UPPERCASE** o **lowercase** (mayúscula o minúscula) para evaluar las coincidencias.
            - :code:`^~`: **NO se evalúan expresiones regulares**, si es que el **bloque** es seleccionado como la mejor coincidencia **sin expresiones regulares**.


    * Como NGINX elige :code:`location`(s):
        1. Busca todas las coincidencias **SIN expresiones regulares**.
        2. Busca una **coincidencia exacta**. Si una locación tiene el operador :code:`=`, este **bloque** es inmediatamente seleccionado.
        3. Si **NO** se cumple caso **2**, NGINX busca **coincidencias no-exactas de prefijos**. Encuentra el prefijo **más largo para evaluar**.
        4. Si se cumple caso **3**, y tiene el operador :code:`^~`, NGINX **para la búsqueda** y **selecciona** esta locación.
        5. Si se cumple caso **3**, y **NO** tiene el operador :code:`^~`, NGINX **guarda la conincidencia**, y procede.
        6. NGINX busca **expresiones regulares**.
        7. Si se cumple **6** y **3** (dentro de la **expresión regular**), NGINX la sube como **primera prioridad** de locación.
        8. NGINX **elige la primera** locación que cumpla el caso **7**.
        9. Si no se cumplen **6, 7 y 8**, la locación guardada en paso **5** es ocupada para servir la solicitud.

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
