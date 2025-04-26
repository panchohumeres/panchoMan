--[[

  Filtro Lua para Pandoc: Eliminar elementos específicos con imágenes embebidas

  Descripción:
  Este filtro Lua está diseñado para ser utilizado con Pandoc para eliminar elementos específicos en documentos HTML que contienen imágenes embebidas. Los casos que maneja son:

  1. Eliminar elementos <div> con la clase 'elementor-carousel-image' que contienen imágenes embebidas en formato base64 en su atributo 'style'.
  2. Eliminar imágenes embebidas en formato base64 dentro de elementos de imagen Markdown (![...](data:image/...)).

  Uso:
  Para aplicar este filtro al convertir archivos HTML a texto, utiliza el siguiente comando en la terminal:

    pandoc input.html --lua-filter=remove-images.lua -o output.txt

  Asegúrate de reemplazar 'input.html' por el nombre de tu archivo HTML de entrada y 'output.txt' por el nombre del archivo de salida deseado.

  Requisitos:
  - Pandoc versión 2.0 o superior.
  - El archivo 'remove-images.lua' debe estar en el mismo directorio desde el cual ejecutas el comando o proporcionar la ruta completa al archivo.

  Funciones definidas:

    Div(elem)
      - Elimina elementos <div> con la clase 'elementor-carousel-image' que contienen imágenes embebidas en formato base64 en su atributo 'style'.
      - Parámetros:
          - elem: El elemento <div> a evaluar.
      - Retorna:
          - Una tabla vacía {} si el elemento debe ser eliminado.
          - El elemento sin cambios si no coincide con el patrón.

    Image(elem)
      - Elimina imágenes embebidas en formato base64 dentro de elementos de imagen Markdown.
      - Parámetros:
          - elem: El elemento de imagen a evaluar.
      - Retorna:
          - Una tabla vacía {} si el elemento debe ser eliminado.
          - El elemento sin cambios si no coincide con el patrón.

  Ejemplo de uso:

    -- Para eliminar elementos <div> con la clase 'elementor-carousel-image' que contienen imágenes embebidas:
    function Div(elem)
      for _, class in ipairs(elem.classes) do
        if class == 'elementor-carousel-image' then
          local style = elem.attributes['style']
          if style and style:match('background%-image%s*:%s*url%((data:image/[^;]+;base64[^)]+)%)') then
            return {}  -- Eliminar el div
          end
        end
      end
      return elem  -- Retornar el div sin cambios
    end

    -- Para eliminar imágenes embebidas en formato base64 dentro de elementos de imagen Markdown:
    function Image(elem)
      if elem.src and elem.src:match('^data:image/[^;]+;base64,') then
        return {}  -- Eliminar la imagen
      end
      return elem  -- Retornar la imagen sin cambios
    end

  Nota:
  Este filtro está diseñado para eliminar únicamente los elementos mencionados anteriormente. Si deseas eliminar otros elementos o imágenes con diferentes características, puedes modificar el filtro según sea necesario.

]]--

function Div(elem)
  -- Elimina divs con la clase 'elementor-carousel-image'
  for _, class in ipairs(elem.classes) do
    if class == 'elementor-carousel-image' then
      return {}  -- Retorna una tabla vacía para eliminar el div
    end
  end
  return elem  -- Retorna el div sin cambios si no coincide
end

function Image(elem)
  -- Elimina imágenes embebidas en formato base64
  if elem.src and elem.src:match('^data:image/[^;]+;base64,') then
    return {}  -- Retorna una tabla vacía para eliminar la imagen
  end
  return elem  -- Retorna la imagen sin cambios si no coincide
end
