================================
Linux: Redirección
================================


Códigos de redirección de output
----------------------------------

**Referencias:**
    - https://unix.stackexchange.com/questions/89386/what-is-symbol-and-in-unix-linux

.. code-block:: bash

    > #Redirección de output a un archivo, sobreescribiéndolo

    >> #Redirección de output a un archivo, apendizando.

    1 #"Standard Output"
    2 #"Standard Error"

    2>&1 #Redirección de "standard error" a "standard output", uniéndolos en un contenido consolidado.


