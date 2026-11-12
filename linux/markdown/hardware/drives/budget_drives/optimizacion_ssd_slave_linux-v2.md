# Guía de Optimización, Estabilidad y Recuperación para SSD NVMe Secundario en Linux

Esta guía recopila las configuraciones recomendadas para estabilizar unidades SSD NVMe secundarias (especialmente modelos económicos o sin caché DRAM, como CUSU) utilizadas para almacenar datos de **Zotero**, **volúmenes de Docker** y cargas de trabajo de **IA local** (Ollama, llama.cpp, ComfyUI, GPT4All) o bases de datos.

---

## 1. Evitar desconexiones por ahorro de energía (GRUB)

### Motivo
Muchos controladores NVMe económicos presentan errores de *firmware* al entrar en estados profundos de ahorro de energía (*APST* o *Autonomous Power State Transition*). Cuando una aplicación queda inactiva en segundo plano (como Zotero o un contenedor esperando peticiones), el kernel de Linux suspende el disco; al intentar despertarlo, el controlador tarda demasiado y Linux desconecta la unidad del bus PCIe por seguridad.

### Pasos de configuración
1. Abre el archivo de configuración de GRUB:
   ```bash
   sudo nano /etc/default/grub
   ```
2. Localiza la línea `GRUB_CMDLINE_LINUX_DEFAULT` y añade el parámetro de latencia máxima en `0`:
   ```text
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvme_core.default_ps_max_latency_us=0"
   ```
   *(Nota: Solo si tras reiniciar y probar el equipo notas que el disco aún se desconecta, añade `pcie_aspm=off` al final de esa misma línea).*
3. Guarda los cambios (`Ctrl + O`, `Enter`, `Ctrl + X`) y actualiza GRUB:
   ```bash
   sudo update-grub
   ```
4. Reinicia el equipo para aplicar los cambios en el kernel:
   ```bash
   sudo reboot
   ```

---

## 2. Reducir desgaste por lecturas y proteger el arranque (`fstab`)

### Motivo
* **`noatime`**: Por defecto, Linux escribe la fecha y hora de último acceso cada vez que se lee un archivo. En cargas de trabajo con miles de PDFs (Zotero), modelos GGUF (Ollama/ComfyUI) o consultas a bases de datos, esto genera miles de microescrituras innecesarias que degradan las celdas NAND y saturan el controlador del SSD.
* **`nofail`**: Garantiza que el sistema operativo principal arranque con normalidad incluso si el SSD secundario falla o tarda en responder al encender el equipo, evitando caer en una consola de emergencia.

### Pasos de configuración
1. Verifica el formato y punto de montaje actual de tu SSD (se recomienda usar el sistema de archivos nativo **`ext4`**):
   ```bash
   lsblk -f
   ```
2. Abre la tabla de particiones:
   ```bash
   sudo nano /etc/fstab
   ```
3. En la línea correspondiente a tu SSD secundario, asegúrate de incluir `nofail` y `noatime` separados por comas (sin espacios):
   ```text
   UUID=tu-uuid-aqui /ruta/de/tu/ssd ext4 nosuid,nodev,nofail,noatime,x-gvfs-show 0 0
   ```
4. Recarga la configuración de montaje sin reiniciar:
   ```bash
   sudo systemctl daemon-reload && sudo mount -a
   ```

---

## 3. Sincronizar el inicio de Docker con el montaje del SSD (`systemd`)

### Motivo
Al usar la opción `nofail` en `/etc/fstab`, Docker podría iniciar unos milisegundos antes de que el SSD secundario termine de montarse. Si un contenedor arranca antes de tiempo, creará una carpeta vacía en la ruta de destino y ocultará tus volúmenes reales.

### Pasos de configuración
1. Edita la configuración del servicio de Docker:
   ```bash
   sudo systemctl edit docker.service
   ```
2. Añade la directiva `RequiresMountsFor` en la parte superior del editor (reemplazando `/ruta/de/tu/ssd` por tu ruta real):
   ```ini
   [Unit]
   RequiresMountsFor=/ruta/de/tu/ssd
   ```
3. Guarda, sal y recarga los demonios del sistema:
   ```bash
   sudo systemctl daemon-reload
   ```
4. En tus archivos `docker-compose.yml`, utiliza siempre **bind mounts** apuntando a carpetas dentro del SSD:
   ```yaml
   volumes:
     - /ruta/de/tu/ssd/docker-volumes/mi_app:/ruta/interna/contenedor
   ```

---

