# Monitoreo y Validación de la Unidad SSD NVMe

Para confirmar que toda la configuración quedó bien aplicada y que el SSD secundario (Techwinsemi / CUSU) funciona de manera estable sin entrar en suspensión profunda, revisa estos **5 parámetros clave** desde tu terminal.

## 0. Get Drive name and basic info
**lsblk**
Get drives names, and basic attributes
```
$ lsblk 
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda           8:0    0 931,5G  0 disk 
└─sda1        8:1    0 931,5G  0 part 
sdb           8:16   0 465,8G  0 disk 
...
```
**fdisk**
List drives with detailed attributes (such as factory specs, UUID, etc)
```
sudo fdisk -l


#example output
Disk /dev/nvme0n1: 476.94 GiB, 512110190592 bytes, 1000215216 sectors
Disk model: CUSU CV3500Q 512GB
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 23333A-C072-4657-AC22-573F645EB9D8

.......................
```

---

## 1. Verificar que el kernel aplicó el parámetro de energía (GRUB)

Confirma que Linux arrancó con la restricción de latencia activa para el controlador NVMe:

```bash
cat /proc/cmdline
```

* **Qué debes ver:** Debe aparecer `nvme_core.default_ps_max_latency_us=0` en la línea de texto que devuelve la terminal.
* **Comprobación directa en el controlador:** Ejecuta `cat /sys/module/nvme_core/parameters/default_ps_max_latency_us`. Si devuelve **`0`**, el ahorro de energía autónomo (*APST*) está completamente desactivado.

---

## 2. Confirmar el estado APST directamente en el firmware (nvme-cli)

Este comando interroga directamente al chip controlador del SSD para confirmar a nivel de *hardware* (firmware) que aceptó la orden del kernel y desactivó las transiciones automáticas de ahorro de energía (*APST*).

1. **Instala la herramienta** (si no la tienes en tu sistema):
   ```bash
   sudo apt update && sudo apt install -y nvme-cli
   ```
2. **Consulta la tabla de energía directa del controlador** (verifica con `lsblk` si tu disco secundario es `/dev/nvme1` o `/dev/nvme0`):
   ```bash
   sudo nvme get-feature /dev/{drive_name}-f 0x0c -H
   ```

* **Qué debes ver:**
  * **`Autonomous Power State Transition Enable (APSTE): Disabled`** (o el valor en `0`): Confirma que el controlador Techwinsemi tiene apagado el cambio automático hacia estados de suspensión profundos (`PS3` / `PS4`).
  * **Tabla de estados (`Entry`):** Si aparecen listados, el tiempo de inactividad (`Idle Time Prior to Transition`) debe aparecer en `0 ms`, lo que garantiza que el disco nunca salta por sí solo a un estado de reposo problemático.

---

## 3. Verificar las opciones de montaje (fstab)

Asegúrate de que el sistema montó `/mnt/slave1` con la reducción de escrituras y la protección de arranque activas:

```bash
findmnt -no OPTIONS /mnt/{drive_path}
```

* **Qué debes ver:** En la lista de parámetros separados por comas debe figurar **`noatime`** (y no `relatime`), junto con `rw,nosuid,nodev`.

---

## 4. Monitorear la temperatura y salud del controlador (smartctl)

Como el SSD ya no entra en estados de suspensión profundos, conviene vigilar durante los primeros días que no se caliente en exceso en reposo ni registre errores de interfaz:

```bash
sudo smartctl -a /dev/{drive_name}
```

*(Nota: Si no lo tienes instalado, ejecútalo tras instalar `sudo apt install smartmontools`, y ajusta `nvme1` si tu disco  es `nvme0`).*

* **`Temperature` / `Composite Temperature`:** En reposo debería mantenerse entre **30 °C y 45 °C**, y bajo carga intensa (Ollama o Docker) por debajo de **65 °C**.
* **`Media and Data Integrity Errors`:** Debe mantenerse en **`0`**.
* **`Error Information Log Entries`:** Verifica que este contador no siga subiendo tras reiniciar.

---

## 5. Vigilar desconexiones silenciosas del kernel (dmesg)

Tras usar Zotero en segundo plano o correr contenedores durante un par de horas, revisa si el núcleo reportó algún corte de comunicación:

```bash
sudo dmesg -T | grep -iE "nvme|ext4-fs error|pcie"
```

* **Qué debes ver:** Únicamente las líneas iniciales de detección al encender el equipo (`nvme nvme1: pci function 0000:09:00.0`). Si no aparecen mensajes en rojo como *`I/O timeout`*, *`Controller is down`* o *`Remounting filesystem read-only`*, la configuración funcionó por completo.
