========================================
Linux: Bash y Parámetros del Shell
========================================

Bash:
    Parámetros: Conceptos

----------------------------------------------

* **Referencias:**
    https://www.gnu.org/software/bash/manual/htmlnode/Shell-Parameters.html

* A una variable se le puede asignar el nombre de la forma:
    :code:`nombre=valor`
    Si el **valor** **NO** se especifica, se le asigna un **string null**.

* Cuando se le aplica el operador **"+="** a una variable:
    * Si es un **integer**, se le suma el **valor**.
    * Si es un **array**, se le apendiza el **valor** como el último elemento. Ver: :doc:`../sections/arrays-bash`
    * Si es un **string**, se le apendiza el **valor** al string.

* **nameref**:
    * Referencia a otra variable.
    * Cualquiere operación aplicada sobre **nameref** se le aplica a la variable referenciada.
    * Forma de declararla:
        
        .. code-block:: bash
            
            declare -n ref=$1

        En este caso "**ref**" es el nombre de la variable que hace referencia a otra.