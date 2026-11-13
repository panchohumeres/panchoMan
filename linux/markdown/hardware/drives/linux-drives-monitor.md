# Linux Drives Monitor & Diagnostics

**Sources**:
- https://askubuntu.com/questions/1310338/how-to-secure-erase-a-nvme-ssd
- https://opensource.net/manage-nvme-drive-linux/
- https://www.serverparts.pl/en/blog/how-to-format-an-nvme-drive-how-to-permanently-erase-data-from-an-nvme-drive
- https://github.com/linux-nvme/nvme-cli
- https://unix.stackexchange.com/questions/658/linux-how-can-i-view-all-uuids-for-all-available-disks-on-my-system
- https://askubuntu.com/questions/1408234/how-can-i-know-the-hard-disk-name
### nvme
---------------

Utilidad de línea de comandos nvme-cli para administrar y diagnosticar unidades de estado sólido (SSD) NVMe en Linux.

**Install**
Usually Utility is not installed by default, to install:

```
     #Ubuntu, Debian o Linux Mint
    sudo apt update && sudo apt install -y nvme-cli
    
    #Fedora, CentOS, AlmaLinux o RHEL
   sudo dnf install -y nvme-cli
   
   #Arch Linux o Manjaro:
       sudo pacman -S nvme-cli
```

**Comandos más comunes**:
Reemplazar `nvme0n1` por el nombre correspondiente de la unidad.

- `sudo nvme list`: Muestra todas las unidades NVMe y espacios de nombres (namespaces) conectados al equipo, indicando el modelo, número de serie, capacidad y versión de firmware.

- `sudo nvme smart-log /dev/nvme0n1`: Consulta el registro SMART de salud, temperatura y desgaste de una unidad específica.

- `sudo nvme format /dev/nvme0n1`: Formatea o borra por completo los datos de la unidad NVMe.

- `sudo nvme sanitize /dev/nvme0n1`: Realiza un borrado seguro e irrecuperable de la información en el disco.

- `nvme help`: Muestra la lista completa de subcomandos disponibles.
- `sudo nvme get-feature /dev/nvme0n1 -f 0x0c -H`: Muestra propiedades de un disco, en este caso Autonomous Power State Transition Enable (APSTE), Idle Time Prior to Transition (ITPT), Idle Transition Power State   (ITPS)

### List Drives & Attributes
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
**blkid**
Get device UUID
```
sudo blkid /dev/nvme0n1
/dev/nvme0n1: PTUUID="284444a-c072-4657-ac22-573f645eb9d8" PTTYPE="gpt"
```