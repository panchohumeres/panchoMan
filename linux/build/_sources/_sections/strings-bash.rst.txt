=======================
Linux: Bash Strings
=======================

Conceptos y ejemplos para manipular strings en Bash:

-------------------------------------------

* Separar un string y recorrerlos con un loop:
    Uso de variable **"IFS"**.

    .. code-block:: bash

        export IFS=";"
        sentence="one;two;three"
        for word in $sentence; do
            echo "$word"
        done

    **Referencia:**
        https://stackoverflow.com/questions/1406966/linux-shell-script-split-string-put-them-in-an-array-then-loop-through-them