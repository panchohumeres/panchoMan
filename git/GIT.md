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

git clone -b mybranch --single-branch git://sub.domain.com/repo.git

https://www.cocoanetics.com/2012/12/changing-history-gits/

https://help.github.com/es/github/authenticating-to-github/removing-sensitive-data-from-a-repository

https://help.github.com/es/github/managing-large-files/removing-files-from-a-repositorys-history

https://myopswork.com/how-remove-files-completely-from-git-repository-history-47ed3e0c4c35

git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch path_to_file" HEAD

git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch path_to_folder" HEAD

git filter-branch --force --index-filter "git rm -rf --cached --ignore-unmatch path_to_folder" --prune-empty --tag-name-filter cat -- --all HEAD


git push origin master --force


https://gitlab.com/gitlab-com/support-forum/issues/207

https://www.git-tower.com/learn/git/faq/undo-last-commit
git reset --soft HEAD~1

git filter-branch --force --index-filter "git rm -rf --cached --ignore-unmatch build" --prune-empty --tag-name-filter cat -- --all HEAD