=====================================
Docker: ENTRYPOINT, CMD Y RUN
=====================================

Troubleshooting

---------------------------------------

* **Error "permission denied"**:
    * **Referencias**:
        https://stackoverflow.com/questions/38882654/docker-entrypoint-running-bash-script-gets-permission-denied/38882798

    1. Verificar permisos de script: 

        .. code-block:: bash
            
            ls -la path/to/directory

    2. Output debería ser similar a este, si falta x al final...

        .. code-block:: bash

            -rwxrwxr-x

    3. Cambiar permiso del script
        
        .. code-block:: bash

            chmod +x docker-entrypoint.sh

    * **NOTA**: Los contenedores docker usan su propio sistema de archivos, pero copian todo, **incluyendo los permisos** de los archivos en los volúmenes montados.

* Errores de sintaxis:
    * **Dentro** del script se usa **"&&"** para separar condiciones, y cuando se ingresa **el comando escapado como string** en Docker-compose **.yaml es sólo "&"**.

**OJO!!**: Método **bash o \\"entrypoint\\" NO está testeado**, **preferir** método **Dockerfile**. Método bash genera problemas de networking entre contenedor y el host, ver:
    - :ref:`redirección_de_puertos`
    - :ref:`connection_refuse_connection_rest_by_peer`    
            
