### Warning of few space left in the boot unit
* Warning of few space left in the boot unit (PopOs example).
* After it, updates such as those that involve **updating the kernel** are not possible.
* Example of Error after ```sudo apt upgrade```:
  
```
Setting up linux-image-6.17.9-76061709-generic (6.17.9-76061709.202511241048~1764704751~22.04~b24b425) ...
Processing triggers for linux-image-6.17.9-76061709-generic (6.17.9-76061709.202511241048~1764704751~22.04~b24b425) ...
/etc/kernel/postinst.d/dkms:
 * dkms: running auto installation service for kernel 6.17.9-76061709-generic
   ...done.
/etc/kernel/postinst.d/initramfs-tools:
update-initramfs: Generating /boot/initrd.img-6.17.9-76061709-generic
xz: (stdout): Write error: No space left on device
E: mkinitramfs failure xz --check=crc32 --threads=0 1
update-initramfs: failed for /boot/initrd.img-6.17.9-76061709-generic with 1.
run-parts: /etc/kernel/postinst.d/initramfs-tools exited with return code 1
dpkg: error processing package linux-image-6.17.9-76061709-generic (--configure):
 installed linux-image-6.17.9-76061709-generic package post-installation script subprocess returned error exit status 1
Errors were encountered while processing:
 linux-image-6.17.9-76061709-generic
E: Sub-process /usr/bin/dpkg returned an error code (1)
```
 ### Description
 -----------------
 Usually happens when old & unused kernels are stored in the boot partition (after several updates).

- Check boot partition usage:
```
 df -h /boot
ls -la /boot
```
Or conversely (on PopOs) use GUI app **"Disk Usage Analysis"**, ---> ```/boot```.
You would see most of the files contained within ```/boot```

### FIX
--------------
1. First remove a couple of outdated kernels for making room for running apt purge. Otherwise ```sudo apt autoremove --purge``` will fail. **apt autoremove itself needs space** to run its cleanup operations. When ```/boot``` is ~100% full (960MB/1GB), even cleanup operations can fail because:
