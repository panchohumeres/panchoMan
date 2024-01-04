### Install NVIDIA-docker toolkit

## Stable installation for Pop OS:
  - based on nvidia-docker2 (apprently will not be supported in the future) and Pop OS **22.04**

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
