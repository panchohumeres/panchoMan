=====================================
Vega: Configuraciones recurrentes
=====================================


----------------------------------------------

* **Especificar font general de la visualización**:
    En directiva config, al principio de la definición de la visualización. Va a ser reemplazada por cualquier especificación particular de font:
    https://vega.github.io/vega-lite/docs/mark.html#config
    
  .. code-block:: json

    { config: {"text" : {"font":"Rubik"} 
    }

* **Ejemplo config. del título en Vega v.3**:
  
  .. code-block:: json

    {"title": {"text":"Consumo Total del Mes (Millones de $ CLP y MWh)",
    "fontSize":18,"color":"#FFFFFF","font":"Rubik"}
    }

* **Ejemplo inserción de Imagen Vega v.3**:
    https://vega.github.io/vega/docs/marks/image/
    
    .. code-block:: json

      {
      "type": "image",
      "encode": {
      "enter": {
      "url": {
      "value": "https://vega.github.io/images/idl-logo.png"
      }}
      }}

* **Ejemplo de desplegar imágenes según condición**:
    
  .. code-block:: json

    {
    "type": "image",
    "from": {"data": "results"}
    "encode": {
    "enter": {
    "url": {
    "signal": "if(datum.up, 'https://wenu.s3-sa-east-1.amazonaws.com/Green_Arrow_Down.png', if(datum.down_mwh, 'https://wenu.s3-sa-east-1.amazonaws.com/Green_Arrow_Down.png', 'https://wenu.s3-sa-east-1.amazonaws.com/factory.svg'))",
    }
          align: {value: "center"}
          baseline: {value: "middle"}
          xc: {signal: "width/2-50"}
          yc: {signal: "height/2"}
    }
    }}