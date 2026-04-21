### Después de Crash causado por Google Chrome, PC sin señal de video al Bootear

Guía de Diagnóstico: PC Congelada y Sin Señal de Video (Caso Multi-monitor + NVIDIA)
1. Síntomas del Problema
Evento inicial: El sistema se congela completamente durante el uso (ej. abriendo una pestaña en Chrome).
Falla de reinicio: Al intentar reiniciar, la pantalla permanece en negro. No aparece el logo de la placa base (BIOS/OEM).
Indicadores de energía: Los ventiladores giran y las luces del teclado (Bloq Num/Caps Lock) pueden estar encendidas, pero no hay respuesta visual.


2. Diagnóstico Paso a Paso
Nivel 1: Verificación de Salida de Video (Causa Probable)
En configuraciones con NVIDIA y múltiples monitores, un crash del driver puede causar que el orden de prioridad de los puertos cambie.
Problema: La BIOS y el sistema operativo envían la señal a un monitor que está apagado o a un puerto secundario (DisplayPort suele tener prioridad sobre HDMI).
Solución inmediata: Desconectar o apagar los monitores secundarios y dejar solo el principal conectado al puerto de mayor prioridad.


Nivel 2: Comprobación de Estado de la Placa (POST)
Prueba del teclado: Presiona la tecla Bloq Num.
Si la luz reacciona (enciende/apaga), la PC está funcionando pero no tiene video.
Si la luz está fija, la placa base está en un "soft-lock" (bloqueo lógico).


Nivel 3: Ciclo de Energía y Reset Físico
Si el paso 1 no funciona, se debe limpiar la energía residual:
Hard Reset: Desconectar corriente y mantener presionado el botón de encendido por 60 segundos.
Clear CMOS: Quitar la pila de botón (CR2032) de la placa base por 2 minutos para resetear los valores de la BIOS a fábrica.

3. Solución Aplicada
En este caso específico, el problema se originó por una mala gestión de la salida de video tras un cuelgue del sistema.
Acción: Apagar uno de los 3 monitores conectados.
Resultado: La tarjeta de video forzó la salida de imagen al monitor activo, permitiendo ver el proceso de carga y el acceso al sistema.
4. Recomendaciones Post-Recuperación
Para evitar que el problema se repita tras un error de software:
Definir Monitor Primario: En la configuración de pantalla de Pop!_OS, marcar el monitor deseado como "Principal".
Orden de Cables: Conectar el monitor principal en el primer puerto disponible de la GPU (usualmente el más cercano a la placa base).
Actualizar Drivers: Mantener los drivers de NVIDIA actualizados para mejorar la estabilidad de la gestión de energía en configuraciones multi-pantalla:
sudo apt update && sudo apt full-upgrade

Guía de Diagnóstico: PC Congelada y Fallo de Video (NVIDIA + Multi-monitor)
1. Identificación del Problema
El sistema se bloquea (soft-lock) tras un fallo de software o drivers, impidiendo ver incluso el logo de la BIOS/Placa Base al reiniciar.
2. Señales Críticas del Teclado (Bloq Num / Caps Lock)
Antes de asumir un fallo de hardware, observa los indicadores LED del teclado:
Estado del LED
Significado
Acción Sugerida
Luz reacciona (enciende/apaga al tocar)
La placa base pasó el POST. El sistema funciona pero no hay señal de video.
Apagar monitores secundarios o cambiar cables de puerto.
Luz fija (no cambia al tocar)
La placa base o el procesador están bloqueados en un bucle.
Realizar un ciclo de energía o reset de CMOS (quitar pila).
Luz parpadeante
Indica un error de hardware específico (Kernel Panic o fallo de RAM).
Revisar los módulos de memoria RAM.

3. Teclas para Forzar el Menú de Arranque (Boot Menu)
Si el sistema tiene energía pero la pantalla está en negro, intenta usar estas teclas inmediatamente después de presionar el botón de encendido:
ESPACIO o ESC: Teclas estándar para mostrar el menú de Pop!_OS (systemd-boot). Mantén presionada o pulsa repetidamente.
F12, F11 o F10: Acceso al menú de selección de dispositivo de la BIOS (depende del fabricante).
SUPR (DEL) o F2: Entrar directamente a la configuración de la BIOS/UEFI.
e: Dentro del menú de Pop!_OS, permite editar parámetros de arranque (como añadir nomodeset).


4. Solución Aplicada en este Caso
En configuraciones de 3 pantallas, el driver de NVIDIA puede perder el orden de prioridad tras un crash.
Acción: Apagar o desconectar los monitores secundarios.
Efecto: Fuerza a la GPU a enviar la señal de video al monitor activo, permitiendo ver el prompt de cifrado o el inicio de sesión.


5. Comandos de Mantenimiento (Pop!_OS)
Una vez recuperado el acceso, ejecuta esto en la terminal para asegurar la estabilidad:
# Actualizar sistema y drivers
sudo apt update && sudo apt full-upgrade

# Reinstalar drivers de NVIDIA si persisten los cuelgues
sudo apt install --reinstall system76-driver-nvidia

Generado con asistencia de Gemini
