=====================================
GIT: Migración de Repositorios
=====================================

Tips para migrar historiales de un remoto a otro.

------------------------------------------------------------------------

.. _crear-nuevo-remoto:

Crear nuevo remoto:
------------------------------

**Fuente:** https://gitlab.com

* Desde una carpeta existente:

    .. code-block:: bash

        cd existing_folder
        git init
        git remote add origin <url_remoto>
        git add .
        git commit -m "Initial commit"
        git push -u origin master

* Desde un repo existente:

    .. code-block:: bash

        cd existing_repo
        git remote rename origin old-origin
        git remote add origin <url_remoto>
        git push -u origin --all
        git push -u origin --tags
  
.. _migrar-repo-con-historial:

Migrar repositorio (con historial) de un origen a otro
----------------------------------------------------------------------

Ver: https://gist.github.com/niksumeiko/8972566

.. code-block:: bash

    git clone --mirror <url_of_old_repo>
    cd <name_of_old_repo>
    git remote add new-origin <url_of_new_repo>
    git push new-origin --mirror

.. _clonar-repositorio-de-commit:

Clonar Repositorio a partir de un commit específico
----------------------------------------------------------------------

Ver: https://coderwall.com/p/xyuoza/git-cloning-specific-commits

    .. code-block:: bash

        git clone <URL-commit>
