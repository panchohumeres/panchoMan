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

### Alternative IDEs
WanGP by DeepBeepMeep : The best Open Source Video Generative Models Accessible to the GPU Poor
WanGP supports the Wan (and derived models) but also Hunyuan Video, Flux, Qwen, Z-Image, LongCat, Kandinsky, LTXV, LTX-2, Qwen3 TTS, Chatterbox, HearMula, ... with
- https://github.com/deepbeepmeep/Wan2GP

### Memory Problems
Si el sistema está tan congelado que el puntero del mouse no se mueve, significa que tu computadora se quedó sin memoria RAM libre (un estado llamado Out of Memory o OOM) y está colapsada.
Dado que no puedes usar el mouse, debes usar el teclado para forzar el cierre de Chrome mediante la terminal. Sigue estos pasos en orden:
- Opción 1: Abrir la terminal a la fuerza (Prueba esto primero)
  Presiona la combinación Ctrl + Alt + T (o la tecla Super/Windows y escribe terminal si responde un poco).
  Si la ventana de la terminal se abre, escribe el siguiente comando exacto y presiona Enter:
  ```
  bash
  pkill chrome
  ```
  Esto cerrará instantáneamente todos los procesos de Google Chrome en segundo plano y liberará tu VRAM.
- Opción 2: Cambiar a una TTY (Consola del sistema pura)
  Si la interfaz gráfica no reacciona para nada y Ctrl + Alt + T no funciona, debes salir temporalmente del escritorio:
  Presiona Ctrl + Alt + F3 (puedes probar desde F3 hasta F6). La pantalla se volverá negra y te pedirá tu nombre de usuario y contraseña de Linux.
  Inicia sesión escribiendo tu usuario, presiona Enter, introduce tu contraseña y presiona Enter.
  Una vez dentro de la línea de comandos, escribe:
  ```
  bash
  pkill chrome
  ```
  Para regresar a tu escritorio gráfico normal, presiona Ctrl + Alt + F2 (o Ctrl + Alt + F1, dependiendo de tu distribución de Linux).
- Opción 3: Resetear.

### Free System Resources 
**Sources**:
  - https://www.reddit.com/r/StableDiffusion/comments/yzzcii/black_images_with_gtx1080ti/
  - https://github.com/Comfy-Org/ComfyUI/issues/10852
  - https://medium.com/@wltsankalpa/benchmarking-qwen-models-across-nvidia-gpus-t4-l4-h100-architectures-finding-your-sweet-spot-a59a0adf9043
  - https://www.reddit.com/r/StableDiffusion/comments/1q0ccdv/psa_still_running_gguf_models_on_midlow_vram_gpus/
  - https://www.reddit.com/r/StableDiffusion/comments/1q0ccdv/psa_still_running_gguf_models_on_midlow_vram_gpus/

En tarjetas gráficas como GTX 1080 (lanzada en 2016), sin configuraciones adicionales el sistema sufre un estrangulamiento crítico de hardware debido a la falta de optimización del flujo de trabajo y al consumo de recursos en segundo plano (es completamente normal que tarden horas).
Los modelos como Qwen-Image y sus variantes de instrucción (Instruct) son extremadamente pesados y están diseñados para tarjetas modernas con núcleos de Inteligencia Artificial (Tensor Cores) y mucha más memoria de video (VRAM).
- **Liberación de VRAM**: Los navegadores modernos usan aceleración por hardware. Una sola pestaña de YouTube reproduciendo video puede llegar a robarle entre 1 GB y 2 GB de VRAM a tu tarjeta. Para tu GTX 1080 (que solo tiene 8 GB), recuperar esa memoria es la diferencia entre que el workflow funcione o se congele.
- **Retorno a la velocidad de la GPU**: Al recuperar esa VRAM libre, evitarás que ComfyUI se desborde hacia la memoria RAM de tu computadora (la cual es extremadamente lenta para tareas de Inteligencia Artificial). Al mantener los datos dentro de la tarjeta de video, el procesamiento se agilizará notablemente.
- **Conflicto de VRAM con el navegador**: Los navegadores basados en Chromium (como Google Chrome) consumen mucha VRAM al reproducir videos de YouTube. Arquitecturas como GTX sólo tienen 8 GB de VRAM. Si Chrome y YouTube te están robando 1.5 GB o 2 GB, ComfyUI se queda sin espacio.
- **Desbordamiento a la RAM (SysMem)**: Cuando ComfyUI supera los 8 GB de VRAM física, Windows activa la "Memoria compartida de GPU" y empieza a usar la memoria RAM normal de tu computadora. La RAM de la PC es hasta 10 veces más lenta que la VRAM de la tarjeta de video, lo que destruye el rendimiento y hace que el proceso pase de tardar segundos a tardar horas.
- **Falta de arquitectura moderna**: Tarjetas como GTX 1080 **no procesa de forma nativa los formatos de datos actuales (como FP16 o BF16)**. ComfyUI tiene que hacer conversiones matemáticas complejas en formato FP32, sobrecargando el chip de la tarjeta.
- **Falta de Tensor Cores**: Al no tener aceleración nativa por hardware para matrices de IA, la tarjeta debe emular o convertir formatos modernos como FP8 o BF16 a FP32, lo que genera un cuello de botella.
- **Restricción de VRAM (8 GB)**: Modelos base como Qwen-Image son masivos. Intentar cargar el modelo original sin optimizar consumirá toda la memoria de video de 8 GB y causará errores de desbordamiento (Out of Memory) o forzará al sistema a usar la RAM común, ralentizando la generación a varios minutos por imagen.

