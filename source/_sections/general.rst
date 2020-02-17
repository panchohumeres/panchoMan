=====================================
Docker: Comandos de utilidad general
=====================================

Comandos Docker generales:
----------------------------------------------

* **matar todos los contenedores (no se pierde la data) --DEL HOST**<br/>
docker-compose stop ----->(preferido)
docker kill $(docker ps -q)-------->para todos los del host (no recomendado)
* **meterse a un contenedor en específico:**<br/>
docker-compose exec <nombre_contenedor> bash
* **borrar un contenedor (se pierde data en el contenedor, si es que no está respaldada en volumen externo):**<br/>
docker-compose rm <nombre_contenedor>
* **borrar TODOS volúmenes asociados (internos):**
docker-compose down -v
* **listar espacio en disco que ocupan contenedores y volúmenes**<br/>
docker system df
docker system df -v | con más detalles
* **resetear todos los contenedores (se borran y recrean los contenedores, si no hay volumen externo montado se pierde la data)**<br/>
docker-compose up --build
* **borrar todos los contenedores**<br/>
docker-compose rm -------->borra todos los contenedores del docker-compose (preferir)
docker rm $(docker ps -a -q)-------------->borra todos los contenedores del host (NO PREFERIR)

* **revisar archivo docker-compose con variables de entorno sustituidas**<br/>
docker-compose config
docker-compose -f <archivo-compose-de-interés-yaml> config