=====================================
Networking: Headers
=====================================

Documentación sobre **\\"HTTP(S)\\"** **\\"Headers\\"** o cabeceras.



Autenticación Básica (\\"Basic Authentication\\"):
----------------------------------------------------------

Descripción
^^^^^^^^^^^^^^^^^^^^^^^^

**Referencias:**
    - https://swagger.io/docs/specification/authentication/basic-authentication/

* **\\"Basic Authentication\\"** es un esquema de autorización simple embebido en el protocolo **HTTP**.
* El **cliente** envía **solicitudes** HTTP con la cabecera o **\\"header\\"**: **\\"Authorization\\"**.
* El valor de **\\"Authorization\\"** contiene la palabra **\\"Basic\\"**, seguida de un **espacio** y un **string en base64** de la forma: :code:`username:password`.
* Dado que **base64** es fácil de **decodificar**, se recomienda combinarla con otros mecanismos como **HTTPS/SSL**.
* Ejemplo 1, **Usuario: \\"demo\\", Password: \\"p@55w0rd\\"**, el cliente enviaría la siguiente solicitud:
    :code:`Authorization: Basic ZGVtbzpwQDU1dzByZA==`
* EJemplo 2, Ver: http://shairosenfeld.blogspot.com/2011/03/authorization-header-in-nginx-for.html:

    .. code-block:: bash

        #"user:password" # formato estándar autenticación básica
        http://foo:bar@example.com #EJEMPLO

        #base64
        "dXNlcjpwYXNzd29yZA==" #Ejemplo en Base 64

        #Cabecera completa
        "Basic dXNlcjpwYXNzd29yZA=="

Flujo
^^^^^^^^^^^^^^^^^^^^^^^^

Flujo definido por estándar (RFC 7235)[https://tools.ietf.org/html/rfc7235].
    1. Servidor responde a la solicitud del cliente con :code:`401 (Unauthorized)`.
    2. Devuelve al cliente **información de como autorizarse** con **encabezado de respuesta** :code:`WWW-Authenticate`.
    3. Cliente responde con encabezado de autorización :code:`Authorization: Basic ZGVtbzpwQDU1dzByZA==` (del ejemplo mencionado en el punto anterior).

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/HTTPAuth.png
            :alt: http-basic-auth-flujo

        Fuente Imagen: [1]_.

Herramientas para codificar/decodificar en Base64
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- https://www.base64decode.org/



.. [1] MDN web docs, https://developer.mozilla.org/es/docs/Web/HTTP/Authentication