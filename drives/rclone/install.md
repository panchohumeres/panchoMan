## Linux installation

**Sources**:
- https://baizaar.tools/proton-drive-faq/how-to-install-proton-drive-on-linux/
- https://rclone.org/install/ -> Official Rclone Docs Install Instructions

### Precompiled binary
This is the recommended alternative for installing the latest version (with support for new drives). Other **installs such as those from .deb, flatpacks or other default Linux repositories tend to be outdated**.

From the [install instructions in official Rclone Docs](https://rclone.org/install/):

Note: **Assumes ```sudo``` install!!!! (System Wide Install)**

**Fetch and unpack**

```console
curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
unzip rclone-current-linux-amd64.zip
cd rclone-*-linux-amd64
```

Copy binary file

```console
sudo cp rclone /usr/bin/
sudo chown root:root /usr/bin/rclone
sudo chmod 755 /usr/bin/rclone
```

Install manpage

```console
sudo mkdir -p /usr/local/share/man/man1
sudo cp rclone.1 /usr/local/share/man/man1/
sudo mandb
```
Sanity Checks
```
### route to install
which rclone
### version
rclone version
### try a config
rclone config

```