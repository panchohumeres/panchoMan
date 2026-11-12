# Diagnóstico y Optimización de SSD NVMe Económicos / OEM en Linux (Controladores Techwinsemi / Maxio)

Este documento resume el análisis técnico y las soluciones recomendadas para estabilizar unidades SSD NVMe de marcas emergentes o ensambladores OEM (como **CUSU**, identificados mediante PCI como **Shenzhen Techwinsemi `1f99:ef25`**, basados habitualmente en controladores **Maxio DRAM-less**) bajo sistemas operativos Linux.

---

## 1. Diagnóstico del Hardware e Identificación

Las marcas económicas no fabrican sus propios chips controladores; ensamblan controladores de terceros (como Maxio, Realtek o Silicon Motion) con *firmware* personalizado.

### Cómo identificar el chip controlador real
Para conocer el identificador exacto del controlador en el bus PCI Express, ejecuta en la terminal:

```bash
lspci -nn | grep -i -E "nvme|non-volatile"
```

* **Ejemplo detectado:** `09:00.0 Non-Volatile memory controller [0108]: Device [1f99:ef25] (rev 01)`
* **Fabricante real (`1f99`):** Shenzhen Techwinsemi Technology Co., Ltd. (ensamblador OEM de unidades basadas en controladores Maxio sin caché DRAM propia / *DRAM-less*).

---

## 2. Por qué ocurren las desconexiones en Linux

El problema **no es exclusivo de la marca CUSU**, sino una incompatibilidad documentada entre el kernel de Linux y el *firmware* de ahorro de energía de diversos controladores NVMe (afectando tanto a unidades económicas OEM como a modelos de Samsung, Kingston, WD y Crucial):

1. **Estados de ahorro de energía autónomos (APST):** Durante periodos de inactividad (por ejemplo, al dejar Zotero en segundo plano o entre consultas de modelos de IA), Linux envía el SSD a estados de suspensión profunda (`PS3` / `PS4`) para ahorrar energía.
2. **Tiempos de despertar ajustados a Windows:** El *firmware* de ensambladores como Techwinsemi está calibrado únicamente para los tiempos de espera de Windows. Al intentar despertar bajo Linux, el controlador tarda demasiado en responder, provocando un error de tiempo de espera (*I/O timeout*) y haciendo que el kernel desconecte la unidad del bus por seguridad.
3. **Arquitectura DRAM-less y HMB:** Al carecer de memoria DRAM integrada, el controlador depende de una porción de la memoria RAM del sistema (*Host Memory Buffer*) para gestionar su tabla de direcciones. Las microescrituras constantes de metadatos saturan este búfer y aumentan la latencia.

---

## 3. Plan de Optimización y Estabilización en Linux

### Paso 1: Desactivar la suspensión profunda del controlador NVMe (GRUB)
Impide que el controlador entre en estados de bajo consumo donde pierde la comunicación con el bus PCIe.

1. Abre la configuración de GRUB:
   ```bash
   sudo nano /etc/default/grub
   ```
2. Modifica la línea `GRUB_CMDLINE_LINUX_DEFAULT` agregando el parámetro de latencia máxima en `0`:
   ```text
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvme_core.default_ps_max_latency_us=0"
   ```
   *(Nota: Si tras aplicar este cambio la unidad sigue desconectándose, añade también `pcie_aspm=off` al final de la misma línea para desactivar el ahorro de energía en todo el bus PCI Express).*
3. Actualiza GRUB y reinicia el sistema:
   ```bash
   sudo update-grub && sudo reboot
   ```

### Paso 2: Eliminar escrituras por lectura y proteger el arranque (`fstab`)
Evita que Linux escriba la fecha de último acceso cada vez que Zotero, Docker o modelos de IA leen archivos, reduciendo el desgaste de las celdas NAND y la carga sobre el búfer HMB.

1. Abre la tabla de particiones:
   ```bash
   sudo nano /etc/fstab
   ```
2. En la línea correspondiente a tu SSD secundario, asegúrate de incluir `noatime` y `nofail`:
   ```text
   UUID=tu-uuid-aqui /ruta/de/montaje ext4 defaults,nosuid,nodev,nofail,noatime,x-gvfs-show 0 0
   ```
