=======================
Linux: CRON tab
=======================

El archivo **\\"crontab\\"** contiene secuencias de comandos para ser ejecutadas según un **\\"timestamp\\"** especificado.


Scope y entornos
-----------------------

**Referencias:**
    - https://www.computerhope.com/unix/ucrontab.htm

Los archivos crontab existen para usuarios individuales.

Archivos de configuración
---------------------------

**Referencias:**
    - https://www.computerhope.com/unix/ucrontab.htm


Si los siguientes archivos de configuración **NO** existen, sólo el **\\"superusuario\\"** puede ejecutar tareas CRON:

+----------------------+---------------------------------------------------------------------------------------------+
|     Arhivo           |                        Descripción                                                          |
+----------------------+---------------------------------------------------------------------------------------------+
| \\etc\\cron.allow    | Si este archivo existe, los usuarios deben estar listados en éste para ejecutar tareas CRON |
+----------------------+---------------------------------------------------------------------------------------------+
| \\etc\\cron.deny     | Si este archivo existe, los usuarios listados tienen prohibido ejecutar tareas CRON.        |
+----------------------+---------------------------------------------------------------------------------------------+

Comandos Generales
-------------------------------------------

**Referencias:**
    - https://www.computerhope.com/unix/ucrontab.htm
    - https://stackoverflow.com/questions/10193788/restarting-cron-after-changing-crontab-file

    .. code-block:: bash


        crontab -e #Editar archivo crontab

        crontab -l #Revisar archivo crontab

        crontab -r #listar contenido de archivo crontab

        crontab -r #remover archivo crontab (se pierden las tareas)

        sudo crontab -u charles -e #editar crontab de usuario llamado "charles", -u es para sudo

        sudo crontab -l -u jeff #ver el crontab del usuario llamado "jeff"

        sudo crontab -r -u sandy #borrar crontab de usuario llamado "sandy"

        sudo service cron reload #reiniciar servicio cron (no es necesario ya que se reinicia con cada edición del archivo)

Sintaxis
-----------------------------

**Referencias:**
    - https://www.computerhope.com/unix/ucrontab.htm
    - https://crontab.guru/every-1-minute

* Cada línea del archivo son comandos que se ejecutan en el timestamp especificado, p.ej:

    Ejemplos:

        .. code-block:: bash

            #Ejecuta el script backup.sh, a las 12:01, todos los Lunes de Enero.
            01 00 * Jan Monday  /home/melissa/backup.sh

            #Ejecuta el script backup.sh, en Enero 2 a las 6:15 A.M.
            15 6 2 1 * /home/melissa/backup.sh
                

* La sintaxis es:

    .. code-block:: bash

        minuto hora día(del mes) mes día(de la semana)

* Los operadores son:

    .. code-block:: bash

        * #Cualquier Valor
        , #separador de lista
        - #rango de valores
        / #"Steps" o pasos

Rutas relativas y absolutas
------------------------------

**Referencias:**
    - https://stackoverflow.com/questions/21420945/using-relative-paths-in-crontab
    - https://superuser.com/questions/155576/linux-how-to-run-a-command-in-a-given-directory
    - https://unix.stackexchange.com/questions/38951/what-is-the-working-directory-when-cron-executes-a-job

CRON tab funciona con rutas absolutas, según el **home** del **usuario**.
Para ejecutar con rutas relativas, simplemente se utiliza el comando **cd**:

    .. code-block:: bash

        * * * * * cd /home/fake_user/Desktop/folder1/folder2 && ./script.sh

        #PARA HACERLO COMO ROOT
        * * * * * root cd /home/fake_user/Desktop/folder1/folder2 && ./script.sh


Logs
---------------

**Referencias:**
    - https://askubuntu.com/questions/56683/where-is-the-cron-crontab-log
    - https://askubuntu.com/questions/222512/cron-info-no-mta-installed-discarding-output-error-in-the-syslog
    - https://superuser.com/questions/445347/why-is-my-crontab-not-running

Los logs se encuentran en:

    .. code-block:: bash

        /var/log/syslog

Para ver los logs:

    .. code-block:: bash

        grep CRON /var/log/syslog

**NOTA:** Sin embargo, si **no** hay instalado un servidor de correo, se va a ver la siguiente línea en los logs:

    .. code-block:: bash

        CRON[8380]: (CRON) info (No MTA installed, discarding output)

    **Posibles Soluciones:**

        1. Instalar algún MTP como postfix: :code:`sudo apt-get install postfix` (configurarlo como servidor **\\"local\\"**).
        2. Enviar el oputput del comando a un archivo dentro de la misma entrada crontab, p.ej:

        .. code-block:: bash

            * * * * * yourCommand.sh >/dev/null 2>&1

        3. Revisar logs en dichos archivos o en la carpeta de correos local :code:`tail -f /var/mail/<your_username>` .
    


