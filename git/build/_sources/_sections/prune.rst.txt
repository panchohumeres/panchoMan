=====================================
Docker: Borrar o purgar contenedores
=====================================

Comandos Docker para borrar o purgar contenedores:
----------------------------------------------

**CON MUCHO CUIDADO!!!!**:
	docker container prune------->BORRA CONTENEDORES PARADOS
	docker volume rm wenu_certs------->BORRA VOLUMEN EN CONFLICTO

* **Para solucionar errores tipo: "Error response from daemon: Conflict: volume is in use | Error response from daemon: unable to remove volume: remove uuid: volume is in use"**: 
https://stackoverflow.com/questions/34658836/docker-is-in-volume-in-use-but-there-arent-any-docker-containers/52326805