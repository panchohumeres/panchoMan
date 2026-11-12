# Guía de Optimización, Estabilidad y Recuperación para SSD NVMe Secundario en Linux

Esta guía recopila las configuraciones esenciales para evitar desconexiones por ahorro de energía, reducir el desgaste por escrituras innecesarias, sincronizar servicios como Docker/IA local y reparar errores lógicos en unidades SSD NVMe secundarias (*slave*).

---

## 1. Evitar desconexiones por ahorro de energía (GRUB)

### ¿Por qué hacerlo?
Muchos SSD NVMe económicos (como unidades CUSU o con controladores sin caché DRAM) presentan fallos en su *firmware* al salir de estados de suspensión profunda (*APST*). Cuando aplicaciones como Zotero, Ollama o contenedores de Docker quedan inactivos en segundo plano, Linux envía el disco a reposo y, al intentar despertarlo, el controlador no responde a tiempo y el sistema operativo desconecta la unidad.

### Pasos de configuración
1. Abre el archivo de configuración de GRUB:
   ```bash
   sudo nano /etc/default/grub
   ```
2. Ubica la línea `GRUB_CMDLINE_LINUX_DEFAULT` y añade el parámetro de latencia máxima en cero:
   ```text
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvme_core.default_ps_max_latency_us=0"
   ```
   *(Nota: Solo si el problema persiste tras probar este ajuste, añade `pcie_aspm=off` al final dentro de las comillas).*
3. Guarda los cambios (`Ctrl + O`, `Enter`, `Ctrl + X`) y actualiza GRUB:
   ```bash
   sudo update-grub
   ```
4. Reinicia el equipo para que el kernel aplique el cambio:
   ```bash
   sudo reboot
   ```

---

## 2. Reducir el desgaste y proteger el arranque (`fstab`)

### ¿Por qué hacerlo?
* **`noatime`**: Evita que Linux escriba en el SSD la fecha y hora de último acceso cada vez que Zotero, Docker o un modelo de IA leen un archivo. Esto reduce miles de microescrituras innecesarias y alarga la vida útil de las celdas NAND.
* **`nofail`**: Garantiza que el sistema operativo principal arranque con normalidad incluso si el SSD secundario falla o no responde al encender el equipo, evitando caer en una consola de emergencia.

### Pasos de configuración
1. Edita la tabla de particiones:
   ```bash
   sudo nano /etc/fstab
   ```
2. En la línea correspondiente a tu SSD secundario, asegúrate de incluir `nofail` y `noatime` en las opciones de montaje:
   ```text
   UUID=tu-uuid-aqui /ruta/de/montaje ext4 nosuid,nodev,nofail,noatime,x-gvfs-show 0 0
   ```
3. Guarda los cambios y recarga la configuración de montaje:
   ```bash
   sudo systemctl daemon-reload && sudo mount -a
   ```

---

## 3. Sincronizar el arranque de servicios con el montaje del SSD (`systemd`)

### ¿Por qué hacerlo?
Al usar la opción `nofail`, Linux puede iniciar servicios como **Docker** u **Ollama** unos milisegundos antes de que el SSD secundario termine de montarse. Si un contenedor arranca antes que el disco, creará una carpeta vacía en la ruta y los datos parecerán desaparecidos.

### Pasos de configuración
1. Crea una regla de anulación para el servicio (ejemplo con Docker):
   ```bash
   sudo systemctl edit docker.service
   ```
2. Añade la dependencia hacia la ruta de montaje de tu SSD:
   ```ini
   [Unit]
   RequiresMountsFor=/ruta/de/montaje
   ```
3. Guarda, cierra y recarga el gestor de servicios:
   ```bash
   sudo systemctl daemon-reload
   ```

---

## 4. Limitar el crecimiento de registros en Docker (`daemon.json`)

### ¿Por qué hacerlo?
Por defecto, Docker guarda cada mensaje de consola de tus contenedores en un archivo JSON sin límite de tamaño. Si una aplicación entra en bucle de errores, puede llenar el disco principal y generar escrituras constantes innecesarias.

### Pasos de configuración
1. Revisa si ya existe una configuración previa (por ejemplo, soporte para GPU NVIDIA):
   ```bash
   cat /etc/docker/daemon.json
   ```
2. Edita o crea el archivo `/etc/docker/daemon.json` e incluye la rotación de logs:
   ```json
   {
     "log-driver": "json-file",
     "log-opts": {
       "max-size": "10m",
       "max-file": "3"
     }
   }
   ```
3. Reinicia el servicio de Docker para aplicarlo a los nuevos contenedores:
   ```bash
   sudo systemctl restart docker
   ```

---

## 5. Buenas prácticas adicionales para IA local y Bases de Datos

* **Mantén al menos un 15% a 20% de espacio libre**: Los SSD sin memoria DRAM utilizan el espacio vacío como caché rápida (*SLC Cache*). Llenar el disco por encima del 85% con modelos pesados (Ollama, ComfyUI) degrada severamente la velocidad de escritura y eleva la temperatura.
* **Usa variables de entorno en lugar de enlaces simbólicos**: Configura rutas explícitas (ej. `OLLAMA_MODELS=/ruta/de/montaje/ollama`) y *bind mounts* en Docker para evitar conflictos de permisos.

---

## 6. Protocolo de reparación ante desconexión abrupta (`fsck`)

### ¿Cuándo usarlo?
Si el SSD sufre una desconexión en medio de una escritura intensa y al reiniciar no se monta o arroja errores de lectura/escritura, el daño suele ser lógico en el sistema de archivos (`ext4`).

### Pasos de reparación (para disco secundario)
1. Identifica el nombre de la partición de tu SSD secundario (ej. `/dev/nvme1n1p1`):
   ```bash
   lsblk -f
   ```
2. Asegúrate de que la partición esté desmontada:
   ```bash
   sudo umount /dev/nvme1n1p1
   ```
3. Ejecuta la reparación automática del sistema de archivos:
   ```bash
   sudo fsck -y /dev/nvme1n1p1
   ```
   *(Este comando reconstruye el índice `ext4` y mueve fragmentos corruptos a `lost+found`, recuperando la estructura del disco).*
4. Vuelve a montar todas las unidades configuradas:
   ```bash
   sudo mount -a
   ```

> **Nota para el disco principal (*master*):** Si el error ocurre en la partición raíz (`/`) del sistema operativo, no puedes desmontarla en caliente. Debes arrancar desde una memoria USB *Live* de Linux y ejecutar `sudo fsck -y /dev/particion_raiz` desde allí.

---------------------------------
*Written with assistance of Gemini AI