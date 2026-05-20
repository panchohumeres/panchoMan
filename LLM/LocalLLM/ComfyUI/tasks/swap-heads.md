Swap Heads Workflow ComfyUI
---------------------------------------------------

**Sources**:
- https://comfyui.org/en/stable-diffusion-xl-instantid-face-swapping-workflow
- https://www.youtube.com/watch?v=bWlDo0ZJDz8&t=127s
- https://www.comfy.org/workflows/93f286fbc2c8-93f286fbc2c8/
- https://comfyui-wiki.com/en/comfyui-nodes/latent/inpaint/vae-encode-for-inpaint

**Caso de Uso** (en términos de uso de Hardware)
- **Cero desbordamiento de RAM:** Los modelos SD 1.5 pesan un 80% menos que Qwen o Flux. Caben perfectamente dentro de los 4 GB de tu tarjeta gráfica.
- **Procesamiento localizado:** La tarjeta gráfica solo realiza cálculos matemáticos en la zona pintada por tu máscara, ignorando el resto del cuerpo y el fondo, lo que ahorra el 70% de la energía de cómputo de la GPU.

Para cambiar la **cabeza completa de forma ligera**, la comunidad de ComfyUI utiliza una técnica clásica llamada **Inpainting con Máscara Manual (usando SD 1.5)**. Al igual que ReActor, este flujo no requiere un modelo multimodal gigante y se ejecuta en menos de 15 segundos en una GTX 1650.

### Instalaciones
#### Instalar Nodo IP-Adapter
- https://github.com/cubiq/ComfyUI_IPAdapter_plus
	1. En ComfyUI, en menú flotante de la derecha, abrir **Manager** (**"Extensions"** menú) -asume ComfyUI-Manager instalado-. 
			![](../assets/comfyui-node-manager-icon.png)
	2. Hacer click en botón **Install Custom Nodes**.
	3. En el cuadro de búsqueda superior, escribe exactamente: `IPAdapter plus`.
	![128](../assets/comfyui-node-manager-browser.png)
	4. En la lista de resultados, busca el paquete llamado **`ComfyUI_IPAdapter_plus`** (creado por el desarrollador _cubiq_).
	5. Haz clic en el botón **Install** al lado de su nombre.
	6. **Paso crucial para Linux:** Una vez que termine la instalación, cierra por completo la consola de tu terminal donde corre ComfyUI. Vuelve a iniciar el servidor ejecutando tu comando de seguridad:
	
