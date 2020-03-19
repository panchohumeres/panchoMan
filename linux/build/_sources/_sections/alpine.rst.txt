========================================
Linux: Alpine Linux
========================================

Introducción:
=============
    Alpine es una distribución de Linux pequeña (lightweight), comúnmente utilizadas en imágenes Docker. 
    Principales características:
        * Usa **\\"apk\\"** como administrador de paquetes (equivalente a apt o yum).
        * Usa **\\"sh\\"** como Shell (en lugar de bash u otros similares).
        * **NO USA \\"systemd\\" ni \\"service\\"** para administrar **servicios** (utilizados en Debian).
        * Usa **\\"OpenRC\\"** para **administrar servicios**.

    **Referencias:** https://www.client9.com/article/docker-and-alpine-linux-and-systemd/

---------------------------------------------------------------------------

Tips para instalar paquetes comunes en otras distribuciones de Linux:

* apk add openrc | instalar **OpenRC**.
* Bash:

    .. code-block:: bash

        apk update && apk add bash
        #Ó
        apk add --update bash

Comandos para administrar servicios:
=====================================

* **Referencias:** https://www.cyberciti.biz/faq/how-to-enable-and-start-services-on-alpine-linux/

* Ver status de todos los servicios:

    .. code-block:: bash

        rc-status

        #RESULTADO ESPERADO

        Runlevel: default
        crond                                  [  started  ]
        networking                             [  started  ]
        Dynamic Runlevel: hotplugged
        Dynamic Runlevel: needed/wanted
        Dynamic Runlevel: manual

* Ver listas de servicios:

    .. code-block:: bash

        rc-status --list

        #RESULTADO ESPERADO

        boot
        nonetwork
        default
        sysinit
        shutdown

* Cambiar "**RUNLEVEL**":

    .. code-block:: bash

        rc {runlevel}
        rc boot
        rc default
        rc shutdown

    * **boot**: Automáticamente incluidos en el resto de los **RUNLEVEL**. Generalmente utilizado para funciones de sistemas, como montar volúmenes, periféricos, etc.
    * **single**: Para todos los servicios excepto aquellos en **\\"sysinit\\"** **RUNLEVEL**.
    * **reboot**: Cambiar a **\\"shutdown\\"** **RUNLEVEL**, y luego **reinicia** el host.
    * **shutdown**: Cambiar a **\\"shutdown\\"** **RUNLEVEL**, y luego **para** (halt) el host.
    * **default**: Utilizado por defecto (el **RUNLEVEL** al que comúnmente se le agregarn servicios).

* Ver servicios iniciados manualmente:

    .. code-block:: bash

        rc-status --manual

        #RESULTADO ESPERADO
        apache2

* Ver servicios caídos:

    .. code-block:: bash
        
        rc-status --crashed

* Listar todos los servicios disponibles:

    .. code-block:: bash

        rc-service --list
        rc-service --list | grep -i nginx

* Agregar/Habilitar servicios en **BOOT TIME**:

    .. code-block:: bash

        rc-update add {service-name} {run-level-name}

        #P.EJ:
        rc-update add apache2
        #Ó:
        rc-update add apache2 default

        #RESULTADO ESPERADO:
        * service apache2 added to runlevel default

* Iniciar servicio:

    .. code-block:: bash

        rc-service {service-name} start
        #Ó
        /etc/init.d/{service-name} start

* Parar servicio:

    .. code-block:: bash

        rc-service {service-name} stop
        #Ó
        /etc/init.d/{service-name} stop  

Reiniciar servicio:

    .. code-block:: bash

        rc-service {service-name} restart
        #Ó
        /etc/init.d/{service-name} restart

* Ejemplo de flujo de parar, iniciar y reiniciar servicio:

    .. code-block:: bash

        rc-service apache2 stop
        rc-service apache2 start
        ###[ editar config file ] ###
        vi /etc/apache2/httpd.conf
        ### [ restart apache 2 después de reiniciar ] ###
        rc-service apache2 restart

* Encontrar ip servidor:

    .. code-block:: bash

        ip a
        #Ó
        ifconfig -a


