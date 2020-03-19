========================================
Linux: Bash $ y Expansión de Parámetros
========================================

Bash:
    Expansión de Parámetros: Conceptos

=======================================

* **Referencias**:
        * https://www.gnu.org/software/bash/manual/htmlnode/Shell-Parameter-Expansion.html
        
* El carácter **\\"$\\"** introduce expansión de parámetros, substitución de comandos, o expresión aritmética.
* Forma convencional:
    :code:`${parameter}`
    El valor de **parameter** es sustituido. **parameter** es un parámetro del shell como se describe anteriormente, o una referencia a un array.
* El nombre del parámetro o símbolo puede estar contenido en corchetes, i.e. **\\"{}\\"**, los sirven para proteger la variable a ser expandida de otros carácteres que le siguen inmediatamente, y no sean confundidos como un string o parte del nombre de la variable.
* Los corchetes **\\"{}\\"** son **REQUERIDOS** si es que el **parámetros** es **posicional y con más de un dígito.**
* **SI ES QUE NO HAY OTRO TEXTO CONTIGUO**, los corchetes **\\"{}\\"** son **OPCIONALES**.
* Si es que el **primer carácter** de **parameter** es un signo de exclamación, i.e. **!**, y **NO es un nameref** (Ver: :doc:`../_sections/shell-parameters-bash`), se conoce como **\\"expansión indirecta\\"**:
    1. Bash usa el valor formado por el resto del **parameter** como un **\\"nuevo\\" parameter**.
    2. Luego este **\\"nuevo" parameter** es expandido, y este valor es utilizado en el resto de la expresión, en lugar del parámetro original.
    Ejemplo:
        ** Ref:** http://ahmed.amayem.com/bash-indirect-expansion-exploration/

        .. code-block:: bash

            fn()
            {
                echo ${!1}
            }
            fn x

        Resultado Esperado:

        .. code-block:: bash

            $ ./indirect.sh
            2

        Explicación: 

        .. code-block:: bash

            ${!1} 
            #ES:
            ${x}

* Si es que el **primer carácter** de **parameter** es un signo de exclamación, i.e. **!**, y **ES un nameref** (Ver: :doc:`../_sections/shell-parameters-bash`):
    1. Se expande al valor de la variable referenciada por **parameter**, en lugar de la "expansión indirecta".

----------------------------------------------

Bash:
    Usos del signo $.

    **Referencia**: https://stackoverflow.com/questions/10870719/inline-code-highlighting-in-restructuredtext

======================================================================================================================

* :code:`$1, $2, $3` 
    Parámetros posicionales

* :code:`"$@"` 
    Parámetros posicionales, como array: i.e. la forma: 
        {$1, $2, $3 ...}.

* :code:`"$*"` 
    "Expansión" **IFS** de parámetros posicionales. P.ej (IFS='|'): "$1|$2|$3".
    Ver: https://bash.cyberciti.biz/guide/$IFS

* :code:`$#` 
    El número de parámetros posicionales.

* :code:`$-` 
    Número de opciones para el "Shell" actual.

* :code:`$$` 
    "Process ID" **(PID)** del actual "Shell" (**NO** sub-shell).

* :code:`$`
    Parámetro más reciente.

* :code:`$IFS`
    Separador o delimitador de parámetros en string de entrada (input). Ver: :doc:`../_sections/strings-bash`

* :code:`$?`
    Status más reciente anterior a un "exit".

* :code:`$!` 
    PID del comando más reciente ejecutado en el background.

* :code:`$0` 
    El nombre del shell o script shell.

