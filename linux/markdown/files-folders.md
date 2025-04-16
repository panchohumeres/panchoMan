### Comando para copiar todos los archivos de varias carpetas a un solo directorio:

```
find /ruta/a/las/carpetas -type f -exec cp {} /ruta/a/carpeta_destino/ \;
```

**Explicación del comando**:
- ```find /ruta/a/las/carpetas```: Busca en el directorio ```/ruta/a/las/carpetas``` y todas sus subcarpetas.

- ```- type f```: Solo busca archivos, no directorios.

- ```exec cp {} /ruta/a/carpeta_destino/ \;```: Para cada archivo encontrado, ejecuta el comando cp para copiarlo al directorio ```/ruta/a/carpeta_destino/```.

**Cómo evitar que los archivos se sobrescriban**:
Si quieres evitar que los archivos se sobrescriban en caso de que haya archivos con el mismo nombre, puedes usar la opción -i de cp para que te pida confirmación antes de sobrescribir:

- ```find /ruta/a/las/carpetas -type f -exec cp -i {} /ruta/a/carpeta_destino/ \;```

  **Ejemplo práctico**:
Si tienes los siguientes directorios y archivos:
```
/home/usuario/carpeta1/archivo1.txt
/home/usuario/carpeta1/archivo2.txt
/home/usuario/carpeta2/archivo3.txt
/home/usuario/carpeta2/archivo4.txt
```
- ```find /home/usuario -type f -exec cp {} /home/usuario/todos_los_archivos/ \;```
- Este comando recorrerá todas las subcarpetas dentro de ```/home/usuario```, y copiará todos los archivos a ```/home/usuario/todos_los_archivos/```.

##### Fuentes
- https://unix.stackexchange.com/questions/177908/collect-files-from-several-different-directories-and-put-them-in-one-place
- https://askubuntu.com/questions/163268/move-all-files-in-several-folders
- https://askubuntu.com/questions/1338765/transfer-files-from-multiple-directories-into-a-single-one
- https://askubuntu.com/questions/1128557/copying-specifig-files-from-multiple-folders-to-one-target-folder



