================================
Linux: Cloud - Montar Volúmenes
================================

Instrucciones (en Linux) para montar un volumen en servicios cloud (como AWS o Amazon):
----------------------------------------------------------------------------------------

* **Referencias**:
    - https://www.youtube.com/watch?v=DwdSRt9gfrU
    - https://docs.microsoft.com/en-us/azure/virtual-machines/linux/add-disk

* Ejemplo con un volumen nuevo llamado **"data"**.


1. Listar volumenes existentes


    .. code-block:: bash

        sudo lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL

    Ejemplo respuesta

    .. code-block:: bash

        NAME    FSTYPE  SIZE MOUNTPOINT LABEL
        xvda             25G
        └─xvda1 ext4     25G /          cloudimg-rootfs
        xvdb            200G

2. Crear nueva partición:

    .. code-block:: bash

        sudo fdisk /dev/xvdb
        n
        p
        1
        Enter
        Enter
        w

    Ejemplo:

    .. code-block:: bash

        Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
        Building a new DOS disklabel with disk identifier 0x2a59b123.
        Changes will remain in memory only, until you decide to write them.
        After that, of course, the previous content won't be recoverable.

        Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)

        Command (m for help): n
        Partition type:
        p   primary (0 primary, 0 extended, 4 free)
        e   extended
        Select (default p): p
        Partition number (1-4, default 1): 1
        First sector (2048-10485759, default 2048):
        Using default value 2048
        Last sector, +sectors or +size{K,M,G} (2048-10485759, default 10485759):
        Using default value 10485759

3. Crear sistema de archivos XFS (Red Hat):
    https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/storage_administration_guide/ch-xfs
    
    .. code-block:: bash
    
        sudo mkfs.xfs -L data /dev/xvdb1

    Ejemplo Output:

    .. code-block:: bash

        meta-data=/dev/xvdb1             isize=512    agcount=4, agsize=13107136 blks
                 =                       sectsz=512   attr=2, projid32bit=1
                 =                       crc=1        finobt=1, sparse=0
        data     =                       bsize=4096   blocks=52428544, imaxpct=25
                 =                       sunit=0      swidth=0 blks
        naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
        log      =internal log           bsize=4096   blocks=25599, version=2
                 =                       sectsz=512   sunit=0 blks, lazy-count=1
        realtime =none                   extsz=4096   blocks=0, rtextents=0

4. Crear directorio y montar volumen:
    Crear directorio:
    
    .. code-block:: bash
       
        sudo mkdir /data

    Cambiar archivo fstab, con directivas para montar automáticamente el volumen cuando se reinicia el sistema, y montar volumen:
    https://es.wikipedia.org/wiki/Fstab
    
    .. code-block:: bash

        sudo vim /etc/fstab
        /dev/xvdb1    /home/ubuntu/data    xfs    defaults,noatime    0    2
        sudo mount -a

    Cambiar permisos:
    * En este ejemplo \\"<carpeta_destino>\\" sería \\"data\\".
    
    .. code-block:: bash
    
        sudo chmod -R g+rwx <carpeta_destino>
        sudo chgrp -R 1000 <carpeta_destino>
        sudo chown -R 1000 <carpeta_destino>

