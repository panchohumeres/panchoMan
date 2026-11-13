**Sources**:
	- https://stackoverflow.com/questions/25503017/why-does-git-tell-me-no-such-remote-origin-when-i-try-to-push-to-origin

**Error**:
When pushing

```
No such remote 'origin'
```
**Diagnostics**:
list remotes:

```
$ git remote -v
origin  https://github.com:/repo-owner/repo-name.git (fetch)
origin  https://github.com:/repo-owner/repo-name.git (push)
```

**Causes**:

1. No files staged for commit, solve using 
```
#or the files of interest instead of reamd
git add README.md 

#for tracking all the new files
git add .
```
2. No remote set, solve using:
```
git remote add origin https://github.com/VijayNew/NewExample.git
```