=====================================
Kibana: Manejo de Usuarios
=====================================

Manejo de Usuarios:
    Instrucciones para manejo de usuarios en interfaz Kibana.

----------------------------------------------

### generar usuario anonimo para ver dashboards en kibana
    seguir esta secuencia:
        * entrar a kibana como usuario elastic
        * ir a "managament" (último menú), sección "security"
        * crear el usuario "guest", con contraseña que tiene que ser igual a la contraseña hasheada de nginx.conf
        * crear el role "dashboard_only_custom", con acceso "read" a los espacios de kibana ("all spaces"), y acceso "read" a los indíces de interés