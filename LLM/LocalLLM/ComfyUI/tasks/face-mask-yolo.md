## YOLO Face Mask
----------------------
Use YOLO Model for painting a bounding box around the face in a body, and a mask on its countours.
### YOLO Face Bounding-Box
----------------------------------
**Sources**:
- https://github.com/ltdrdata/ComfyUI-extension-tutorials/blob/Main/ComfyUI-Impact-Pack/tutorial/advanced.md

###### Start ComfyUI
- Cd into in ComfyUI folder and activate conda env if necessary
			```
			conda activate comfyenv
			#for listing available environments
			conda env list			
				```
-  Launch with node manager and low vram mode (recommended)	```
		#lowvram mode & manager enabled
		python main.py --lowvram --enable-manager
- Go to url in terminal, usually:
		- - http://127.0.0.1:8188


#### Workflow Map

```
                               ┌───────────────────────────────────┐
[Load Image (Cuerpo)] ──(IMAGE)─> (pixels)                         │
                               │  [ VAE Encode (for Inpainting) ] ──(LATENT)─> (samples) [ VAE Decode ] ──> [ Preview Image ]
[BBOX Detector] ────────(MASK)──> (mask)                           │                 ^
                               └───────────────────────────────────┘                 │
[Load Checkpoint] ──────(VAE)────────────────────────────────────────────────────────┘

```


#### Installs
-  https://github.com/ltdrdata/ComfyUI-Impact-Pack/blob/Main/README.md
- https://www.comfyonline.app/comfyui-nodes/nodes/UltralyticsDetectorProvider
- https://github.com/ltdrdata/ComfyUI-Impact-Subpack
- https://huggingface.co/SG161222/Realistic_Vision_V5.1_noVAE/blob/main/Realistic_Vision_V5.1-inpainting.safetensors
1. ComfyUI **Impact-Pack**
2. ComfyUI **Impact-Subpack**
- Install both through Node Manager (recommended). It should download all required models automatically (YOLO).
- Impact Pack divided the project. YOLO-based tools were moved to "Impact-Subpack".
- Assumes Model `Realistic_Vision_V5.1-inpainting.safetensors` installed.

#### Workflow Nodes
1. **`VAE Encode (for Inpainting)`**: 
2. **`VAE Decode`**: (Clic derecho ->`latent` ->`VAE Decode`). Lo necesitamos para transformar los datos cortados de vuelta a una foto visible.
3. **Load Checkpoint**: (Clic derecho ->`Loaders` ->`Load Checkpoint`).
4. **`Preview Image`**: _(Clic derecho ->`image` ->`Preview Image`)_. Para ver el resultado final del agujero.
5. **`Load Image`**: Carga la foto limpia de la persona.
6. **`UltralyticsDetectorProvider`**: (Clic derecho-> `ImpactPack`-> `UltralyticsDetectorProvider`). Este nodo carga el modelo de detección. En su menú desplegable de modelos, selecciona el que dice bbox/face_yolov8m.pt (o cualquier modelo que termine en .pt y contenga la palabra face).
7. **`BboxDetectorToMask`**: (Clic derecho->`ImpactPack`-> `Detector` -> `BboxDetectorToMask`). Este nodo toma los datos del detector y los convierte en la máscara.
#### Workflow
- [Workflow Link (BBOX)](../workflows/yolo-face-bbox.json)
1. Si no está seleccionado por defecto, seleccionar `Realistic_Vision_V5.1-inpainting.safetensors` en nodo `Load CHeckpoint` (recomendado).
2. Seleccionar modelo **YOLO**: `UltralyticsDetectorProvider`-> En su menú desplegable de modelos, selecciona  **`bbox/face_yolov8m.pt`**.  
    (Nota: Si la lista te aparece vacía, ve al ComfyUI Manager, haz clic en **Install Models**, busca la palabra `yolo` y descarga el modelo `face_yolov8m.pt` para que se guarde en tu sistema).
2.  Darle la foto y el corte al VAE:**
    - Conecta la salida `IMAGE` (azul) de tu **`Load Image (Cuerpo)`** al puerto **`pixels`** del _VAE Encode (for Inpainting).
    - Conecta la salida `MASK` (morada) de tu **`BBOX Detector (combined)`** (tu cuadrado blanco) al puerto **`mask`** del _VAE Encode (for Inpainting)_ .
    - Trae el cable de tu cargador de modelos y conecta la salida `VAE` (roja) al puerto **`vae`** del _VAE Encode (for Inpainting)_ .
3. Ver el agujero en pantalla:**
    - Conecta la salida **`LATENT`** (morada) del _VAE Encode (for Inpainting)_ directo a la entrada **`samples`** del nodo **`VAE Decode`**.
    - Conecta el mismo cable `VAE` (rojo) del modelo al puerto **`vae`** del _VAE Decode_.
    - Conecta la salida `IMAGE` (azul) del _VAE Decode_ a la entrada de tu **`Preview Image`**.
4. Salida `IMAGE` de tu foto limpia -> Entrada **`image`** del nodo `BBOX Detector (combined)`.
5. Salida `BBOX_DETECTOR` del _UltralyticsDetectorProvider_ -> Entrada **`bbox_detector`** del nodo `BBOX Detector (combined)`.
6. Salida **`MASK`** del `BBOX Detector (combined)` -> Entrada **`mask`** del `Convert Mask to Image`.
7. Salida `IMAGE`del _Convert Mask to Image_ -> Entrada **`image`** del `Preview Image`.
#### Parameters

Dentro del nodo **`BBOX Detector (combined)`**, modifica los siguientes parámetros: 
- **`threshold`**: Ponlo en **`0.5`** (esto le dice a la IA qué tan segura debe estar de que eso es una cara antes de recortarla).
- **`dilation`**: Súbelo a un valor entre **`15` y `25`**. _Este paso es el más importante_: como YOLO detecta solo el "cuadrado" de las facciones, la `dilation` expande matemáticamente el recorte hacia afuera para asegurarse de incluir todo el cabello, las orejas y el contorno del cuello de la persona


#### Outputs
- **Bounding Box**:  Caja de colisión (_bounding box_ - YOLO)  cuadrada. El nodo **`BBOX Detector (combined)`** convirtió automáticamente los límites de ese cuadro en píxeles de color:

	- **Zona Negra:** Es un escudo de protección. Le indica a la IA que ignore todo lo demás (el fondo y los estampados de la camiseta) para que no los deforme.
	- **Zona Blanca:** Es la zona de perforación. Le indica a la IA el espacio exacto donde debe trabajar.
- **Imagen Original + Bounding Box**: 
	- En el lugar exacto donde antes estaba su cabeza, ahora verás un **cuadrado transparente, gris o lleno de estática de colores (píxeles de ruido puro)**

Yolo Face Mask
-----------------------------
- Updated Worfklow -[from the Bounding Box Workflow above](#workkflow) for masking the face with its contours.
- [Workflow Face Mask FIle](../workflows/yolo-face-mask.json)

#### Updated Workflow Map
```
[ Load Image (Cuerpo) ] ──────────(IMAGE)───────────> (image) ┐
                                                              │
