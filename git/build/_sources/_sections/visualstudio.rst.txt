=====================================
GIT: Visual Studio Code
=====================================

Documentación particular de Visual Studio y sus extensiones Git

--------------------------------------------------------------------------------


Merge
-------------------------------------------------

**Referencias:** https://www.youtube.com/watch?v=kBIMGOxqqnk

1. Abrir Línea de Comandos en Visual Studio Code, Menú: **\\"Terminal\\"------>\\"New Terminal\\"**

.. image:: https://panchoman.s3-sa-east-1.amazonaws.com/vs-code-command-line.png
    :alt: línea-comandos-vscode

Fuente Imagen: [1]_.

2. Ejecutar :code:`git pull -all` (Asumiendo que en el remoto se subieron commits que van a causar conflictos con el repo local).
    * Esto aplica para **cualquier** comando que pueda **generar conflictos**, p.ej. un \\"merge\\".
    * Ver : https://code.visualstudio.com/docs/editor/versioncontrol
3. Inmediatamente debieran visualizarse los conflictos en la GUI de Visual Studio Code, los que se pueden manejar con los menús en el snippet:

.. image:: https://panchoman.s3-sa-east-1.amazonaws.com/vs-code-git-conflict.png
    :alt: vscode-git-conflicts

Fuente Imagen: [1]_.

.. [1] CodeSpace, https://www.youtube.com/channel/UCTI8_vW-CmKkZuWIU7Yi8BQ
