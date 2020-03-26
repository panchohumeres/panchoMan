=====================================
NGINX: Variables
=====================================

Variables utilizadas en NGINX:

----------------------------------------------

**$host**
-----------

Variable definida por el header del cliente **HTTP Host**.
Ver: 

    - https://bjornjohansen.no/redirect-to-https-with-nginx
    - :ref:`como_nginx_procesa_solicitudes`

**$request_uri**
------------------

URI completa de la solicitud, con argumentos. 
**Excluye** schema (**\\"https\\" o \\"http\\"), **puertos**, y **dominio**.
Ejemplos:

.. code-block:: bash

    ##CASO 1
    https://www.webhosting24.com/understanding-nginx-request_uri/ #URL
    /understanding-nginx-request_uri/ #VALOR DE $request_uri

    ##CASO 2
    https://www.webhosting24.com/cp/cart.php?a=add&domain=register #URL
    /cp/cart.php?a=add&domain=register #VALOR DE $request_uri

    ##CASO 3    
    https://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.2 #URL
    /Protocols/rfc2616/rfc2616-sec3.html #VALOR DE $request_uri
    # ANCHOR #sec3.2 NO SE INCLUYE EN LA VARIABLE

Ver: https://www.webhosting24.com/understanding-nginx-request_uri/