#### Modelos
* https://huggingface.co/h94/IP-Adapter/blob/main/models/ip-adapter-plus_sd15.safetensors
* https://huggingface.co/axssel/IPAdapter_ClipVision_models/blob/main/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors
* https://huggingface.co/SG161222/Realistic_Vision_V5.1_noVAE/blob/main/Realistic_Vision_V5.1-inpainting.safetensors

	**Nota**: El nodo o plug-in central de este workflo (**IP-Adapter**) no descarga los modelos necesarios de forma automática al instalarlo, es necesario descargarlos manualmente (ver el repo en github del plug-in).
	1. **El Procesador Visual (CLIP Vision Model)**
	
		Para que el nodo IP-Adapter pueda "ver" y entender cómo es la cabeza de referencia (su forma, color de pelo, etc.), necesita un ojo artificial llamado CLIP Vision (pesa 2.5 GB):
		- **Descarga el Procesador:** CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors en Hugging Face (Haz clic en el botón _download_ de esa página).
		- **¿Dónde guardarlo?:** Coloca este archivo dentro de la carpeta:  
	    `ComfyUI/models/clip_vision/` [](https://huggingface.co/axssel/IPAdapter_ClipVision_models/tree/main)
	2. El **Modelo de Pintado (Inpainting Checkpoint)**

		Este es el archivo principal que se encargará de "dibujar" el cabello y la cabeza en la zona que selecciones con la máscara. Usaremos la versión de inpainting de un modelo fotorrealista de alto rendimiento y bajo consumo (pesa solo 2.1 GB):
		
		- **Descarga el Modelo:** [Realistic_Vision_V5.1-inpainting.safetensors en Hugging Face](https://huggingface.co/SG161222/Realistic_Vision_V5.1_noVAE/blob/main/Realistic_Vision_V5.1-inpainting.safetensors).
		- Coloca este archivo dentro de la carpeta`ComfyUI/models/checkpoints/` [](https://huggingface.co/SG161222/Realistic_Vision_V5.1_noVAE/blob/main/Realistic_Vision_V5.1-inpainting.safetensors)
	3.  El Cerebro del Adaptador (**IP-Adapter Model**)

		Este es el archivo matemático ultraligero (apenas 98 MB) que fusiona la foto de la cabeza de referencia con el modelo de inpainting: [](https://huggingface.co/docs/diffusers/using-diffusers/ip_adapter)
		- **Descarga el Adaptador:** [ip-adapter-plus_sd15.safetensors en Hugging Face](https://huggingface.co/h94/IP-Adapter/blob/main/models/ip-adapter-plus_sd15.safetensors).
		- Coloca este archivo dentro de la carpeta`ComfyUI/models/ipadapter/`  
		    _(Nota: Si no existe la carpeta `ipadapter` dentro de `models`, créala manualmente con ese nombre en minúsculas)._ [](https://huggingface.co/h94/IP-Adapter/blob/main/models/ip-adapter-plus_sd15.safetensors)



#### Nodos (Workflow)
- [Descargar Workflow de Ejemplo](../workflows/swap-heads.json)
Necesitas armar una estructura estándar de Stable Diffusion 1.5 pero configurada para edición: [](https://www.comfy.org/workflows/93f286fbc2c8-93f286fbc2c8/)
1. **Los Cargadores Base**
		- Añade un nodo **`Load Checkpoint`**: En su menú desplegable selecciona el modelo `Realistic_Vision_V5.1-inpainting.safetensors`, o un modelo ligero de Inpainting en formato SD 1.5 (por ejemplo: `realisticVisionV60_v60Inpainting.safetensors` o cualquier modelo `.safetensors` de 2 GB a 4 GB orientado a retratos).
		- Añade un nodo **`Load CLIP Vision`**: En su menú desplegable selecciona el archivo `CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors`.
		- Añade un nodo **`Load IPAdapter Model`**: Selecciona el archivo `ip-adapter-plus_sd15.safetensors`.
2. **Cargadores de Imágenes**
	Se van a crear **tres nodos Load Image**:
	- **`Load Image` Tradicional:** Entrega a la IA la foto "source" del cuerpo sobre el que se desea poner la nueva cabeza.
	- Segundo **`Load Image` Tradicional:** Entrega a la foto target (cuerpo de donde se quiere sacar la cabeza para ponerla en la primera imagen.)
	- **`Load Image (as Mask)`:** Genera el mapa matemático de corte (aquí cargas la foto del cuerpo de destino). Pintas con el pincel completamente la cabeza (con el cabello) y cuello que vas a borrar. Configuras el parámetro **`channel`** para que coincida exactamente con el color del pintado (recomendado: Rojo).
	El truco para que no se pinte la cara de color sólido en tarjetas de baja VRAM consiste en separar los canales.
3. nodo **VAE Encode (for Inpainting)**
	- Conecta la salida `IMAGE` del cuerpo en el nodo **`Load Image` Tradicional**  a su puerto `pixels`.
	- Conecta la salida `MASK` (el cable que sale del nodo del cuerpo cuando dejas el mouse encima) del nodo **`Load Image (as Mask)`** al puerto `mask`.
	- Conecta la salida `VAE` de tu _Load Checkpoint_ al puerto `vae` de este nodo.
4. El Bloque **IP-Adapter**
	- Haz clic derecho en el lienzo, ve a `IPAdapter` y selecciona **`IPAdapter Advanced`**. Este nodo será el encargado de transferir la forma de la cabeza.
	- **Conecta los cables hacia el `IPAdapter Advanced`:**
		- Une la salida `MODEL` de tu _Load Checkpoint_ al puerto `model` de entrada de este nodo.
		- Une la salida `ipadapter` de tu _Load IPAdapter Model_ al puerto `ipadapter` de este nodo.
		- Une la salida `clip_vision` de tu _Load CLIP Vision_ al puerto `clip_vision` de este nodo.
		- Añade un nodo **`Load Image`** (aquí cargas la foto de la cabeza de referencia), y conecta su salida `IMAGE` al puerto `image` de este nodo.
5. El Procesado Final (**KSampler**)
	Añade un nodo **`KSampler`** estándar.
	- **Conecta las salidas hacia el KSampler:**
		- Une la salida `MODEL` (la que sale del nodo _IPAdapter Advanced_, no la del checkpoint) al puerto `model` del KSampler.
		- Une las salidas de texto `CONDITIONING` (Positivo y Negativo de tus nodos de texto CLIP Text Encode) a sus respectivos puertos. _Consejo: En el texto positivo puedes escribir algo simple como "face portrait, highly detailed hair", no necesitas textos largos._
		- Une la salida `LATENT` de tu _VAE Encode (for Inpainting)_ al puerto `latent_image` del KSampler.
6. **Nodos Texto**
	- **Instrucciones de texto**: Qué quieres mantener y qué evitar o remover. Se usan dos nodos idénticos llamados **CLIP Text Encode**:
		1. Añadir los dos nodos de texto
		2. Haz clic derecho en una zona vacía de tu lienzo.
		3. Ve a **`conditioning`** y selecciona **`CLIP Text Encode (Prompt)`**. Repite esto para tener **dos nodos exactamente iguales**.
		4. Recomendación de nombres:
						    -  **"Positivo"** (lo que quieres ver).
						    - **"Negativo"** (lo que quieres evitar). 
	- **Conexiones de Textos**: Para que estos cuadros de texto funcionen, deben conectarse al "traductor" de tu modelo principal.
		1. Ve a tu nodo **`Load Checkpoint`** (a la izquierda de la pantalla).
		2. Haz clic en su salida **`CLIP`** (círculo amarillo).
		3. Arrastra un cable y conéctalo en la entrada **`clip`** (círculo amarillo) del nodo **Positivo**.
		4. Saca otro cable desde la misma salida **`CLIP`** del checkpoint y conéctalo en la entrada **`clip`** del nodo **Negativo**.
					- Conectar el texto al KSampler (Dar las órdenes)
					- Toma la salida **`CONDITIONING`** (círculo naranja) del nodo **Positivo** y conéctala al puerto **`positive`** (círculo naranja) del **`KSampler`**.
					- Toma la salida **`CONDITIONING`** (círculo naranja) del nodo **Negativo** y conéctala al puerto **`negative`** (círculo naranja) del **`KSampler`**.
	- **VAE Decode**: Finalmente, conecta la salida del KSampler a un nodo **`VAE Decode`** (usando el mismo cable VAE de tu checkpoint) y termina en un nodo **`Save Image`**.
	-  **Conecta los datos del KSampler:** Haz clic en la salida llamada **`LATENT`** (círculo morado/rosa) a la derecha de tu `KSampler` y arrastra el cable hasta la entrada **`samples`** (círculo morado/rosa) a la izquierda del nodo `VAE Decode`.
		1. **Trae el cable VAE desde el principio:** Ve hasta tu nodo **`Load Checkpoint`** (el primer nodo que pusiste a la izquierda de la pantalla). Haz clic en su salida **`VAE`** (círculo de color rojo/naranja) y arrastra un cable largo que cruce toda la pantalla hacia la derecha, conectándolo en la entrada **`vae`** del nodo `VAE Decode`.
		2. **Guarda el resultado:** Haz clic derecho en el lienzo, ve a `image` y selecciona **`Save Image`**. Conecta la salida **`IMAGE`** (círculo azul) del `VAE Decode` a la entrada **`images`** del nodo `Save Image`.


### Resumen del Workflow

**Imágenes**
1. **Load Image (Cuerpo)**: Sube la foto donde está el cuerpo listo.
2. **Load Image (Referencia)**: Sube la foto que tiene la cabeza y el cabello que quieres copiar.

 **Operaciones**
 - El modelo pasa por el **IP-Adapter** (donde conectas la foto de la cabeza de referencia) y luego va al **KSampler**.
 - La imagen enmascarada pasa por el **VAE Encode** y entra al puerto `latent_image` del **KSampler**.

#### Parámetros Clave
Cuando aplicas una máscara en la cabeza, el nodo `VAE Encode (for Inpainting)` expande un poco los bordes del recorte hacia los hombros y el pecho mediante el parámetro `grow_mask_by`. Al tener el **`denoise` muy alto (cercano a 1.0)**, la Inteligencia Artificial asume que tiene total libertad creativa para redibujar _todo_ lo que esté cerca de la zona de corte. Al intentar recrear la textura de la camiseta en las zonas limítrofes, la IA no entiende la tipografía o el diseño del estampado original (como las letras de "INFO") y los deforma o los "inventa" de forma abstracta.

 - En el **KSampler**, valores de **`denoise` a un rango entre 0.60 y 0.75**. _(Si lo dejas en 1.0, la IA inventará una cabeza aleatoria; al dejarlo en 0.65, usará la silueta del cuello y hombros originales para fusionar la cabeza nueva de forma anatómica y natural).
 -  **Ajustes recomendados  KSampler** :
	 para una GTX 1650
	 - `steps`: 20 o 25.
	 - `cfg`: 6.0 o 7.0.
	 - `denoise`: Configúralo estrictamente entre **0.60 y 0.70**. Si lo subes a 1.0 perderá la forma natural del cuello y la postura corporal de la foto original.
 -  **Bajar el `denoise` en el KSampler** a un valor entre **`0.65` y `0.75`** forzará a la IA a respetar la estructura y los diseños originales de la vestimenta y cuerpo en los bordes, enfocando su poder de generación únicamente en rellenar el cabello y el rostro.
- **Mantener el `grow_mask_by`**  en el nodo `VAE Encode (for Inpainting)`en valores bajos (por ejemplo, en **`4` o `6`**). Si es muy alto, la máscara se "desborda" hacia el pecho, distorsionando la vestimenta o el resto del cuerpo.
- **Prompts**
	- **En el nodo Positivo:** Escribe algo muy simple en inglés como `photorealistic face portrait, high quality hair, cinematic lighting`
	- **En el nodo Negativo:** Escribe cosas que no quieres que aparezcan, como `blurry, deformed, bad anatomy, low quality, drawing, illustration`

-------------------------------------------------------------------
 Generado con la asistencia de Gemini AI Overviews










---







---

