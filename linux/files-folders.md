Comando para copiar todos los archivos de varias carpetas a un solo directorio:

```
find /ruta/a/las/carpetas -type f -exec cp {} /ruta/a/carpeta_destino/ \;
```

Explicación del comando:
- ```find /ruta/a/las/carpetas```: Busca en el directorio ```/ruta/a/las/carpetas``` y todas sus subcarpetas.

- ```- type f```: Solo busca archivos, no directorios.

- ```exec cp {} /ruta/a/carpeta_destino/ \;```: Para cada archivo encontrado, ejecuta el comando cp para copiarlo al directorio ```/ruta/a/carpeta_destino/```.
