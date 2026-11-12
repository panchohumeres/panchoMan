# Guía de Diagnóstico y Optimización para SSD NVMe OEM / Económicos en Linux
**(Caso aplicado: Controladores Shenzhen Techwinsemi Technology / Maxio — ID PCI `1f99:ef25`, marca CUSU y análogos)**

Esta guía consolida el diagnóstico de hardware, las causas técnicas de desconexión repentina en Linux y los pasos de configuración para estabilizar unidades SSD NVMe OEM o de gama económica utilizadas como discos secundarios (*slave*) en cargas de trabajo como Zotero, Docker, bases de datos o modelos de IA local (Ollama, ComfyUI).

---

## 1. Diagnóstico del Hardware e Identificador PCI (`1f99:ef25`)

Muchos SSD de marcas emergentes o económicas (como **CUSU**, **FORESEE**, **Kingspec**, etc.) no fabrican sus propios chips, sino que ensamblan soluciones OEM. Al consultar el bus PCIe en Linux mediante:

```bash
lspci -nn | grep -i -E "nvme|non-volatile"
```

Se obtiene el identificador **`1f99:ef25`**, cuyas características técnicas explican su comportamiento:

* **Fabricante OEM (`1f99`)**: Corresponde a **Shenzhen Techwinsemi Technology Co., Ltd.** (fabricante detrás de la serie TWSC), que provee módulos NVMe reetiquetados a múltiples marcas comerciales.
* **Arquitectura interna (*DRAM-less*)**: Estas unidades suelen integrar controladores **Maxio (como MAP1202 o MAP1602)** reprogramados con el ID de Techwinsemi. Al carecer de memoria caché DRAM propia en la placa, dependen del *Host Memory Buffer* (HMB), tomando una pequeña fracción de la RAM del sistema para gestionar su tabla de asignación de bloques.
* **Por qué ocurre el problema**: El problema no es exclusivo de una marca en particular, sino un comportamiento documentado en el kernel de Linux cuando interactúa con controladores cuyo *firmware* está calibrado únicamente para los tiempos de espera de Windows.

---

## 2. Causa Técnica de las Desconexiones en Reposo

Cuando el SSD permanece como disco secundario con aplicaciones en segundo plano (como Zotero sincronizando o contenedores inactivos):

1. **Transición a bajo consumo (*APST* / *D3hot*)**: El kernel de Linux envía la unidad a estados profundos de ahorro energético (PS3/PS4) tras unos milisegundos de inactividad.
2. **Fallo al despertar**: Cuando una aplicación solicita leer o escribir un archivo nuevamente, el controlador Techwinsemi/Maxio tarda más del tiempo límite esperado en negociar el despertar del enlace PCIe.
3. **Desmontaje por seguridad**: El kernel asume que el dispositivo dejó de responder (*I/O timeout*) y lo desconecta del bus PCIe, provocando que el punto de montaje desaparezca hasta el próximo reinicio.

---

## 3. Pasos de Optimización y Estabilización

### Paso 1: Desactivar el ahorro de energía agresivo en GRUB
Impide que el controlador NVMe entre en suspensión profunda mientras el equipo está encendido.

1. Edita el archivo de configuración de GRUB:
   ```bash
   sudo nano /etc/default/grub
   ```
2. Añade el parámetro `nvme_core.default_ps_max_latency_us=0` en la línea `GRUB_CMDLINE_LINUX_DEFAULT`:
   ```text
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvme_core.default_ps_max_latency_us=0"
   ```
   *(Nota: Únicamente si tras reiniciar persisten las desconexiones, agrega también `pcie_aspm=off` al final de esa misma línea para desactivar el ahorro energético en todo el bus PCI Express).*
3. Actualiza GRUB:
   ```bash
   sudo update-grub
   ```

### Paso 2: Reducir escrituras por lectura y proteger el arranque (`/etc/fstab`)
Evita que Linux actualice la fecha de último acceso cada vez que se lee un archivo (reduciendo el desgaste en celdas NAND y la carga sobre el HMB de unidades *DRAM-less*) y asegura que el sistema arranque aunque el disco falle.

1. Abre la tabla de particiones:
   ```bash
   sudo nano /etc/fstab
   ```
2. Asegúrate de incluir `nofail` y `noatime` en las opciones de montaje de la unidad secundaria:
   ```text
   UUID=tu-uuid-aqui  /ruta/de/montaje  ext4  auto,nosuid,nodev,nofail,noatime,x-gvfs-show  0  0
   ```
3. Recarga la configuración:
   ```bash
   sudo systemctl daemon-reload && sudo mount -a
   ```

