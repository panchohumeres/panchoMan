=====================================
GIT: Sincronización de Remotos
=====================================

Tips para sincronizar dos o más repositorios remotos.
Se recomienda revisar:

    - :ref:`crear-nuevo-remoto`.

    - :ref:`migrar-repo-con-historial`.

    - :ref:`clonar-repositorio-de-commit`.

------------------------------------------------------------------------

Crear rama a partir de una sola Carpeta
---------------------------------------------------------------------

**Fuente:** https://stackoverflow.com/questions/9971332/git-create-a-new-branch-with-only-a-specified-directory-and-its-history-then-pus

.. code-block:: bash

    git branch subdir_branch HEAD
    git filter-branch --subdirectory-filter dir/to/filter -- subdir_branch
    #Ó
    git filter-branch -f --subdirectory-filter ./linux -- linux

Reintegrar (merge) cambios hechos en rama creada a partir de una sóla Carpeta
---------------------------------------------------------------------------------

**Fuentes:**
    - https://www.datree.io/resources/git-error-fatal-refusing-to-merge-unrelated-histories


1. Clonar repositorio en carpeta local.
2. Ejecutar:

    .. code-block:: bash

        git fetch origin <nombre_rama_filtrada>:<nombre_rama_filtrada>

3. **VERIFICAR** que sólo se han hecho **cambios en la carpeta filtrada**.
4. Estando en rama master:

    .. code-block:: bash

        git merge <nombre_rama_filtrada> --allow-unrelated-histories

Resetear repositorio (push a remoto ignorando historia)
----------------------------------------------------------

.. code-block:: bash

    git push -u --force <nombre_remoto> <data_dict>


Agregar un nuevo remoto:
------------------------------

    .. code-block:: bash

        git remote rename origin <antiguo_remoto> 
        git remote add origin <nuevo_remoto> 
        git push -u origin --all git push -u origin --tags
        git push <nuevo_remoto> <rama_local>:<rama_remota>

Clonar una sóla rama:
------------------------

    .. code-block:: bash

        git clone -b <mybranch> --single-branch <remote_repo>


Sincronizar dos ramas de dos remotos distintos
--------------------------------------------------

**Situación:** 
    - Dos repositorios (\\"origin\\" y \\"target\\").
    - Se quiere sincronizar una rama con el mismo nombre (\\"nombre rama\\").
    - Se crea la rama en \\"target\\", con menos archivos que en \\"origin\\" (por ejemplo, sólo dentro de una carpeta), con el fin de trackear ese reducido conjunto de cambios en \\"origin\\".

1. En target (repo distinto de origin), crear rama:

    .. code-block:: bash

        git checkout -b <nombre_rama>

2. Agregar origin como nuevo remoto (distinto de \\"origin\\" de target):

    .. code-block:: bash

        git remote add <nombre_nuevo_remoto_origin> <url_nuevo_remoto_origin>

3. Empujar nueva rama al repo \\"origin\\":

    .. code-block:: bash

        git push -u <nombre_origin> <nombre_rama>

4. En el repo \\"origin\\":

    .. code-block:: bash

        git pull --all

5. En el repo \\"origin\\":

    Opción a)

        .. code-block:: bash

            git pull --all

            #para revisar ramas existentes
            git branch -v

            git checkout <nombre_remoto>/<nombre_rama>

            #Output esperado
            #You are in 'detached HEAD' state. You can look around, make experimental
            #changes and commit them, and you can discard any commits you make in this
            #state without impacting any branches by performing another checkout.

            #If you want to create a new branch to retain commits you create, you may
            #do so (now or later) by using -b with the checkout command again. Example:

            #git checkout -b <new-branch-name>

            git checkout -b <nombre_rama>

    Opción b)

        .. code-block:: bash

            git checkout -b <nombre_rama>
            git branch --set-upstream-to=origin/<nombre_rama> <nombre_rama>

            #Se sugiere ejecutar en este comando en un entorno de desarrollo que permita resolver conflictos git..
            #como Visualstudio Code
            git pull --all --allow-unrelated-histories

            #Va a tirar el siguiente error:
            #Automatic merge failed; fix conflicts and then commit the result.
        
            #Resolver conflictos y hacer commit

            git push origin <nombre_rama>


6. En el repo \\"origin\\":


    - Si es que en el paso 5, se eligió opción a):
    
        .. code-block:: bash

            git checkout master

            #ejecutar este comando sólo para probar
            git merge <nombre_rama> #va a generar el siguiente error:
            #fatal: refusing to merge unrelated histories

            #Se sugiere ejecutar en este comando en un entorno de desarrollo que permita resolver conflictos git..
            #como Visualstudio Code
            git merge <nombre_rama> --allow-unrelated-histories

            #Va a tirar el siguiente error:
            #Automatic merge failed; fix conflicts and then commit the result.
            
            #Resolver conflictos y hacer commit

            git push origin master

    - Si es que en el paso 5, se eligió opción b):

        .. code-block:: bash

            git checkout master

            git merge <nombre_rama>

            #Puede tirar el siguiente error:
            #Automatic merge failed; fix conflicts and then commit the result.
            
            #Resolver conflictos y hacer commit

            git push origin master

* **Notas:**
    - Si es que sale este error al intentar sincronizar la rama:

        .. code-block:: bash

            There is no tracking information for the current branch.
            Please specify which branch you want to merge with.
            See git-pull(1) for details.

                git pull <remote> <branch>

            If you wish to set tracking information for this branch you can do so with:

                git branch --set-upstream-to=origin/<branch> linux

        Ejecutar:

        .. code-block:: bash

            git branch --set-upstream-to=origin/<nombre_rama> <nombre_rama>


Clonar Repositorio a partir de un commit específico
----------------------------------------------------------------------

Ver: https://coderwall.com/p/xyuoza/git-cloning-specific-commits

    .. code-block:: bash

        git clone <URL-commit>
