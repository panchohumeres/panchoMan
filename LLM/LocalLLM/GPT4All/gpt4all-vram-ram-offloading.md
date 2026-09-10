
### GPT4All VRAM (GPU) / RAM offloading
----------------------------------------


**Sources**:
- https://github.com/nomic-ai/gpt4all/issues/1562


#### Install
-------------------
**Recommended (for Python CLI with conda env):** Install **CUDA in environment** (otherwise GPT4All will fall back only to CPU)

GPT4All looks for `libcudart.so.11.0` (**CUDA 11**) or `libcudart.so.12` (**CUDA 12**). Despite newer versions of CUDA being retrocompatible with older versions, GPT4All will fail in finding the CUDA libraries.

This command will install gpt4all bundled with the necessary CUDA libs:
```
pip install "gpt4all[cuda]"
```
If executed over an existing install of gpt4all CLI, it will overwrite and point the paths to the new libs.

#### Troubleshooting
----------------------
**Python CLI**:
This traceback when failing to load a model is an indicator that GPT4All ran out of memory when trying to load the model:
```python
Error allocating memory ErrorOutOfDeviceMemory
llama_model_load: error loading model: unable to allocate backend buffer
llama_load_model_from_file: failed to load model

```
#### Diagnostic / Check Memory Use
-----------------------------------------------------
After running a GPT4All instance, use the nvidia monitor utility:
```bash
nvidia-smi
```

Outputs such as 

```
+---------------------------------------------------+
| Processes:                                        |
|  GPU   ..   Type   Process name  GPU Memory Usage| |        ..                                
|===================================================|
|  .............................................
|    0   .... C+G   python                  2311MiB |
+---------------------------------------------------+
```

Indicate that the GPT4All app is using the GPU; in the example:
 - The  `Llama-3.2-3B-Instruct-Q4_0.gguf` model is being used.
 - The model is taking `2309 MiB` of VRAM.
 - **`C+G`** (Compute + Graphics) Mode; Tokens are being processed on the GPU cores.
#### Settings
------------------

**Setting partial GPU Offloading (UI)**:
You can set the number of layers to be processed by GPU
`Settings` -> `Model` (Model Settings) -> `GPU Layers`


#### Testing
----------------------------
Hybrid memory offloading setup (swap between GPU VRAM and RAM)
```python
import os #Environment variables
os.environ["GGML_CUDA"] = "1"
# N° of layers to load to VRAM
# Try values as cap for part of the model to send to gpu
os.environ["GGML_CUDA_NUMBER_OF_LAYERS"] = "10" 

from gpt4all import GPT4All

# Load Model pointing using GPU
model = GPT4All("DeepSeek-R1-Distill-Llama-8B-Q4_0.gguf", device="cuda") 


with model.chat_session(): response = model.generate("¿Hola, estás usando la GPU?") print(response)
```
```
ggml_backend_cuda_buffer_type_alloc_buffer: allocating 4170.00 MiB on device 
```
-------------------------------------
Written with assistance of gemini overviews