=====================================
Networking: Códigos HTTP
=====================================

.. _301_movido_permanentemente:

301 Movido Permanentemente
--------------------------------

* **\\"Status 301 Moved Permanently\\"**, indica que el recurso ha sido movido permanentemente a la **URL** dada por el **header \\"Location\\"**.
* El browser redirege a esta nueva URL y actualiza sus links.
* Se recomienda utilizarlo sólo con métodos **\\"GET\\"** o **\\"HEAD\\"**.
* Ver: https://developer.mozilla.org/es/docs/Web/HTTP/Status/301


401 Unauthorized
--------------------------------

* **\\"401 Unauthorized\\"**, indica que el servidor **rechaza** la conexión por **autenticación inválida o ausente**.
* Éste código se envía junto con el **Header** :code:`WWW-Authenticate`, con **instrucciones** para autenticarse correctamete.
* Éste código es similar a :code:`404`, **sin embargo**, indica que autenticación **es posible**.
* Ver: https://developer.mozilla.org/de/docs/Web/HTTP/Status/401