Rclone basic commands (CLI)
------------------------------------------------

**Sources**:
	- https://rclone.org/protondrive/

* List directories in top level of your Proton Drive
	```console
	rclone lsd remote:
	```
- List all the files in your Proton Drive
	```console
	rclone ls remote:
	```
- To copy a local directory to an Proton Drive directory called backup
	```console
		rclone copy /home/source remote:backup
	```