## 4. Limitar el crecimiento de registros en Docker (`daemon.json`)

### Motivo
Docker almacena toda la salida de consola de los contenedores en archivos JSON sin límite de tamaño. Si un contenedor entra en un bucle de errores, puede llenar el disco principal y generar escrituras continuas innecesarias.

### Pasos de configuración
1. Revisa si ya tienes configuraciones previas (por ejemplo, soporte para GPU NVIDIA):
   ```bash
   cat /etc/docker/daemon.json
   ```
2. Edita o crea el archivo:
   ```bash
   sudo nano /etc/docker/daemon.json
   ```
3. Añade las opciones de rotación de registros (combínalas con tus claves existentes si el archivo ya tenía contenido):
   ```json
   {
     "log-driver": "json-file",
     "log-opts": {
       "max-size": "10m",
       "max-file": "3"
     }
   }
   ```
4. Reinicia Docker para aplicar la regla a los contenedores nuevos:
   ```bash
   sudo systemctl restart docker
   ```

---

## 5. Buenas prácticas para IA local y bases de datos

* **Mantén al menos un 15% a 20% de espacio libre**: Los SSD sin memoria DRAM utilizan el espacio vacío como caché rápida (*SLC Cache*). Llenar el disco por encima del 85% con modelos pesados reducirá drásticamente la velocidad de escritura y elevará la temperatura del controlador.
* **Configura rutas mediante variables de entorno**: Para herramientas fuera de Docker (como Ollama o ComfyUI), define rutas explícitas hacia tu SSD (ej. `OLLAMA_MODELS=/ruta/de/tu/ssd/ollama`) en lugar de usar enlaces simbólicos (*symlinks*).

---

## 6. Alcance real del riesgo y recuperación ante fallos lógicos

### ¿Qué tan probable es una corrupción catastrófica?
Es **muy difícil** que una desconexión por reposo cause una pérdida total de datos si usas el sistema de archivos **`ext4`**:
* **Protección por bitácora (*Journaling*)**: `ext4` registra los cambios antes de confirmarlos. Si el disco se desconecta abruptamente, Linux descarta la última operación inconclusa al reiniciar y conserva intacto el resto de archivos (PDFs, modelos, configuraciones).
* **Bases de datos transaccionales**: Motores como SQLite (Zotero), PostgreSQL o MySQL utilizan registros de transacciones (*WAL*) que revierten escrituras incompletas sin dañar los datos previos.
* **Lo máximo que suele perderse**: Únicamente el archivo exacto que se estaba escribiendo o descargando en el milisegundo del corte, o el estado temporal de la caché de capas de Docker (recuperable volviendo a descargar las imágenes con `docker compose pull`). El único riesgo catastrófico real en unidades económicas es una falla física del controlador por calor extremo o fin de vida útil, por lo que siempre debes respaldar tus datos irreemplazables.

### Paso 1: Reparar el sistema de archivos del SSD (`fsck`)
Si tras una desconexión abrupta el SSD no se monta automáticamente:
1. Identifica el nombre exacto de la partición (por ejemplo, `/dev/nvme1n1p1`):
   ```bash
   lsblk
   ```
2. Asegúrate de que la partición esté desmontada y ejecuta la reparación automática:
   ```bash
   sudo umount /dev/nvme1n1p1
   sudo fsck -y /dev/nvme1n1p1
   ```
   *(Nota: Si alguna vez necesitas reparar el disco principal `/` del sistema operativo, deberás ejecutar `fsck` arrancando desde una memoria USB Live).*
3. Monta nuevamente la unidad:
   ```bash
   sudo mount -a
   ```

### Paso 2: Recuperación de Docker (solo como último recurso)
Si Docker no inicia tras un corte de energía mientras descargaba o escribía capas:
1. Revisa primero el motivo exacto del error antes de borrar nada:
   ```bash
   sudo systemctl restart docker
   sudo journalctl -u docker -n 50
   ```
2. Si el motor sigue bloqueado por capas corruptas, detén el servicio y respalda la carpeta de capas:
   ```bash
   sudo systemctl stop docker
   sudo mv /var/lib/docker/overlay2 /var/lib/docker/overlay2.bak
   sudo systemctl start docker
   ```
   *(Advertencia: Este paso elimina las imágenes descargadas y los volúmenes nombrados internos, obligándote a descargar las imágenes nuevamente con `docker compose pull`, aunque tus datos en los volúmenes externos del SSD permanecerán intactos).*

------------------------------------------------

*Written with assistance of Gemini AI