=====================================
Jupyter Notebooks: Seguridad
=====================================

Instrucciones para generar contraseñas y configurar seguirdad en Jupyter Notebook

----------------------------------------------------------------------------------

Pasos para Obtener contraseña hasheada a partir de un contenedor Docker
--------------------------------------------------------------------------

1. docker-compose start jupyter
2. docker-compose exec jupyter bash
3. ipython
4. from IPython.lib import passwd 
5. passwd()
6. ingresar password y copiar y pegar hash en archivo .env (variable "JUPYTER_PSSWD")
7. exit