3. Aplica los cambios:
   ```bash
   sudo systemctl daemon-reload && sudo mount -a
   ```

### Paso 3: Sincronizar servicios dependientes (`systemd`)
Garantiza que servicios como Docker o motores de IA no arranquen milisegundos antes de que el SSD secundario termine de montarse al encender el equipo.

1. Edita la unidad del servicio correspondiente (ejemplo con Docker):
   ```bash
   sudo systemctl edit docker.service
   ```
2. Añade la dependencia de montaje:
   ```ini
   [Unit]
   RequiresMountsFor=/ruta/de/montaje
   ```
3. Recarga el gestor de servicios:
   ```bash
   sudo systemctl daemon-reload
   ```

### Paso 4: Buenas prácticas para cargas de IA y bases de datos
* **Mantén al menos un 15% - 20% de espacio libre:** Los SSD *DRAM-less* utilizan el espacio vacío como caché rápida (*SLC Cache*). Llenar el disco por encima del 85% con modelos GGUF (Ollama/llama.cpp) o *checkpoints* (ComfyUI) degrada severamente la velocidad de escritura y eleva la temperatura del controlador.
* **Limita los registros de Docker:** Configura `/etc/docker/daemon.json` con `"max-size": "10m"` y `"max-file": "3"` para evitar escrituras continuas e infinitas de logs.

---

## 4. Fuentes y Referencias Técnicas

### Identificación del Hardware (`1f99:ef25`)
* **HWAddress PCI Vendor Database (`1F99`):** Registro oficial de Shenzhen Techwinsemi Technology Co., Ltd.
  * URL: https://hwaddress.com/pci/1f99/
* **DeviceHunt PCI ID Repository:** Detalles de dispositivos PCI asociados al fabricante `1F99`.
  * URL: https://devicehunt.com/view/type/pci/vendor/1F99/device/6103
* **GitHub Raspberry Pi EEPROM (Issue #817):** Reporte técnico sobre fallos de negociación de energía PCIe en unidades con identificador `1f99` en Linux.
  * URL: https://github.com/raspberrypi/rpi-eeprom/issues/817

### Fallos de Energía NVMe (APST) y Mitigación en Linux
* **Linux Kernel Bugzilla (Bug 195039):** Reporte oficial documentando desconexiones repentinas de controladores NVMe en Linux y el uso de `nvme_core.default_ps_max_latency_us=0`.
  * URL: https://bugzilla.kernel.org/show_bug.cgi?id=195039
* **ArchWiki — Solid State Drive / NVMe:** Guía oficial sobre diagnóstico con `nvme-cli` y desactivación de ahorro de energía autónomo (APST).
  * URL: https://wiki.archlinux.org/title/Solid_state_drive/NVMe
* **AskUbuntu — NVMe Drops Offline & Fails to Wake from Suspend:** Análisis de desconexiones en unidades OEM económicas (FORESEE) y solución mediante parámetros del kernel.
  * URL: https://askubuntu.com/questions/1567151/nvme-foresee-drops-offline-and-fails-to-wake-from-suspend-causing-ext4-i-o-er
* **Unix & Linux StackExchange — Clarifying NVMe APST Problems:** Explicación detallada sobre cómo el parámetro APST provoca bloqueos y desmontajes en Linux.
  * URL: https://unix.stackexchange.com/questions/612096/clarifying-nvme-apst-problems-for-linux
* **Home Assistant Community — NVMe APST Bootloader Discussion:** Debate técnico sobre la integración nativa de `nvme_core.default_ps_max_latency_us=0` para estabilizar discos OEM.
  * URL: https://community.home-assistant.io/t/include-nvme-core-default-ps-max-latency-us-0-to-barebox-bootloader/863741

### Configuración de Montaje y Servicios en Linux
* **ArchWiki — fstab (Español):** Documentación sobre el uso de `UUID`, `noatime` y `nofail` en unidades secundarias.
  * URL: https://wiki.archlinux.org/title/Fstab_(Espa%C3%B1ol)
* **Red Hat Power Management Guide — ASPM:** Documentación sobre la gestión de energía en el bus PCI Express (`pcie_aspm=off`).
  * URL: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/power_management_guide/aspm
* **Freedesktop systemd.unit Manual:** Referencia oficial de la directiva `RequiresMountsFor=`.
  * URL: https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html