#### Reduce temporalmente la resolución
Mencionas que estás usando una "resolución estándar". Para modelos modernos, el estándar actual es 1024x1024 píxeles. Para tarjetas como GTX 1080, esto es demasiado.
Modifica el nodo Empty Latent Image de tu flujo de trabajo.
Baja los valores a 512x512 o máximo 768x768 píxeles. Notarás un aumento de velocidad dramático.


### Install Node for Compressed (Qunatized) Models (GGUF)
**Sources**:
  - https://dev.to/gary_yan_86eb77d35e0070f5/qwen-image-2512-gguf-complete-guide-to-running-ai-image-generation-on-consumer-hardware-1l6c
  - 

Preparar ComfyUI para abrir archivos GGUF: 
  1. Dentro de la interfaz de ComfyUI, abre el ComfyUI Manager (el menú flotante de la derecha).
  2. Haz clic en Install Custom Nodes.
  3. Busca el nodo llamado ComfyUI-GGUF e instálalo.
  4. Reinicia la interfaz de ComfyUI (o la consola) para que el cambio surta efecto. 

### Configurar ComfyUI en Modo de Baja Memoria (Bajo Linux)
**Sources**:
  - https://docs.comfy.org/interface/settings/server-config
  - https://github.com/Comfy-Org/ComfyUI/issues/2914
  - https://comfyui-wiki.com/es/tutorial/advanced/image/qwen/qwen-image
Esto fragmenta el modelo y lo procesa por partes en la GPU. 
Ejecuta el entorno virtual o el script de inicio añadiendo obligatoriamente los argumentos --lowvram y --fp8_e4m3fn-textenc. El comando debería lucir similar a esto:
   ```
  python main.py --lowvram --fp8_e4m3fn-textenc
   ```
Al iniciar tu entorno local, asegúrate de añadir los comandos --medvram o --lowvram en el archivo ejecutable (.bat o consola). Esto obligará al sistema a descargar partes del modelo en la memoria RAM del sistema cuando no se estén usando.

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
- **Utiliza Versiones Cuantizadas (GGUF)**: No intentes usar el modelo original. Descarga versiones altamente comprimidas del modelo como Z-Image Turbo GGUF (versiones Q3_K_S o Q4_K_M), diseñadas específicamente para funcionar en hardware con poca VRAM.
- **Usa un VAE Ultra-Ligero**: En lugar de cargar el codificador visual (VAE) estándar de Flux o Qwen, configura un nodo de carga con TAEF1 (Tiny AutoEncoder). Esto reduce el consumo de VRAM de manera masiva al decodificar la imagen final.

**Ejemplos modelos de QWEN optimizados (recomendados)**:
**Sources**:
- https://huggingface-co.translate.goog/city96/Qwen-Image-gguf?_x_tr_sl=en&_x_tr_tl=es&_x_tr_hl=es&_x_tr_pto=sge
- https://www.patreon.com/posts/unlock-new-qwen-136833633
- https://huggingface.co/QuantStack/Qwen-Image-Edit-GGUF
- https://huggingface.co/QuantStack/Qwen-Image-Edit-GGUF/tree/main
- https://huggingface.co/unsloth/Qwen2.5-VL-7B-Instruct-GGUF/tree/main

El Modelo de Difusión Principal (GGUF):
  - Descarga la versión Q4_K_M o Q3_K_S desde el repositorio QuantStack/Qwen-Image-Edit-GGUF o del desarrollador city96/Qwen-Image-gguf. Estos reducen el peso del archivo a unos 4 GB o 5 GB.
  Ruta de guardado:
  ```
  ComfyUI/models/unet/ o ComfyUI/models/diffusion_models/
  ```
  - El Codificador de Texto (CLIP) en FP8:
  Descarga el archivo qwen_2.5_vl_7b_fp8_scaled.safetensors.
  Ruta de guardado:
  ```
  ComfyUI/models/text_encoders/
  ```
  - El Decodificador Visual (VAE):
  Descarga el archivo qwen_image_vae.safetensors.
  Ruta de guardado:
  ```
    ComfyUI/models/vae/
  ```


  







