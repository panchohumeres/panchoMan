=======================
Linux: Espacio en disco
=======================

Comandos linux para revisar espacio en disco:
----------------------------------------------

* du -sh <directorio> | obtener en "formato human-readable" espacio ocupado por un directorio
* df -BG | obtener listado de particiones y espacio ocupado en GB
* du -ah | obtener en "formato human-readable" espacio ocupado por un directorio y sus archivos contenidos
* du -sh ./*/ | mostrar espacio ocupado en megabytes por un directorio*
* stat <directorio> | mostrar días de creación y última modificación de una carpeta o archivo
* ls -lah | listar archivos con espacio en disco en MB
* free -m | revisar memoria ocupada