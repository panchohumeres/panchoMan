=====================================
Docker: Instalar
=====================================

Instalar Docker (Ubuntu 18.04):

----------------------------------------------

    * Referencias:
        https://www.digitalocean.com/community/tutorials/como-instalar-y-usar-docker-en-ubuntu-18-04-1-es

    1. .. code-block:: bash
            
            sudo apt update

    2. .. code-block:: bash
    
        sudo apt install apt-transport-https ca-certificates curl software-properties-common
    
    3. Luego, agregue la clave GPG para el repositorio oficial de Docker a su sistema:
        
        .. code-block:: bash
            
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
    4. Agregue el repositorio de Docker a las fuentes de APT:

        .. code-block:: bash
            
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    
    5.  .. code-block:: bash
            
            sudo apt update

    6. Asegúrese de que va a instalar desde el repositorio de Docker en vez del repositorio de Ubuntu predeterminado:
        
        .. code-block:: bash
            
            apt-cache policy docker-ce

        Resultado esperado:

        .. code-block:: bash

            docker-ce:
                Installed: (none)
                Candidate: 18.03.1~ce~3-0~ubuntu
                Version table:
                    18.03.1~ce~3-0~ubuntu 500
                    500 https://download.docker.com/linux/ubuntu bionic/stable amd64 Packages

       * Note que docker-ce no está instalado, pero el candidato para la instalación es del repositorio de Docker para Ubuntu 18.04 (bionic).
    7. .. code-block:: bash
    
        sudo apt install docker-ce

    8. Verificar instalación:

        .. code-block:: bash

            sudo systemctl status docker

        Resultado esperado:

        .. code-block:: bash

            Output
            ● docker.service - Docker Application Container Engine
                Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
                Active: active (running) since Thu 2018-07-05 15:08:39 UTC; 2min 55s ago
                Docs: https://docs.docker.com
            Main PID: 10096 (dockerd)
                Tasks: 16
                CGroup: /system.slice/docker.service
                ├─10096 /usr/bin/dockerd -H fd://
                └─10113 docker-containerd --config /var/run/docker/containerd/containerd.toml

    9. Arreglos para ejecutar Docker sin "sudo":
        1. Agregue su nombre de usuario al grupo docker si quiere evitar escribir sudo siempre que deba ejecutar el comando docker:
            
            .. code-block:: bash
            
                sudo usermod -aG docker ${USER}
                #en caso que el usuario no sea sudo
                sudo su - ${USER}

        3. Confirme que se haya agregado su usuario al grupo de docker escribiendo:
            .. code-block:: bash
                
                id -nG

            Resultado esperado:

            .. code-block:: bash

                Output
                sammy sudo docker


Instalar Docker-Compose:

----------------------------------------------

    * Referencias:
        https://www.digitalocean.com/community/tutorials/como-instalar-docker-compose-en-ubuntu-18-04-es

    1. Revisar versión más actual:
        https://github.com/docker/compose/releases
    2. Descargar repo git reemplazando versión más actual en la ruta:
        .. code-block:: bash
            
            sudo curl -L https://github.com/docker/compose/releases/download/{"versión más actual"}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
        
        Ejemplo:
        
        .. code-block:: bash
            
            sudo curl -L https://github.com/docker/compose/releases/download/1.26.0-rc2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    
    3. Cambiar los permisos:
        .. code-block:: bash

            sudo chmod +x /usr/local/bin/docker-compose

    4. A continuación, comprobaremos que la instalación se haya realizado de forma correcta revisando la versión:
        .. code-block:: bash

            docker-compose --version

        Resultado esperado:

        .. code-block:: bash

            Output
            docker-compose version 1.21.2, build a133471

