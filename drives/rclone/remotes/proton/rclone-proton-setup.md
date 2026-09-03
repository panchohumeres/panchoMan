**Sources**:
 - https://baizaar.tools/proton-drive-faq/how-to-install-proton-drive-on-linux/
 - https://github.com/dadtronics/protondrive-linux
 - https://rclone.org/protondrive/ -> rclone docs


1. Install `rclone` (must be v1.64.0 or newer):
	- Use precompiled binary (recommended)
2. Check version:
```shell
rclone version
# Must be v1.64.0 or higher
```
3. Set up proton remote
	* type  `rclone config`
	- `n` → New remote
	- Name: `proton`
	- Type: `protondrive`
	- Log in via browser when prompted
	- Accept and save