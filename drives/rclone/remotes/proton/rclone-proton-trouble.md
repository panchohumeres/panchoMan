
Rclone Proton drive remote troubleshooting
-------------------------------------------------------------------------
**Sources**:
- https://rclone.org/protondrive/
- https://www.flowradar.com/answer/fix-repeatedly-receiving-wrong-password-429-too-many-requests
- https://forum.rclone.org/t/unable-to-mount-remote-from-existing-rclone-conf-file/42624
##### Rate Limits
- As of 31-05-2026
Usually Proton sets strict rate limits for Rclone requests. If in UI ops such as listing the file list remains stucked (refreshing for ever), check the CLI logs, for messages such as:

```
ERROR : proton drive root link ID '': 422 POST https://drive-api.proton.me/auth/v4: Our systems detected unusual activity targeting your account. To protect you from potential compromise, we have temporarily limited access to it. If this persists or you believe this is in error, please contact us at https://proton.me/support/appeal-abuse (Code=2028, Status=422)
2026/05/31 19:11:37 ERROR : rc: "operations/fsinfo": error: couldn't initialize a new proton drive instance: 422 POST https://drive-api.proton.me/auth/v4: Our systems detected unusual activity targeting your account. To protect you from potential compromise, we have temporarily limited access to it. If this persists or you believe this is in error, please contact us at https://proton.me/support/appeal-abuse (Code=2028, Status=422)

```
The error code **429 (Too Many Requests)** is an automated safety barrier triggered directly by Proton's servers:
```
429 POST https://drive-api.proton.me/auth/v4: The system has received too many requests recently. Please try again in a few moments. (Code=2011, Status=429), Attempt 1
```
How to resolve it:
- **Wait it out:** Proton's server rate limits usually clear automatically after **15 to 30 minutes**.
- **Stop the background loops:** Go to your terminal and press **`Ctrl + C`** to stop your current rclone command. If rclone keeps retrying in the background, it will keep hitting the server and prolong the lockout period.
- **Do not use a VPN:** f. VPN IP addresses often share rate-limit pools with thousands of other users, making this error happen much faster.
#### Duplicated files
- As of 31-05-2026
Proton Drive can not have two files with exactly the same name and path. If the conflict occurs, depending on the advanced config, the file might or might not be overwritten.

### Caching
- As of 31-05-2026
The cache is currently built for assuming rclone is the only instance operating on proton drive. The event system, which  provides visibility of what has changed on the drive, has not been implemented, so cache won't show changes from other clients (concurrent clients).

------------------------------------------------
Created with assistance of Gemini AI