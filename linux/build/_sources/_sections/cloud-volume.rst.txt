================================
Linux: Cloud - Montar Volúmenes
================================

Instrucciones (en Linux) para montar un volumen en servicios cloud (como AWS o Amazon):
----------------------------------------------------------------------------------------

* **Referencias**:
    https://www.youtube.com/watch?v=DwdSRt9gfrU

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

2. Crear nueva partición::

    sudo fdisk /dev/xvdb
    n
    p
    1
    Enter
    Enter
    w

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
        /dev/xvdb1    home/ubuntu/data    xfs    defaults,noatime    0    2
        sudo mount -a

    Cambiar permisos:
    
    .. code-block:: bash
    
        sudo chown -R ubuntu /data
        chown -R ubuntu:group /data

