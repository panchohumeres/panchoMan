=======================
Linux: Bash Arrays
=======================

Conceptos y ejemplos de arrays en Bash Scripting:

----------------------------------------------

* **Referencias:**
    https://tecadmin.net/working-with-array-bash-script/

-------------------------------------------

* Definir un Array:

    Declarándolo:

    .. code-block:: bash

        declare -a test_array

    Asignando elementos (no es necesario declararlo):

    .. code-block:: bash

        test_array=(apple orange lemon)

* Agregar nuevos elementos a un array:
    Usando operador **"+="**:

    .. code-block:: bash

        test_array+=(mango banana)

* Actualizar elemento de un array:

    .. code-block:: bash

        test_array[2]=grapes

* Borrar elemento de un array:

    .. code-block:: bash

        unset test_array[2]

* Acceder elementos de un Array:

    .. code-block:: bash

        echo ${test_array[0]}

    Para acceder a **todos** los elementos, usar **@**:
    
    .. code-block:: bash

        echo ${test_array[@]}

* Loop (recorrer elementos) de un array:

    .. code-block:: bash

        for i in ${test_array[@]}
        do
            echo $i
        done

