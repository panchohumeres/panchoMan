=====================================
GIT: Borrar Información Sensible
=====================================

Tips para borrar información sensible del historial de un repositorio.

------------------------------------------------------------------------


Remover archivos completamente del historial
----------------------------------------------------------------------

**Método 1:** (Para Carpetas)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    **Fuente:** https://myopswork.com/how-remove-files-completely-from-git-repository-history-47ed3e0c4c35

    1. Navega hacia el **directorio de trabajo** del repositorio.
    2. Ejecutar uno de los siguientes comandos (**\\"path_to_folder\\"** es ruta a la carpeta a eliminar el historial):
    
        .. code-block:: bash

            git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch path_to_folder" HEAD

            git filter-branch --force --index-filter "git rm -rf --cached --ignore-unmatch path_to_folder" --prune-empty --tag-name-filter cat -- --all HEAD
    
    3. Ejecutar: :code:`git push -all` o :code:`git push origin master --force` (para forzar, ejemplo rama master en repo origen)

**Método 2:**
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    **Fuentes :** 
        - https://help.github.com/es/github/authenticating-to-github/removing-sensitive-data-from-a-repository
        - https://www.cocoanetics.com/2012/12/changing-history-gits/

    1. Navega hacia el **directorio de trabajo** del repositorio.
    2. Ejecuta el siguiente comando, reemplazando PATH-TO-YOUR-FILE-WITH-SENSITIVE-DATA por la ruta al archivo que quieres eliminar, no solo con su nombre de archivo. Estos argumentos harán lo siguiente:
        - Forzar a Git a que procese, pero no revise, todo el historial de cada rama y etiqueta
        - Eliminar el archivo especificado y cualquier confirmación vacía generada como resultado
        - Sobreescribir etiquetas existentes.
    
        .. code-block:: bash

            $ git filter-branch --force --index-filter \
            "git rm --cached --ignore-unmatch PATH-TO-YOUR-FILE-WITH-SENSITIVE-DATA" \
            --prune-empty --tag-name-filter cat -- --all
            > Rewrite 48dc599c80e20527ed902928085e7861e6b3cbe6 (266/266)
            > Ref 'refs/heads/master' was rewritten
    
    3. Agrega tu archivo con datos confidenciales a .gitignore para asegurar que no lo volviste a confirmar por accidente.

        .. code-block:: bash

            $ echo "YOUR-FILE-WITH-SENSITIVE-DATA" >> .gitignore
            $ git add .gitignore
            $ git commit -m "Add YOUR-FILE-WITH-SENSITIVE-DATA to .gitignore"
            > [master 051452f] Add YOUR-FILE-WITH-SENSITIVE-DATA to .gitignore
            >  1 files changed, 1 insertions(+), 0 deletions(-)
    
    4. Una vez que estés conforme con el estado de tu repositorio, realiza un empuje forzado de tus cambios locales para sobrescribir tu GitHub repositorio y todas las ramas que hayas subido:

        .. code-block:: bash

            $ git push origin --force --all
            > Counting objects: 1074, done.
            > Delta compression using 2 threads.
            > Compressing objects: 100% (677/677), done.
            > Writing objects: 100% (1058/1058), 148.85 KiB, done.
            > Total 1058 (delta 590), reused 602 (delta 378)
            > To https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
            >  + 48dc599...051452f master -> master (forced update)  

    5. Para eliminar el archivo confidencial de tus lanzamientos etiquetados, también deberás realizar un empuje forzado contra tus etiquetas de Git:

        .. code-block:: bash

            $ git push origin --force --tags
            > Counting objects: 321, done.
            > Delta compression using up to 4 threads.
            > Compressing objects: 100% (166/166), done.
            > Writing objects: 100% (321/321), 331.74 KiB | 0 bytes/s, done.
            > Total 321 (delta 124), reused 269 (delta 108)
            > To https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
            >  + 48dc599...051452f master -> master (forced update)
    
    6. Después de que haya transcurrido un tiempo y estés seguro de que git filter-branch no tuvo efectos secundarios inesperados, puedes forzar a todos los objetos de tu repositorio local a desreferenciarse y recolectar la basura con los siguientes comandos (usando Git 1.8.5 o posterior):

        .. code-block:: bash

            $ git for-each-ref --format="delete %(refname)" refs/original | git update-ref --stdin
            $ git reflog expire --expire=now --all
            $ git gc --prune=now
            > Counting objects: 2437, done.
            > Delta compression using up to 4 threads.
            > Compressing objects: 100% (1378/1378), done.
            > Writing objects: 100% (2437/2437), done.
            > Total 2437 (delta 1461), reused 1802 (delta 1048)


