## crear rama de una sóla carpeta
https://stackoverflow.com/questions/9971332/git-create-a-new-branch-with-only-a-specified-directory-and-its-history-then-pus

git branch subdir_branch HEAD
git filter-branch --subdirectory-filter dir/to/filter --subdir_branch
ó
git filter-branch -f --subdirectory-filter ./linux -- linux


https://www.jquery-az.com/list-branches-git/
The command to list all branches in local and remote repositories is:

$ git branch -a


git remote rename origin old-origin
git remote add origin https://gitlab.com/panchohumeres/linux_man.git
git push -u origin --all
git push -u origin --tags

git push https://gitlab.com/panchohumeres/linux_man.git linux:master