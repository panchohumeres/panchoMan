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
* Ejemplo, **Usuario: \\"demo\\", Password: \\"p@55w0rd\\"**, el cliente enviaría la siguiente solicitud:
    :code:`Authorization: Basic ZGVtbzpwQDU1dzByZA==`

Flujo
^^^^^^^^^^^^^^^^^^^^^^^^

Flujo definido por estándar (RFC 7235)[https://tools.ietf.org/html/rfc7235].
    1. Servidor responde a la solicitud del cliente con :code:`401 (Unauthorized)`.
    2. Devuelve al cliente **información de como autorizarse** con **encabezado de respuesta** :code:`WWW-Authenticate`.
    3. Cliente responde con encabezado de autorización :code:`Authorization: Basic ZGVtbzpwQDU1dzByZA==` (del ejemplo mencionado en el punto anterior).

        .. image:: https://panchoman.s3-sa-east-1.amazonaws.com/HTTPAuth.png
            :alt: http-basic-auth-flujo

        Fuente Imagen: [1]_.






.. [1] MDN web docs, https://developer.mozilla.org/es/docs/Web/HTTP/Authentication