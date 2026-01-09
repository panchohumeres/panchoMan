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
# 6. PURGE
sudo apt autoremove --purge

# 7. Finally, complete the interrupted update
sudo apt --fix-broken install
sudo apt upgrade

# Clean everything
sudo apt clean
sudo apt autoclean
```
#### Recommended SOurces:
--------------------------
- https://bluebird-documentation.com/documentation/page/Clearing%20up%20Space%20on%20Pop%20OS/NGzFPNeV9GY1g6q2PFX7SfQmRqw1
- https://askubuntu.com/questions/89710/how-do-i-free-up-more-space-in-boot
- https://www.reddit.com/r/pop_os/comments/188bb7l/how_to_remove_old_kernel_config/
- https://unix.stackexchange.com/questions/741152/how-to-remove-old-kernel-images

  #### OPtional
  ----------------
*  To prevent future issues:
```
# Install and configure localpurge to keep /boot cleaner
sudo apt install localepurge

# Check kernel autoremove settings
sudo apt install ubuntu-maintenance-kit

# Create a cron job to clean old kernels monthly
sudo crontab -e
# Add: 0 0 1 * * apt autoremove --purge
```
* Alternative: Use purge-old-kernels script:
```
# Install the script
sudo apt install byobu  # Contains purge-old-kernels
# OR get it directly
wget https://raw.githubusercontent.com/royaldark/purge-old-kernels/master/purge-old-kernels
chmod +x purge-old-kernels
sudo ./purge-old-kernels --keep 2
```
* Create the autoremove configuration:
```  
  # Create the file to automatically remove old kernels
sudo tee /etc/apt/apt.conf.d/01autoremove-kernels << 'EOF'
# Automatically remove unused kernels
APT::Periodic::Autoremove-Kernels "true";
# Keep only the latest 2 kernels
APT::NeverAutoRemove "^linux-image-.*-generic";
APT::NeverAutoRemove "^linux-modules-.*-generic";
APT::NeverAutoRemove "^linux-headers-.*-generic";
EOF
```
