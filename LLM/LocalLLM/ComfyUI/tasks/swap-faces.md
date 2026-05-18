### Worflow for Swapping Faces in ComfyUI
-------------------------------------------
[Workflow file example](../workflows/swap_faces.json)

0. Ejecutar ComfyUI con Node Manager:
    
    ```
    python main.py --enable-manager
    ```
    Recomendado + modo lowvram para mejorar rendimiento en commodity hardware y evitar congelamiento del PC por RAM:
    ```
    python main.py --enable-manager --lowvram
    ```
    

1. Instalar el Nodo ReActor
    Link -> https://github.com/Gourieff/ComfyUI-ReActor
    1. Abre la interfaz web de ComfyUI en tu navegador Firefox.
    2. En el menú de la derecha, haz clic en Manager.
    3. Selecciona Install Custom Nodes.
    4. En la barra de búsqueda superior, escribe: ReActor.
    5. Verás una opción llamada ReActor Node for ComfyUI (desarrollada por Gourieff). Haz clic en Install.
    6. Una vez instalado, reiniciar ComfyUI, dos alternativas:
        - Cerrar ComfyUI por completo (cerrar la consola de la terminal, CTRL +C) y volver a ejecutar                    ```python main.py --enable-manager --lowvram``` para que Linux cargue las librerías de dependencias de ReActor.
        - Una vez Instalado, la GUI de ComfyUI debería sugerir la alternativa para reiniciar el servidor.

    **Nota**: Al instalaro a través de la GUI debería descargar automáticamente todos los modelos necesarios. Alternativamente se pueden descargar manualmente todos los modelos siguiendo las instrucciones en el sitio del repo del plug-in.

2. Armar el Workflow en el Lienzo
    Una vez que ComfyUI vuelva a abrirse, limpia tu pantalla (puedes presionar el botón Clear en el menú derecho) y arma el flujo de la siguiente manera:
    1. Añadir el nodo ReActor: Haz clic derecho en cualquier parte vacía de la pantalla, ve a ReActor y selecciona ReActor - Fast Face Swap.
    2. Cargar la imagen del rostro (Origen): Haz clic derecho, ve a image -> Load Image. Sube la foto de la persona de la cual quieres extraer el rostro. Conecta la salida IMAGE de este nodo al puerto llamado source_image del nodo ReActor.
    3. Cargar la imagen de destino (Cuerpo): Añade otro nodo Load Image. Aquí sube la foto del cuerpo donde quieres colocar el rostro. Conecta la salida IMAGE de este nodo al puerto llamado input_image del nodo ReActor.
    4.  Ver el resultado: Haz clic derecho, ve a image -> Preview Image. Conecta el puerto IMAGE de salida de ReActor a este nodo de vista previa.
    

    ```
    [Load Image (Tu Rostro)]   -----> (source_image) [ ReActor ] -----> [ Preview Image ]
    [Load Image (Cuerpo/Ropa)] -----> (input_image)  [           ]
    ```

Paso 4: Ajustes finales para un resultado perfecto
Dentro del nodo de ReActor verás varias opciones numéricas:
source_faces_index / input_faces_index: Déjalos ambos en 0. Esto le indica a la IA que tome el primer rostro que encuentre en cada imagen. (Si hay varias personas, 0 es la primera de izquierda a derecha, 1 es la segunda, etc.).
face_restore_model: Selecciona codeformer.pth o gfpgan.pth en el menú desplegable. Esto corregirá automáticamente cualquier imperfección de iluminación o difuminado, adaptando perfectamente el rostro extraído a la textura del nuevo cuerpo.
