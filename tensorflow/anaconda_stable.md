## Tensorflow: Stable Install in Anaconda Virtual Environment
**Date**: January 2 2024
**Based on**: https://medium.com/@dev-charodeyka/tensorflow-conda-nvidia-gpu-on-ubuntu-22-04-3-lts-ad61c1d9ee32
**Tested on**: Pop Os ! Ubuntu 22.04 LTS , NVIDIA GEFORCE GTX 1650

1. Create Anaconda Environment based on Python 3.10
2. Open terminal and activate environment: ``` conda activate [environment name] ```
3. Install CUDA Toolkit and cudNN, with latest stable versions combinations:
     - Available versions in the conda-forge repository: (https://conda.anaconda.org/conda-forge/linux-64/):
     ``` conda install -c conda-forge cudatoolkit=11.8 cudnn=8.8 ```
4. Set Paths:
4.1 ``` mkdir -p $CONDA_PREFIX/etc/conda/activate.d ``` -> Create file for executing commands every time environment is activated
4.2 ```echo 'export LD_LIBRARY_PATH=$CONDA_PREFIX/lib/' > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh``` -> Change CUDA path (read from conva env instead of system)
4.3 Test paths: ``` conda deactivate
                     conda activate [environment name]
                     echo $LD_LIBRARY_PATH ```
5 Install Tensor RT:
  - Availible version of tensorrrt library: ```python -m pip index versions tensorrt```
  - Get Tensor RT Path: ```
python -m pip install tensorrt==8.5.3.1
TENSORRT_PATH=$(dirname $(python -c "import tensorrt;print(tensorrt.__file__)")) ```
  - Test Tensor RT PATH: ```echo $TENSORRT_PATH```
  - Append Tensor RT Path to env startup file:
      - ```echo 'TENSORRT_PATH=$(dirname $(python -c "import tensorrt;print(tensorrt.__file__)"))' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh```
      - ```echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TENSORRT_PATH' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh```

   