**Método 3:**
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    **Ver:** https://help.github.com/es/github/managing-large-files/removing-files-from-a-repositorys-history

    .. code-block:: bash

        $ git rm --cached giant_file
        # Prepara nuestro archivo gigante para la eliminación, pero lo deja en el disco

        $ git commit --amend -CHEAD
        # Modifica la confirmación previa con tu cambio
        # No funcionará hacer simplemente una confirmación nueva, ya que también debes
        # eliminar el archivo del historial no subido

        $ git push
        # Sube nuestra confirmación reescrita y más pequeña

**Método \\"BFG Repo-Cleaner\\" (Plug-in) :**
--------------------------------------------------

    **Fuente:** 
        - https://help.github.com/es/github/authenticating-to-github/removing-sensitive-data-from-a-repository
        - https://medium.com/@rhoprhh/removing-keys-passwords-and-other-sensitive-data-from-old-github-commits-on-osx-2fb903604a56

    El BFG Repo-Cleaner es una herramienta construida y mantenida por la comunidad de código abierto. Proporciona una alternativa más rápida y simple que git filter-branch para eliminar datos no deseados. Por ejemplo, para eliminar tu archivo con datos confidenciales y dejar intacta tu última confirmación, ejecuta lo siguiente:

    .. code-block:: bash

        $ bfg --delete-files YOUR-FILE-WITH-SENSITIVE-DATA

    Para reemplazar todo el texto detallado en passwords.txt donde sea que se encuentre en el historial de tu repositorio, ejecuta lo siguiente:

    .. code-block:: bash

        $ bfg --replace-text passwords.txt


Remover líneas de código (información sensible) completamente del historial
-----------------------------------------------------------------------------

1. Instalar Hombebrew, para Linux:
    Ver: 
        - https://brew.sh/
        - https://docs.brew.sh/Homebrew-on-Linux
        - https://github.com/rtyley/bfg-repo-cleaner/issues/255

    .. code-block:: bash

        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

        #estos pasos dependen de la distribución, preferir instrucciones de la línea de comandos
        test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
        test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
        echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

2. Clonar con método \\"mirror\\" el repo de origen:code:`git clone --mirror <remote_repo> <nombre_local_repo>`:
    **Nota**: Va a hacer una copia \\"bare\\".
3. cd  <nombre_local_repo>
4. Crear un archivo de texto con reglas de sustitución, por ejemplo:

    .. code-block:: bash

        PASSWORD1 #Replace string 'PASSWORD1' with '***REMOVED***' (default)
        PASSWORD2==>examplePass         # replace with 'examplePass' instead
        PASSWORD3==>                    # replace with the empty string
        regex:password=\w+==>password=  # Replace, using a regex
        regex:\r(\n)==>$1               # Replace Windows newlines with Unix
                                        newlines

    **Nota:** Para expresiones regulares se recomienda ver:
        - https://regexr.com/ (simulador de regex)
        - https://www.regular-expressions.info/wordboundaries.html

5. :code:`bfg --replace-text <nombre_archivo_sustitución>`
6. Ejectuar comandos que sugiere la herramienta:

    .. code-block:: bash

        git reflog expire --expire=now --all && git gc --prune=now --  aggressive

7. Empujar cambios al repositorio origen: :code:`git push`

* **Nota**: Es posible de que primero haya que hacen un commit borrando la data que uno desea eliminar, para que los cambios sean efectivos (ver output de la herramienta).