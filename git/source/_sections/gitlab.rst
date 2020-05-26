=====================================
GIT: Gitlab
=====================================

Documentación de Gitlab:

--------------------------------------------------------------------------------


Troubleshooting
-----------------------

* **\\"You are not allowed to push code to this project....! [remote rejected] master -> master (pre-receive hook declined)\\"**:

    **Solución:** 
        a) Checkear casilla **\\"Developer can push\\"** checkbox en **\\"project settings -> protected branch.\\"**
        b) Quitar status de protegido.

    Ver: https://gitlab.com/gitlab-com/support-forum/issues/207

* **\\"Git push error pre-receive hook declined\\"**:

    Misma solución que caso anterior.