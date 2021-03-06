=====================================
GIT: Comandos
=====================================

Diccionario de comandos:
    Comandos utilizados comúnmente

----------------------------------------------


Borrar Ramas (Remoto y Local)
-------------------------------------

**Referencias:**
    - https://www.freecodecamp.org/news/how-to-delete-a-git-branch-both-locally-and-remotely/

.. code-block:: bash

    #LOCAL
        
    git branch -d localBranchName

    #GLOBAL

    git push origin --delete remoteBranchName


Borrar archivo permanentemente del historial
-------------------------------------------------

**Referencias:** https://stackoverflow.com/questions/6618612/ignoring-a-directory-from-a-git-repo-after-its-been-added

Luego de agregar el archivo a al archivo **\\".gitignore\\"**.
    

    .. code-block:: bash

        git rm --cached <filename> #CASO archivo
        git rm -r --cached bin/ #CASO CARPETA Y TODOS SUS ARCHIVOS


Listar/mostrar ramas y su info.
----------------------------------

**Referencias:** https://www.jquery-az.com/list-branches-git/

    Mostrar Ramas

    .. code-block:: bash

        git branch -a #LOCAL Y REMOTO
        git branch -r #SÓLO REMOTO
        git branch #SÓLO LOCAL

    Mostrar Ramas y sus Commits

    .. code-block:: bash

        git show-branch #MOSTRAR RAMAS LOCALES Y SUS COMMITS

    Resultado esperado:

    .. image:: https://www.jquery-az.com/wp-content/uploads/2018/06/5.0_5-show-branches.png
        :alt: show-branch

    .. code-block:: bash

        git show-branch -r #(1) MOSTRAR RAMAS REMOTAS Y SUS COMMITS
        git show-branch –all #MOSTRAR RAMAS REMOTAS, LOCALES Y SUS COMMITS

    Resultado esperado (1):

    .. image:: https://www.jquery-az.com/wp-content/uploads/2018/06/5.0_6-show-branches-remote.png
        :alt: show-branch    

    Fuente Imagen: [1]_.


Deshacer último Commit
-----------------------------

**Referencias:** https://www.git-tower.com/learn/git/faq/undo-last-commit

    .. code-block:: bash

        git reset --soft HEAD~1


.. [1] jquery-az.com, https://www.jquery-az.com/list-branches-git/



