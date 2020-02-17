## crear rama de una sóla carpeta
https://stackoverflow.com/questions/9971332/git-create-a-new-branch-with-only-a-specified-directory-and-its-history-then-pus

git branch subdir_branch HEAD
git filter-branch --subdirectory-filter dir/to/filter --subdir_branch

https://www.jquery-az.com/list-branches-git/
The command to list all branches in local and remote repositories is:

$ git branch -a