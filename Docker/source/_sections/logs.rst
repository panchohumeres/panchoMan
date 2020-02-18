=======================
Linux: Revisar RAM
=======================

Comandos Docker para revisar logs de contenedores:
---------------------------------------------------

* **revisar logs de contenedores**<br/>
https://docs.docker.com/compose/reference/logs/
docker-compose logs -f <nombre_contenedor> | tiempo real
docker-compose logs <nombre_contenedor> | opción por defecto
docker-compose logs -f -t | logs de todos los contenedores, con timestamp (opción -t)
docker-compose logs --tail={n-lineas} | mostrar últimas n lineas ("all" para todas)
