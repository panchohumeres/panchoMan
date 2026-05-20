Opción 2: Ultralytics YOLO Face/Head Detection (La más rápida)

YOLO es un modelo de visión artificial famosísimo por su velocidad extrema. No genera imágenes, solo detecta formas mediante cajas de colisión (bounding boxes).

- **Cómo funciona:** Colocas el nodo `YOLO Bounding Box Detector` conectado a tu imagen del cuerpo de destino. Utilizas un archivo de entrenamiento específico para rostros o cabezas (como `bbox/face_yolov8m.pt`). El nodo detectará la cabeza instantáneamente y entregará un recorte perfecto de tipo `MASK` directamente al puerto del `VAE Encode`.
- **El Trade-off:** A veces los modelos de rostro YOLO cortan muy al ras en la mandíbula y dejan fuera parte del cuello largo o del cabello muy voluminoso. Tendrías que compensarlo subiendo un poco el `grow_mask_by`.
- **Cómo instalarlo:** También viene incluido dentro del paquete **`ComfyUI-Impact-Pack`**.

```
[ Load Image (Cuerpo limpio) ] ---> [ Detector Automático (YOLO o SAM) ] 
                                                   |
                                            (Salida MASK limpia)
                                                   v
                                      [ VAE Encode (for Inpainting) ]

```

Opción 2: Flujo Automático ultrarrápido con YOLO

sistema YOLO, el cual usa "cajas de detección" preentrenadas.

1. Agregar los Nodos al Lienzo

- Haz clic derecho, ve a `ImpactPack` y añade el nodo **`UltralyticsDetectorProvider`**. En su menú desplegable de modelos, selecciona uno orientado a rostros (como `bbox/face_yolov8m.pt` o `bbox/hand_yolov8s.pt` si viene por defecto).
- Haz clic derecho, ve a `ImpactPack -> Detector` y añade el nodo **`BboxDetectorToMask`**.

2. Cómo conectar los cables con YOLO

3. Conecta la salida `BBOX_DETECTOR` del nodo `UltralyticsDetectorProvider` a la entrada **`bbox_detector`** del nodo `BboxDetectorToMask`.
4. Toma la salida `IMAGE` de tu **`Load Image` tradicional** (la foto limpia del cuerpo) y conéctala a la entrada **`image`** del nodo `BboxDetectorToMask`.
5. Desconecta el cable de máscara de la opción anterior y conecta la salida **`MASK`** de este nodo `BboxDetectorToMask` directo al puerto **`mask`** de tu nodo **`VAE Encode (for Inpainting)`**.
```
[Load Image (Cuerpo Limpio)] ---> (image) [ BboxDetectorToMask ] ---(MASK)---> [VAE Encode Inpainting]
                                               ^
[UltralyticsDetectorProvider] ---> (detector) -|

```

_Nota para YOLO:_ Como este modelo detecta "rostros" de forma muy cuadrada, es muy probable que deje fuera los mechones de cabello más largos o la base del cuello. Si usas esta opción, te recomiendo ir a tu **`VAE Encode (for Inpainting)`** y subir el parámetro **`grow_mask_by` a un valor entre `10` y `16`** para que la máscara se expanda e incluya el pelo completo automáticamente.
