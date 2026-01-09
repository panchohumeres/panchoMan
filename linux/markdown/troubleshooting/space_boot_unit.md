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
  - Some cleanup operations need temporary space
  - Package removal scripts may need to write logs or temporary files
  - The package database updates need some free space

a) List all installed kernels (they should be listed along with the Linux version to which they correspond):
```
# See all installed kernels
dpkg -l | grep -E 'linux-(image|modules|headers)-[0-9]+' | awk '{print $2 " " $3}'
# OR List all kernels (alternative command)
dpkg -l | grep linux-image

# Check current running kernel
uname -r
# Example output: 6.17.9-76061709-generic
```
b) Remove specific old kernels (keeping current + 1 previous). **BE CAREFUL OF NOT DELETING ACTUAL KERNEL, SEE PREVIOUS OUTPUT**:
```
# See all installed kernels
# Example - adjust versions based on your list (1 line per kernel to be removed)
sudo apt remove --purge linux-image-6.8.0-XXXX-generic

# 4. Check free space now
df -h /boot

# 5. If still full, remove another old kernel
sudo apt remove --purge linux-image-6.9.0-XXXX-generic

```

2. Then Run autoremove:
After you have ~100-200MB free, apt autoremove can run successfully:
```
sudo apt autoremove --purge

# 7. Finally, complete the interrupted update
sudo apt --fix-broken install
sudo apt upgrade
```
