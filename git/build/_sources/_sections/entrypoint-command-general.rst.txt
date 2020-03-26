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