### Description
- After startup,usually after an interrupted reboot (example: while installing updates rebooting in the middle), after the message: 
```
 [ OK ] Started GNOME Display Manager
```
- Then Terminal gets stucked on displaying the underscore dash character : ```_```

1. **First Priority Solution (Safest)**:
    - Tried on PopOs 22.04
    1. Press Ctrl+Alt+F3 (or F2, F4-F6) to switch to a full-screen text console (TTY)
    2. Enter your username and password to log in.
    3. Finish and or clean updates, or upgrades: ```sudo apt-get upgrade```
        - Most probably it will ask you to clean or purge the udpates firts, offering a command. Copy, Paste it, execute, (```[Y]``` option)
    4. clean reboot: ```reboot```
 Mostly this solution should work, even with the GPU drivers (specially form NVIDIA), which are the most probable cause.

2. **Alternative solutions** (if it doesn't work):
   - Most probably is an issue with video drivers, mostly with NVIDIA cards (as reported on internet).
   - NVIDIA driver issues are a common cause of this problem, especially after updates (Warning!! recommended to read the sources first before executing these commands).
   - In the TTY, run these commands to remove the old drivers and reinstall the System76-provided ones:
       1. ```sudo apt purge nvidia*```
       2. ```sudo apt purge system76-driver-nvidia```
       3. ```sudo apt install system76-driver-nvidia```
       4. Finally, reboot your system.
 3. **Other Solutions (Last Resort)**:
     - reinstall desktop manager, Gnome, or ubuntu.
 
#### **Sources**:
- [Redditt: Stuck on [ OK ] Started GNOME Display Manager after failed upgrade to 20.04](https://www.reddit.com/r/pop_os/comments/gdhe2j/stuck_on_ok_started_gnome_display_manager_after/#:~:text=If%20you're%20stuck%20on%20%22Started%20GNOME%20Display,purge%20nvidia*%20*%20sudo%20apt%20purge%20system76%2Ddriver%2Dnvidia)
- [PopOs video card - black screen, troubleshooting](https://support.system76.com/articles/login-loop-pop/)
- [Ubuntu 18 Black Screen troubleshooting (Stack overflow)](https://askubuntu.com/questions/1032639/ubuntu-18-04-stuck-in-boot-after-starting-gnome-display-manager-on-intel-graphic#:~:text=To%20answer%20a%20part%20that,Source:%20different%20answers%20here))
- [Ubuntu 24 Gnome Display troubleshooting, stack exchange](https://unix.stackexchange.com/questions/737169/ubuntu-fails-to-boot-due-to-gnome-display-manager-error#:~:text=Too%20big%20log%20files%20in,the%20same%20size%2C%20for%20example%2C)

