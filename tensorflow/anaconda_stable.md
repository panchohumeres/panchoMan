## Tensorflow: Stable Install in Anaconda Virtual Environment
- **Date**: January 2 2024
- **Based on**: https://medium.com/@dev-charodeyka/tensorflow-conda-nvidia-gpu-on-ubuntu-22-04-3-lts-ad61c1d9ee32
- **Tested on**: Pop Os ! Ubuntu 22.04 LTS , NVIDIA GEFORCE GTX 1650

- **Solution for Tensor Flow installs in Anaconda ENVS that read systems CUDA Libraries (CUDA Toolkit and cudNN) instead of Conda Env Cuda libraries** :

  * For example when Cuda Toolkit and cudNN are installed using Conda and TF using ```pip install tensorflow``` or ```conda install -c conda-forge tensorflow```.
  * Or using tensorflow install with CUDA Libs. as recommended by TF docs: ```pip install tensorflow[and-cuda]``` -> https://www.tensorflow.org/install/pip?hl=es-419
  * Example errors reported:
    - https://github.com/tensorflow/tensorflow/issues/52988
    - https://github.com/tensorflow/tensorflow/issues/62075
    - https://github.com/tensorflow/tensorflow/issues/61468
    - https://github.com/tensorflow/tensorflow/issues/42738
    - https://stackoverflow.com/questions/76028164/tensorflow-object-detection-tf-trt-warning-could-not-find-tensorrt
```
  python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
2023-12-24 14:10:34.169720: I tensorflow/core/util/port.cc:113] oneDNN custom operations are on. You may see slightly different numerical results due to floating-point round-off errors from different computation orders. To turn them off, set the environment variable `TF_ENABLE_ONEDNN_OPTS=0`.
2023-12-24 14:10:34.190123: E external/local_xla/xla/stream_executor/cuda/cuda_dnn.cc:9261] Unable to register cuDNN factory: Attempting to register factory for plugin cuDNN when one has already been registered
2023-12-24 14:10:34.190150: E external/local_xla/xla/stream_executor/cuda/cuda_fft.cc:607] Unable to register cuFFT factory: Attempting to register factory for plugin cuFFT when one has already been registered
2023-12-24 14:10:34.190697: E external/local_xla/xla/stream_executor/cuda/cuda_blas.cc:1515] Unable to register cuBLAS factory: Attempting to register factory for plugin cuBLAS when one has already been registered
2023-12-24 14:10:34.193989: I tensorflow/core/platform/cpu_feature_guard.cc:182] This TensorFlow binary is optimized to use available CPU instructions in performance-critical operations.
To enable the following instructions: AVX2 AVX_VNNI FMA, in other operations, rebuild TensorFlow with the appropriate compiler flags.
2023-12-24 14:10:34.541756: W tensorflow/compiler/tf2tensorrt/utils/py_utils.cc:38] TF-TRT Warning: Could not find TensorRT
2023-12-24 14:10:34.771530: I external/local_xla/xla/stream_executor/cuda/cuda_executor.cc:901] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero. See more at https://github.com/torvalds/linux/blob/v6.0/Documentation/ABI/testing/sysfs-bus-pci#L344-L355
2023-12-24 14:10:34.791450: I external/local_xla/xla/stream_executor/cuda/cuda_executor.cc:901]  uccessful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero. See more at https://github.com/torvalds/linux/blob/v6.0/Documentation/ABI/testing/sysfs-bus-pci#L344-L355
2023-12-24 14:10:34.791543: I external/local_xla/xla/stream_executor/cuda/cuda_executor.cc:901] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero. See more at https://github.com/torvalds/linux/blob/v6.0/Documentation/ABI/testing/sysfs-bus-pci#L344-L355
[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```
#### Steps
1. Create Anaconda Environment based on Python 3.10
2. Open terminal and activate environment: ``` conda activate [environment name] ```
3. Install CUDA Toolkit and cudNN, with latest stable versions combinations:
     - Available versions in the conda-forge repository:
           -  https://conda.anaconda.org/conda-forge/linux-64/
           - https://anaconda.org/conda-forge/cudatoolkit
     - command: ``` conda install -c conda-forge cudatoolkit=11.8 cudnn=8.8 ```
4. Set Paths:
       - ``` mkdir -p $CONDA_PREFIX/etc/conda/activate.d ``` -> Create file for executing commands every time environment is activated
       - ```echo 'export LD_LIBRARY_PATH=$CONDA_PREFIX/lib/' > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh``` -> Change CUDA path (read from conva env instead of system)
   - Test paths:
```
conda deactivate
conda activate [environment name]
echo $LD_LIBRARY_PATH
```
6. Install Tensor RT:
   - Available version of tensorrrt library: ```python -m pip index versions tensorrt```
   - Install Tensor RT: ```python -m pip install tensorrt==8.5.3.1```
   - Get Tensor RT Path: ```TENSORRT_PATH=$(dirname $(python -c "import tensorrt;print(tensorrt.__file__)")) ```
   - Test Tensor RT PATH: ```echo $TENSORRT_PATH```
   - Append Tensor RT Path to env startup file:
