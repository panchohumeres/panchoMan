=======================
Linux: Bash
=======================

Ejemplos de pasar argumentos en scripts Bash:

----------------------------------------------

* **Referencias:**
    https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
    https://www.poftut.com/how-to-pass-and-parse-linux-bash-script-arguments-and-parameters/

-------------------------------------------

* **Caso 1**, while LOOP: 

-------------------------------------------

    .. code-block:: bash

        #!/bin/bash
        PARAMS=""
        while (( "$#" )); do
            case "$1" in
                -f|--flag-with-argument)
                    FARG=$2
                    shift 2
                    ;;
            --) # end argument parsing
                shift
                break
                ;;
            -*|--*=) # unsupported flags
                echo "Error: Unsupported flag $1" >&2
                exit 1
                ;;
            *) # preserve positional arguments
                PARAMS="$PARAMS $1"
                shift
                ;;
        esac
        done
        # set positional arguments in their proper place
        eval set -- "$PARAMS"      

-------------------------------------------

* **Caso 2**, usando getopts: 

-------------------------------------------

    .. code-block:: bash

        #!/bin/bash 
 
        while getopts u:p: option 
        do 
            case "${option}" 
            in 
            u) USER=${OPTARG};; 
            p) PASSWORD=${OPTARG};; 
            esac 
        done 
 
        echo "User:"$USER 
        echo "Password:"$PASSWORD 

    probarlo:

    .. code-block:: bash

        $ ./myscript.sh -u ismail p poftut

    resultado esperado:

    .. code-block:: bash

        User:ismail
        Password:poftut
