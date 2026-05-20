Opción 1: Segment Anything + GroundingDINO (La más precisa por texto)

Esta combinación (conocida como **ImpactPack - SEGS**) te permite crear una máscara escribiendo la palabra de lo que quieres borrar.

- **Cómo funciona:** Añades el nodo cargador de este modelo y en un cuadro de texto escribes simplemente `head, hair, neck`. El modelo analizará la imagen del cuerpo y creará una máscara perfecta siguiendo las curvas de la anatomía.
- **El Trade-off:** El modelo tarda unos 3 o 4 segundos adicionales en procesar la imagen antes de pasar al KSampler.
- **Cómo instalarlo:** Busca **`ComfyUI-Impact-Pack`** en el ComfyUI Manager. Los nodos que necesitas añadir al lienzo se llaman `SAMLoader` y `GroundingDinoSAMSegment (Advanced)`

```
[ Load Image (Cuerpo limpio) ] ---> [ Detector Automático (YOLO o SAM) ] 
                                                   |
                                            (Salida MASK limpia)
                                                   v
                                      [ VAE Encode (for Inpainting) ]

```
Paso 1: Instalar el paquete "Impact Pack"

1. Abre el **ComfyUI Manager** en tu navegador.
2. Haz clic en **Install Custom Nodes**.
3. En el buscador escribe: `Impact Pack`.
4. Busca el paquete llamado **`ComfyUI-Impact-Pack`** (desarrollado por _ltdrdata_) y haz clic en **Install**.
5. **Cierra ComfyUI y la terminal.** Vuelve a iniciar tu servidor con el comando de baja memoria: `python main.py --lowvram`. _Al reiniciar, el paquete descargará automáticamente unas librerías ligeras de Python necesarias para la detección visual._

Opción 1: Flujo Automático con Segment Anything (SAM)

Este sistema funciona como magia: lee tu imagen limpia del cuerpo y genera la máscara automáticamente buscando las palabras que tú le escribas.

1. Agregar los Nodos al Lienzo

- Haz clic derecho en una zona vacía, ve a `ImpactPack` y añade el nodo **`SAMLoader`**. En su menú desplegable, selecciona el modelo por defecto (usualmente `sam_vit_b_01ec64.pth`).
- Haz clic derecho, ve a `ImpactPack -> Detection` y añade el nodo **`GroundingDinoSAMSegment (Advanced)`**.

2. Cómo conectar los cables (Reemplazando el pincel manual)

3. **Elimina por completo** el nodo `Load Image (as Mask)` que usamos antes. Ya no lo necesitas.
4. Toma la salida `IMAGE` de tu **`Load Image` tradicional** (donde tienes la foto limpia del hombre de la camiseta verde) y conéctala a la entrada **`image`** del nodo `GroundingDinoSAMSegment`.
5. Conecta la salida `SAM_MODEL` del nodo `SAMLoader` a la entrada **`sam_model`** del nodo `GroundingDinoSAMSegment`.
6. Toma la salida **`MASK`** (círculo morado) de este nuevo nodo `GroundingDinoSAMSegment` y llévala directo al puerto **`mask`** de tu nodo **`VAE Encode (for Inpainting)`**.

7. Configurar las palabras de detección

Dentro del nodo `GroundingDinoSAMSegment` verás un cuadro de texto llamado **`prompt`**. Escribe exactamente lo siguiente en inglés:
```
head, hair, neck

```
_Al presionar **Queue Prompt**, el sistema leerá la foto limpia, aislará milimétricamente la cabeza, el pelo y el cuello de la persona, y le mandará ese recorte perfecto al KSampler sin tocar los estampados de la camiseta._

---