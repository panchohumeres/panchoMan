
### Problem Description

- In GUI get the error ``` failed to spawn process /bin/sh```
- No program can be executed from GUI, nor the terminal nor the reboot button works.
- After accessing terminal ( Ctrl + Alt + F4-F6 ), cannot input any command, and get log ```failed to write entry …. …..despite vacumming, ignoring: input:output error```


### Steps to Solve
1. Forced Reboot (Safe Approach)
Try SysRq (Magic Key) Reboot – This is the safest way to force a reboot without damaging filesystems:

        Hold Alt + SysRq (Print Screen) and slowly press:

            R (Switch to raw mode)

            E (Send terminate signal to processes)

            I (Kill non-responsive processes)

            S (Sync filesystems)

            U (Remount filesystems read-only)

            B (Reboot)

        Wait a second between each key press.

2. Identify the Root Partition
 (it is assumed that after reboot the OS most likely will get into `initramfs`
Run the following commands in the ```initramfs``` prompt:
```blkid```
Example output:
```
/dev/nvme0n1p1: UUID="A1B2-C3D4" TYPE="vfat" PARTLABEL="EFI"  
/dev/nvme0n1p2: UUID="abcd1234-5678-..." TYPE="ext4" PARTLABEL="ROOT"  
/dev/nvme0n1p3: UUID="efgh5678-9012-..." TYPE="swap"  
/dev/sda1: UUID="ijkl9012-3456-..." TYPE="btrfs" PARTLABEL="HOME"
```
What to look for:

    Filesystem type:
    Pop!_OS typically uses ext4 or btrfs for the root partition.
    (Avoid vfat [EFI boot], swap, or ntfs [Windows partitions].)

    Labels:
    Some partitions have labels like ROOT, POP_OS, or rootfs.

    UUID format:
    Linux root partitions usually have a long UUID (e.g., abcd1234-5678-...).

In the example above, `/dev/nvme0n1p2` is likely the root partition (ext4, no "EFI" or "swap" label).
Usually in Pop OS 64 the root partition would be called `/dev/data-root`.

3. Run `fsck -y /dev/data-root` for repairing the unit (replace with the corresponding root unit).

3.1. Verifify Root partition
if step 3 fails because `fsck` tells you that the root unit doesn't exist:
Option A: Check device mapper:
```ls /dev/mapper/     # Look for "data-root"```
If you see /dev/mapper/data-root, run:
```fsck -y /dev/mapper/data-root```

System should boot into normal GUI asking for password.

5. After succesful boot into GUI:
Check disk health
```
 sudo smartctl -a /dev/nvme0n1     # For NVMe (replace with your disk, e.g., /dev/sda)  
sudo journalctl -xb -p3           # Check for recurring errors  ```






