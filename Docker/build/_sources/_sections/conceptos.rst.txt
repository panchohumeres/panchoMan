=====================================
Docker: Conceptos y Aclaraciones
=====================================

Conceptos:
    Conceptos de Docker y aclaraciones.
    
----------------------------------------------

* **Especificar volúmenes en Dockerfile y en mapeo**

    **Referencias:**
        https://forums.docker.com/t/whats-the-difference-between-adding-volume-in-a-dockerfile-and-running-an-image-with-volume/17480/6
    
    Tienen exactamente el mismo efecto. Por convención se incluye directorio a ser montado como volumen dentro del contenedor en Dockerfile, como guía para recordar que debe ser mapeado a un volumen externo.

* **Workdir:**
    
    * Especifica directorio donde cualquier commando RUN, CMD, ENTRYPOINT, COPY y ADD que siguen en el Dockerfile se ejecutan.
    * Si no existe el directorio es creado.
    * Puede ser usado múltiples veces en un Dockerfile.
    * Si se especifica una ruta relativa, ésta será relativa en relación a la directiva WORKDIR anterior.
