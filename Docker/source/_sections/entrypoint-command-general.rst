=====================================
Docker: Entrypoint y Command
=====================================

Instrucciones generales

----------------------------------------------------------------------------

* Ejemplo llamar script bash con **"command"** en Docker-compose:
    https://stackoverflow.com/questions/57840820/run-a-shell-script-form-docker-compose-command-inside-the-container

    version: "2"

    .. code-block:: yaml

        services:
            api:
                build: .
                container_name: app
                command: /bin/sh -c "entrypoint.sh"
                expose:
                    - "5000"

**OJO!!**: Método **bash o \\"entrypoint\\" NO está testeado**, **preferir** método **Dockerfile**. Método bash genera problemas de networking entre contenedor y el host, ver:
    - :ref:`redirección_de_puertos`
    - :ref:`connection_refuse_connection_rest_by_peer`