### RUN
0. If installed in conda environment,
```
conda activate comfyenv
```
1. CD into ComfyUI folder (where install is) and run the python script
```
cd ComfyUI
python main.py
```
2. Go to url shown in CLI, usually:
```
To see the GUI go to: http://127.0.0.1:8188
```

3. With Manager:
```
python main.py --enable-manager
```



### Stop ComfyUI Server

- **Sources**
  - https://github.com/Comfy-Org/ComfyUI/issues/12441
  - https://www.reddit.com/r/StableDiffusion/comments/1t7thaz/why_does_exiting_comfyui_not_remove_it_from_memory/
  - https://stackoverflow.com/questions/43724467/what-is-the-difference-between-kill-and-kill-9
  - https://www.suse.com/c/observability-sigkill-vs-sigterm-a-developers-guide-to-process-termination/
  - https://www.reddit.com/r/StableDiffusion/comments/1o488hl/cancel_a_comfyui_run_instantly_with_this_custom/
  - https://www.reddit.com/r/comfyui/comments/1asdkeq/is_there_a_graceful_exitshutdown_for_comfyui/
  - https://github.com/Acly/krita-ai-diffusion/issues/390
  - https://github.com/Comfy-Org/ComfyUI-Manager/issues/357

- **Type** <kbd>Ctrl</kbd> + <kbd>C</kbd>
- **Note**: <kbd>Ctrl</kbd> + <kbd>Z</kbd> does not stop the server, just pauses it in the background. You can bring it back to the foreground and kill it properly:
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

-------------------------------------------------------------------
 Generado con la asistencia de Gemini AI Overviews