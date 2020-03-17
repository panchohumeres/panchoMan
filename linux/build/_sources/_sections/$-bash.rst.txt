=======================
Linux: Bash $
=======================

Bash:
    Usos del signo $.

    **Referencia**: https://stackoverflow.com/questions/10870719/inline-code-highlighting-in-restructuredtext

----------------------------------------------

* :code:`$1, $2, $3` 
    Parámetros posicionales

* :code:`"$@"` 
    Parámetros posicionales, como array: i.e. la forma: 
        {$1, $2, $3 ...}.

* :code:`"$*"` 
    "Expansión" **IFS** de parámetros posicionales. P.ej (IFS='|'): "$1|$2|$3".
    Ver: https://bash.cyberciti.biz/guide/$IFS

* :code:`$#` 
    El número de parámetros posicionales.

* :code:`$-` 
    Número de opciones para el "Shell" actual.

* :code:`$$` 
    "Process ID" **(PID)** del actual "Shell" (**NO** sub-shell).

* :code:`$_`
    Parámetro más reciente.

* :code:`$IFS`
    Separador o delimitador de parámetros en string de entrada (input). Ver: :doc:`../_sections/strings-bash`

* :code:`$?`
    Status más reciente anterior a un "exit".

* :code:`$!` 
    PID del comando más reciente ejecutado en el background.

* :code:`$0` 
    El nombre del shell o script shell.