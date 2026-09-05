#### Shutting Down Ollama - Ports Conflict
When stopping Ollama using standard commands, the main service shuts down, but occasionally the underlying runner process (which manages the heavy GPU/CPU model weights) gets stuck in your system memory and refuses to let go of port `11434`. 
Usally happens when ollama closed with ```CTRL + Z```

Debug
```
OLLAMA_DEBUG=1 ollama serve
```

If error:
```
Error: listen tcp 127.0.0.1:11434: bind: address already in use
```

Another process is already using port 11434==, which is preventing your new Ollama instance from starting (Ollama default por is 11434)
Likely a former ollama instance is running in the background as a "zombie" process, blocking the new instance.


#### Solution 1 (Port Occupied)
-------------------------
Find application using port assigned to Ollama (replace 11434 with other port if default changed)
```
sudo fuser -k 11434/tcp #if fuser installed
sudo lsof -i:11434 #atlernateviely with lsof if fuser not installed
```

Kill whichever App is using Ollama's port
```
sudo kill -9 $(sudo lsof -t -i:11434)
```

Verify the Ollama Port is now available
```
sudo lsof -i :11434
```


Restart Ollama Cleanly
```
#if using systemctl (background service)
sudo systemctl daemon-reload
sudo systemctl start ollama 
ollama serve #
```


#### Solution 2 (Force Kill Orphan)
------------------------------------------------
Applies when service started via systemctl (in the background)
Standard service shutdown
```
sudo systemctl stop ollama
```

Force kill systemd service
```
sudo systemctl kill -s SIGKILL ollama.service sudo 
```

-----------------------------------
* Written with assistance of Gemini overviews