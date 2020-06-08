### exportar lista de librerías instalada en anaconda
ejecutar dentro de contenedor (ambiente es "base", ruta "/opt/conda")
* conda env export --name base > /home/jovyan/.jupyter/env.yaml
* /opt/conda/bin/pip freeze > /home/jovyan/.jupyter/requirements.txt
* conda env list
