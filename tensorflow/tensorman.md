### Install NVIDIA-docker toolkit

#### Docker-Engine Background:
Docker Engine as installed by Docker Desktop and installed in the system have different **"contexts"** (paths, environments, etc.). Most notably:
- System docker daemon is at : ```/etc/docker/daemon.json``` -> [https://docs.docker.com/desktop/settings/linux/#docker-engine](https://docs.docker.com/config/daemon/)
- Docker Desktop daemon is at: ```$HOME/.docker/daemon.json``` -> https://docs.docker.com/desktop/settings/linux/#docker-engine
- They can be **installed side by side**.
  
Switching **contexts** (https://docs.docker.com/desktop/faqs/linuxfaqs/):
- list contexts: ```docker context ls```
- Usally "default" is system engine, and "desktop-linux" is desktop.
- ```*``` Indicates the active context.
- To swith to default context for example: ```docker context use default```

#### Install System Docker Engine:
Refs:
  - https://docs.docker.com/engine/install/ubuntu/
  - [https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/linux-postinstall/)
1. Set up Docker's apt repository.
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
2. Install the Docker packages.
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
3. Create the docker group, Add your user to the docker group.
```
sudo groupadd docker
sudo usermod -aG docker $USER
```
4. Restart computer.
5. TEST:
```
docker run hello-world
```


#### Stable installation for Pop OS:
  - based on nvidia-docker2 (apprently will not be supported in the future) and Pop OS **22.04**
  - To see the difference with most updated nvidia-toolkit see:
    * https://gist.github.com/kuang-da/2796a792ced96deaf466fdfb7651aa2e
  - Based on solution by Nikita Melkozerov:
    * https://nikita.melkozerov.dev/posts/nvidia-docker-pop-os-install/
    

1. set the priority of the official Nvidia repo higher (apparently Pop OS uses a different one):
  - Create file:
  ```
  sudo nano /etc/apt/preferences.d/nvidia-docker-pin-1002
  ```
  - Add the following lines here:
  ```
  Package: *
  Pin: origin nvidia.github.io
  Pin-Priority: 1002
  ```
2. Create env var with a distribution name. For Pop!OS 22.04 it is ubuntu22.04. Change according to your distro:

```
export distribution=ubuntu22.04
```

3. 
```
  curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
  echo $distribution
  curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
  sudo apt-get update
  sudo apt-get install -y nvidia-docker2
  sudo systemctl restart docker
```

4. TEST:
```
docker run --rm --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
```
