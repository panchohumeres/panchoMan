=====================================
Jupyter Notebooks: Anaconda
=====================================

Información de referencia sobre como configurar entornos virtuales basados en Anaconda, y ejecutar o automatizar rutinas en Linux bajo ellos.

Correr un entorno virtual **dentro** de un script **BASH**
-----------------------------------------------------------

**Referencias:**
    - https://github.com/conda/conda/issues/7980

    .. code-block:: bash

        #!/bin/bash
        eval "$(conda shell.bash hook)"
        conda activate <nombre_entorno>

        <......resto del script....>

        conda deactivate

Parametrizar script con Papermill:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Referencias:**
    - https://stackoverflow.com/questions/48750055/how-to-run-a-python-jupyter-notebook-daily-automatically
    
    - https://medium.com/y-data-stories/automating-jupyter-notebooks-with-papermill-4b8543ece92f

Agregar script a CRON tab
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Referencias:**
    - https://stackoverflow.com/questions/36365801/run-a-crontab-job-using-an-anaconda-env

**Ver:**
    - https://panchohumeres.gitlab.io/linux_man/_sections/crontab.html

Ejemplo para dejarlo ejecutando cada minuto:

0. Tomando como base el script anterior...
1. Copiar cola agregada por Anaconda al archivo :code:`~/.bashrc`, ejemplo:

    .. code-block:: bash

        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
                . "/opt/anaconda3/etc/profile.d/conda.sh"
            else
                export PATH="/opt/anaconda3/bin:$PATH"
            fi
        fi
        unset __conda_setup
        # <<< conda initialize <<<

3. Crear un nuevo archivo, :code:`~/.bashrc_conda` con snippet copiado de paso anterior.
4. :code:`crontab -e`, y agregar estas líneas:

    .. code-block:: bash

        SHELL=/bin/bash
        BASH_ENV=/home/<user>/.bashrc_conda
        * * * * * cd /home/<user>/path/to/folder && ./script.sh -p parameter_value > ./outputs/log_file.txt 2>&1