```
     echo 'TENSORRT_PATH=$(dirname $(python -c "import tensorrt;print(tensorrt.__file__)"))' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TENSORRT_PATH' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
   conda deactivate
```
8. Install Tensor Flow:
     - ```conda activate [environment name]```
     - ```python -m pip install tensorflow==2.13``` -> Check last version available that doesn´t cause trouble with CUDA libraries in Conda ENV
9. Test (in Conda ENV):
     - ```python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"```
     - in python test cudNN version:
       ```python
       from tensorflow.python.platform import build_info as tf_build_info
       print('cudnn version: ',tf_build_info.build_info['cudnn_version'])
       print('cudnn version: ',tf_build_info.build_info['cuda_version'])
       ```
     - Test if they are different from system's Cuda (Outside Conda Env):
       * ```nvcc --version``` -> CUDA Toolkit
       * ```nvidia-smi``` -> CUDA Driver and GPU status
     - Device details:
       ```python
              from tensorflow.python.client import device_lib
              print(device_lib.list_local_devices())
       ```
     - Device names and memory usage:
       ```python
       gpu_devices = tf.config.list_physical_devices('GPU')
       if gpu_devices:
         details = tf.config.experimental.get_device_details(gpu_devices[0])
         print(details)
         print(tf.config.experimental.get_memory_info('GPU:0'))
       ```
     - Test TF is using GPU (from    https://www.tensorflow.org/guide/gpu?hl=es-419):
       ```python
       tf.debugging.set_log_device_placement(True)
       # Create some tensors
       a = tf.constant([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]])
       b = tf.constant([[1.0, 2.0], [3.0, 4.0], [5.0, 6.0]])
       c = tf.matmul(a, b)

       print(c)
       ```     
10. Install Jupyter Notebooks:
       * Install ipykernel (for jupyter notebooks seeing this kernel):
         ```
         python -m pip install ipykernel
         ```
       * Set up kernel for this environment (with name):
         ```
         python -m ipykernel install --user --name=[your-kernel-name]
         ```
       * Install jupyter notebooks with conda (conda-forge repo):
         ```conda install -c conda-forge notebook```
       * Launch notebooks, then select [your-kernel-name] kernel:
         ```conda install -c conda-forge notebook```
       * Testing -> get list of packages installed, with source (python, conda, etc.) : ```jupyter-notebook```
12. Solve "NUMA node information" warning (optional):
    Non-fatal warning, refer to solutions (fix at system level, non-permanent):
     - Solution by Zukhriddin (Applies to system kernel, not only conda env): https://zrruziev.medium.com/fixing-the-successful-numa-node-read-from-sysfs-had-negative-value-1-but-there-must-be-at-7d798d5b912d
     - https://gist.github.com/zrruziev/b93e1292bf2ee39284f834ec7397ee9f
     - https://stackoverflow.com/questions/44232898/memoryerror-in-tensorflow-and-successful-numa-node-read-from-sysfs-had-negativ -> how to make fix permanent
     - https://github.com/tensorflow/tensorflow/issues/42738 -> states is non-fatal warning
     - https://www.kaggle.com/discussions/questions-and-answers/272476 -> warning not error
   
### Diagnostics
```python
import tensorflow as tf

print(tf.__version__)


# if all these tests are true and compiler tests fail, problem is Tensor RT
tf.test.is_built_with_gpu_support()
tf.test.is_built_with_gpu_support()
tf.test.is_built_with_cuda()

from tensorflow.python.platform import build_info as tf_build_info
tf_build_info.build_info
tf_build_info.build_info['cpu_compiler']
tf_build_info.build_info['cuda_compute_capabilities']
tf_build_info.build_info['is_cuda_build']
tf_build_info.build_info['is_tensorrt_build']

import tensorflow.compiler as tf_cc
tf_cc.tf2tensorrt._pywrap_py_utils.get_linked_tensorrt_version() #linked Tensor RT version
tf_cc.tf2tensorrt._pywrap_py_utils.get_linked_tensorrt_version() #Actually loaded Tensor RT version, breaks if wrong
```

   
#### Other Untested approaches:
- https://copyprogramming.com/howto/how-to-use-gpu-in-tensorflow
- https://gretel.ai/blog/install-tensorflow-with-cuda-cdnn-and-gpu-support-in-4-easy-steps
- https://copyprogramming.com/howto/how-to-set-the-cuda-path-in-the-conda-environment
- http://www.sciama.icg.port.ac.uk/gpu_anaconda.html
- https://github.com/prodramp/DeepWorks/tree/main/DeepLearningRig -> install CUDA toolkit and CudNN in system, and rest in conda
- https://phoenixnap.com/kb/how-to-install-tensorflow-ubuntu -> with miniconda (changing lib paths in same fashion)

   

   
