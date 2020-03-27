=====================================
Networking: CORS
=====================================

¿Qué es CORS?
================

* **C** ross **O** rigin **R** esource **S** haring.
* Una solicitud por un recuro (p.ej. una imagen o font), disponible afuera del el servidor que se está consultando, se incurre en **\\"cross-origin request\\"**.
* **CORS** es el protocolo para manejar este tipo de solicitudes.
* **CORS** permite a los **servidores** especificar quien (i.e. cuales **\\"orígenes\\") puede **acceder a los recursos del servidor**, entre otras cosas.
* Una política CORS permite especificar que **orígenes** acceden a sus recursos, y cuales **protocolos** y **métodos http** (\\"GET\\",\\"PUT\\",\\"PATCH\\",\\"DELETE\\") están permitidos para accederlos.

.. image:: https://s3.amazonaws.com/codecademy-content/articles/what-is-cors/cross-origin.svg
    :alt: esquema-cors

Fuente Imagen: [1]_.


¿Qué es una política de Seguridad?
-------------------------------------

* Cuando se consulta una página web, app, imagen, etc., se consultan en un servidor.
* Éstas políticas le dicen al **browser** si el **servidor permite consultar** recursos **sólo alojados en el mismo servidor, o de otra URL**.
* Ejemplo, política **\\"same-origin\\"**:
    Política más restrictiva. Con esta política, contenido alojado en servidor **\\"A\\"** sólo puede **interactuar** con contenido en servidor **\\"A\\"**.
    
        .. code-block:: bash

            http://www.example.com/foo-bar.html #URL 1

            http://www.example.com/hello-world.html #URL 2

            https://www.en.example.com/hello.html #URL 3

    - Navegar a **URL 2** desde **URL 1**, está **permitido**, por que el **protocolo** (\\"http\\"), **host** (\\"example.com\\"), y **puerto** (\\"80\\", por defecto en este caso), **coinciden**.
    - Navegar a **URL 3** desde **URL 2**, **NO está permitido**, dado que el **protocolo** (\\"https\\"), y **host** (\\"en.example.com\\") **no coiciden**.
    - La última consulta **podría ser permitida con una política CORS**.

\\"Headers\\" CORS
-------------------------------------

.. code-block:: bash

    Access-Control-Allow-Origin
    Access-Control-Allow-Credentials
    Access-Control-Allow-Headers
    Access-Control-Allow-Methods
    Access-Control-Expose-Headers
    Access-Control-Max-Age
    Access-Control-Request-Headers
    Access-Control-Request-Method
    Origin

* :code:`Access-Control-Allow-Origin`:

    - Este header permite a los servidores **especificar** cómo sus **recursos** son compartidos con **dominios externos**.
    - Cuando una solicitud :code:`GET` se hace para acceder al recurso en **Servidor A**, éste va a responder con un valor para el **\\"Header\\"** :code:`Access-Control-Allow-Origin`.
    - Cuando el **valor del header** es :code:`*`, el **servidor A** va a compartir los **recursos solicitados** con **cualquier** dominio.
    - En ocasiones, el **valor del header** puede ser un **dominio en particular** (o **lista de dominios**).

\\"Pre-flight Headers\\"
-------------------------------------

Para cualquier de los siguientes **métodos http**, una solicitud **\\"pre-flight\\"** se ejecutará **previamente** a la solicitud propiamente tal.

.. code-block:: bash

    PUT
    DELETE
    CONNECT
    OPTIONS
    TRACE
    PATCH

* **\\"pre-flight\\"** usa el header :code:`OPTIONS`. 
* Si el servidor indica que el método en particular definido en **OPTIONS**, se procederá con la consulta original.
* También aplica para otros métodos como \\"user-agent\\".

.. image:: https://s3.amazonaws.com/codecademy-content/articles/what-is-cors/preflight.svg
    :alt: esquema-cors-completo

Fuente Imagen: [1]_.




.. [1] CodeAcademy, https://www.codecademy.com/articles/what-is-cors