[ UltralyticsDetectorProvider ] ──(BBOX_DETECTOR)───> (bbox_detector) [ BBOX Detector (SEGS) ]
                                                                             │
                                                                          (SEGS)
                                                                             v
[ SAMLoader ] ────────────────────(SAM_MODEL)───────> (sam_model) ───> [ SAMDetector (combined) ] ──(MASK)──> [ VAE Encode Inpainting ]
[ Load Image (Cuerpo) ] ──────────(IMAGE)───────────> (image) ───────> [                        ]

```


#### Updated Nodes
1. Añade el nodo **`SAMDetector (combined)`** (Clic derecho  `ImpactPack -> Detector -> SAMDetector (combined)`) .
2. Ve a tu nodo **`BBOX Detector (combined)`** y **bórralo** de la pantalla con la tecla `Delete`.
3. Haz clic derecho en el lienzo, ve al menú **`ImpactPack -> Detector`** y añade el nodo llamado exactamente: **`BBOX Detector (SEGS)`** [•].

#### Updated Workflow

1. **La Foto del Cuerpo:**
    - Toma la salida `IMAGE` de tu **`Load Image`** (imagen del cuerpo completo original).
    - Conéctala en **dos lugares a la vez**: en la entrada `image` de **`BBOX Detector (SEGS)`** y también en la entrada `image` de **`SAMDetector (combined)`** .
2. **El Detector YOLO:**
    - Toma la salida `BBOX_DETECTOR` de tu **`UltralyticsDetectorProvider`**.
    - Conéctala en la entrada `bbox_detector` de **`BBOX Detector (SEGS)`** .
3. **El Puente Inteligente (El cable verde):**
    - Toma la salida **`SEGS`** (círculo verde claro) de tu **`BBOX Detector (SEGS)`**.
    - Conéctala directamente en la entrada **`segs`** (círculo verde claro) de tu **`SAMDetector (combined)`** .
4. **El Modelo SAM:**
    - Toma la salida `SAM_MODEL` de tu **`SAMLoader`**.
    - Conéctala en la entrada `sam_model` de tu **`SAMDetector (combined)`** .
5. **Para ver el "Agujero" Perfecto de la Cabeza:**
    - Toma la salida **`MASK`** (morada) de tu **`SAMDetector (combined)`**.
    - Conéctala al puerto `mask` de tu **`VAE Encode (for Inpainting)`** .
    - _(Asegúrate de mantener el `VAE Encode` conectado al `VAE Decode` y al `Preview Image` tal como lo hicimos en el experimento anterior para poder ver el resultado en pantalla)_ .

#### Updated Output
En tu cuadros de **`Preview Image`**, el recuadro gris rígido y geométrico que viste antes desaparecerá por completo.

En su lugar, verás la foto del cuerpo con una **perforación anatómica perfecta que sigue fielmente la silueta de la cara**