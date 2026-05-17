### Stop ComfyUI Server
- **Type** <kbd>Ctrl</kbd> + <kbd>C</kbd>
**Note**: <kbd>Ctrl</kbd> + <kbd>Z</kbd> does not stop the server, just pauses it in the background. You can bring it back to the foreground and kill it properly:
Type ```fg```
and press <kbd>Enter</kbd>

If this doesn't work, see below.


#### Check ComfyUI running process
To check if the ComfyUI server is completely gone, use these commands in your terminal:
- Check by Port Number (Easiest)
See if ComfyUI is still listening on its default port (8188):
```
ss -tulpn | grep 8188
```
Result: If it returns nothing, the server is successfully stopped.
- Check Running Python Processes
See if the ComfyUI script is still active in the background:
```
ps aux | grep main.py
```
Result: You should only see your current grep command. If you see a line containing python main.py, the server is still running.
- Check Paused Background Jobs
See if the process is still suspended in your current terminal session:
```
jobs
```

#### Kill or stop the ComfyUI server
- Force Kill the Background Job
If you saw the process listed under the jobs command, force-kill it by its job number using the -9 (SIGKILL) flag:
```
kill -9 %1 (replace 1 with your actual job number if it was different)
```
- Force Kill by Process Name
Forcefully terminate any Python process running the ComfyUI script:
```
pkill -9 -f main.py
```
- Force Kill by Port
If the port is still blocked, forcibly kick the process off port 8188:
```
fuser -k -9 8188/tcp
```
