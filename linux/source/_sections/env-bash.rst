================================
Linux: Bash
================================


Variables de Entorno

-------------------------------------------


Pasar variables de entorno desde un archivo de texto
-------------------------------------------------------

**Referencias:**
    - https://unix.stackexchange.com/questions/79064/how-to-export-variables-from-a-file

1. Crear archivo de texto con variables de entorno, con formato:

    .. code-block:: bash

        variable1=contenido1
        variable2=contenido2

        #se recomienda NO incluir comentarios

2. En script bash:

    .. code-block:: bash

        set -a
        . ./tmp.txt
        set +a

