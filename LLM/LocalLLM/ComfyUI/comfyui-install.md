## Install ComfyUI Linux - Conda Install (NVIDIA)
--------------------------------------------------

Sources: 
 - ComfyUI Docs https://docs.comfy.org/installation/manual_install#nvidia


1. Create an environment with Conda.
```

conda create -n comfyenv
conda activate comfyenv
```
2. Clone the ComfyUI code repository
Note: Assumes location of public repo https://github.com/Comfy-Org/ComfyUI (tap on code -> clone for getting the https url)
```
git clone https://github.com/Comfy-Org/ComfyUI.git
```

3. Install GPU dependencies
**Note**: Differs slightly from the install instructions on ComfyUI (Torch installs) due to broken install (see troubleshooting)
```
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
conda install pytorch -c pytorch -c nvidia
```
4. RUN
```
cd ComfyUI
python main.py
```

### Troubleshooting
---------------------
#### Broken install due to problems with pytorch.
If Following ComfyUI NVIDIA GPU dependencies instructions:
```
conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia
```
And then getting this error when running:
```
comfy h/__init__.py", line 229, in <module> from torch._C import * # noqa: F403 ^^^^^^^^^^^^^^^^^^^^^^ ImportError: /home/fhumeres/anaconda3/envs/comfyenv/lib/python3.11/site-packages/torch/lib/libtorch_cpu.so: undefined symbol: iJIT_NotifyEvent
```
Accordin to Google Overview -> The ImportError: undefined symbol: iJIT_NotifyEvent error occurs when there is a mismatch between PyTorch and the Intel Math Kernel Library (MKL) versions in your Conda environment. This typically happens because PyTorch 2.5+ is built against MKL 2024.2, but some Conda resolvers default to installing a newer, incompatible MKL
**Solution**:
  a. Uninstall torch
  ```
  pip uninstall torch torchvision torchaudio
  ```
  b. Reinstall with CUDA support
  ```
  pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
  ```
  Sources:
  
    - https://github.com/Comfy-Org/ComfyUI/issues/10259#issuecomment-3380711477
    - https://github.com/jeffffffli/HybrIK/issues/246
