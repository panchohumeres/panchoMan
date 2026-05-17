## Troubleshooting related to Hardware Optimizations
----------------------------------------------------------


### Resource Managers
Custom "Nodes" (Plug-ins) for hardware resources monitoring (CPU, RAM, GPU, VRAM, etc. available):
- https://www.youtube.com/watch?v=OFYxair2pKQ
1. **crystools**:
  - https://github.com/crystian/comfyui-crystools
  - Install (within corresponding conda env):```cd ComfyUI/custom_nodes
  git clone https://github.com/crystian/comfyui-crystools.git
  cd comfyui-crystools
  pip install -r requirements.txt```
2. **ComfyUI-Elegant-Resource-Monitor**
    - https://comfy.icu/extension/ChrisColeTech__ComfyUI-Elegant-Resource-Monitor
    - https://www.floyo.ai/all-comfyui-nodes/comfyui-elegant-resource-monitor-chriscoletech
   
CLI Monitoring
 - NVIDIA:
   ```
   #Run this command to print a clean summary of your total, used, and free video memory:
   nvidia-smi --query-gpu=memory.total,memory.used,memory.free --format=csv
   #If you want a shorter, faster command that only prints the exact number of free Megabytes, use this:
   nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits
   #real time monitoring
   nvidia-smi -l 1
   ```
- System: Run the standard free command with the -h flag to see your system memory in human-readable gigabytes:
  ```
  free -h
  ```
- Pro-Tip: The "All-in-One" Custom Command
  ```
  echo "--- FREE VRAM ---"; nvidia-smi --query-gpu=memory.free --format=csv,noheader; echo "--- FREE RAM ---"; free -h | grep   Mem | awk '{print $7 " available"}'
  ```

  ### Model Selection
**Sources**:
  - https://github.com/comfyui-wiki/ComfyUI-Wiki-Workflows
  - https://docs.comfy.org/tutorials/image/qwen/qwen-image-edit
  - https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO
  - https://comfyui-wiki.com/en/tutorial/advanced/image/qwen/qwen-image
  - https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO
  - https://docs.comfy.org/tutorials/image/z-image/z-image


Usar modelos especializados, flujos de edición alternativos, destilados u versiones pequeñas.
La razón técnica es que, para poder hacer una edición basada en instrucciones (por ejemplo, cambiarle la ropa a alguien o añadir un objeto), la tarjeta gráfica debe realizar un proceso doble: primero tiene que usar un codificador visual (VAE Encoder) para "leer" y transformar tu imagen original en datos matemáticos (lo que consume VRAM extra), y luego debe ejecutar el mismo número de pasos de difusión (KSampler) para fusionar tu orden de texto con la imagen.
- **Modelos de Un Solo Paso (Lightning o Turbo)**: Tanto para generar como para editar, existen versiones llamadas Lightning o Hyper. Si descargas e integras un Lightning LoRA en tu flujo de trabajo, el nodo KSampler solo necesitará calcular 4 pasos (Steps) en lugar de los 20 o 30 habituales. Esto reduce el tiempo de procesamiento en un 80%.
- **Inpainting Tradicional (Pintado de máscaras)**: En lugar de usar modelos multimodales gigantescos como Qwen (de 20B de parámetros), utiliza modelos tradicionales de Inpainting basados en SD 1.5 o SDXL. Creas una máscara negra sobre la zona exacta que quieres cambiar (por ejemplo, el fondo) y la IA solo trabajará en esos píxeles, dejando el resto intacto. Una GTX 1080 maneja SD 1.5 en cuestión de segundos.
- **Modelos de ControlNet Estructurales**: Herramientas como Canny o Depth te permiten subir una imagen, extraer sus líneas o silueta, y generar algo nuevo basándose exclusivamente en esa estructura básica. Al no tener que interpretar semánticamente la imagen completa mediante un codificador de lenguaje pesado, la tarjeta gráfica trabaja mucho más holgada

  







