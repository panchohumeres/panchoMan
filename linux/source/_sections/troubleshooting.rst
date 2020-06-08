=====================================
LINUX: Troubleshooting
=====================================

Problemas comunes en Linux y como resolverlos:

----------------------------------------------

    *  //"ls: cannot open directory: Permission denied//"
        Causado por que usuario no tiene permisos en directorio padre. Solución:

        .. code-block:: bash

            sudo chmod go+x /path/to/the

        **Referencia:** https://askubuntu.com/questions/850227/ls-cannot-open-directory-permission-denied