### Paso 3: Sincronizar el inicio de Docker o servicios dependientes (`systemd`)
Evita que los contenedores de Docker arranquen antes de que el disco secundario termine de montarse al encender el PC.

1. Crea una regla de anulación para el servicio de Docker:
   ```bash
   sudo systemctl edit docker.service
   ```
2. Añade la directiva `RequiresMountsFor` apuntando a la ruta real de tu SSD:
   ```ini
   [Unit]
   RequiresMountsFor=/ruta/de/montaje
   ```
3. Guarda y recarga `systemd`:
   ```bash
   sudo systemctl daemon-reload
   ```

### Paso 4: Reiniciar y verificar el estado energético
1. Reinicia el equipo para aplicar los cambios del kernel:
   ```bash
   sudo reboot
   ```
2. Verifica que la latencia máxima de ahorro de energía (*APST*) esté en `0` (reemplaza `nvme1` por el identificador real de tu disco):
   ```bash
   sudo nvme get-feature /dev/nvme1 -f 0x0c -H
   ```

---

## 4. Fuentes, Documentación Técnica y Reportes de Comunidad

### Identificación de Hardware y Controlador (`1f99:ef25` - Shenzhen Techwinsemi)
* **Base de datos de fabricantes PCI (ID `1f99`)**: Registro oficial que identifica el código de proveedor `1F99` como *Shenzhen Techwinsemi Technology Co., Ltd.*
  * [HWAddress — PCI Vendor 1F99](https://hwaddress.com/pci/1f99/)
  * [DeviceHunt — PCI Vendor 1F99 / Device 6103](https://devicehunt.com/view/type/pci/vendor/1F99/device/6103)
* **Reportes de comunidad y foros técnicos sobre Techwinsemi (`1f99`) en Linux**:
  * **GitHub (`raspberrypi/rpi-eeprom` Issue #817)**: Discusión técnica y reportes de usuarios documentando fallos de transición de energía PCIe (`D3hot`/`D3cold`) y compatibilidad en Linux específicamente con unidades NVMe identificadas bajo el vendor ID `1f99` (*Techwinsemi*): [GitHub Issue #817](https://github.com/raspberrypi/rpi-eeprom/issues/817)

### Gestión de Energía NVMe (`APST`) y Reportes de Desconexiones
* **Linux Kernel Bugzilla (Bug 195039)**: Reporte oficial del kernel donde múltiples usuarios documentan desconexiones repentinas de controladores NVMe tras periodos de inactividad y validan `nvme_core.default_ps_max_latency_us=0` como solución: [Kernel Bugzilla 195039](https://bugzilla.kernel.org/show_bug.cgi?id=195039)
* **AskUbuntu (Caso en unidades OEM FORESEE)**: Hilo técnico que analiza el desmontaje repentino de un SSD OEM económico tras suspender o quedar inactivo en Linux y su resolución desactivando APST: [AskUbuntu — NVMe drops offline](https://askubuntu.com/questions/1567151/nvme-foresee-drops-offline-and-fails-to-wake-from-suspend-causing-ext4-i-o-er)
* **Foro de Comunidad Home Assistant**: Debate técnico sobre fallos de discos NVMe OEM/económicos bajo Linux y la propuesta de incluir `nvme_core.default_ps_max_latency_us=0` por defecto: [Home Assistant Community — NVMe APST](https://community.home-assistant.io/t/include-nvme-core-default-ps-max-latency-us-0-to-barebox-bootloader/863741)
* **Unix & Linux StackExchange**: Explicación detallada sobre el funcionamiento de las tablas de latencia APST en Linux y por qué provocan bloqueos en controladores de terceros: [Unix StackExchange — Clarifying NVMe APST problems](https://unix.stackexchange.com/questions/612096/clarifying-nvme-apst-problems-for-linux)

### Documentación Oficial de Sistema Operativo y Servicios
* **ArchWiki — Solid State Drive (NVMe)**: Guía de referencia sobre gestión de energía, uso de `nvme-cli` y mitigación de fallos de controlador: [ArchWiki NVMe](https://wiki.archlinux.org/title/Solid_state_drive/NVMe)
* **ArchWiki — fstab**: Documentación sobre opciones de montaje `noatime` y `nofail`: [ArchWiki fstab](https://wiki.archlinux.org/title/Fstab_(Espa%C3%B1ol))
* **Freedesktop — `systemd.unit` Manual**: Especificación oficial de la directiva `RequiresMountsFor=`: [systemd.unit Manual](https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html)

---------------------------------------------
*Written with assistance of Gemini AI