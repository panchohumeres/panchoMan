### Ollama commands

#### Start / Stop Service
---------------------------
##### Manual Start

```bash
ollama serve #start ollama service
CTRL + C #quit ollama (IN TERMINAL WINDOW RUNNING OLLAMA)
```

##### System Manager
Automatic Background Service
```bash
sudo systemctl stop ollama #quit ollama (IN TERMINAL WINDOW RUNNING OLLAMA)
sudo systemctl kill -s SIGKILL ollama.service # sends a termination signal to **every single process** inside Ollama's service group at once (FORCE KILL)
sudo systemctl disable ollama #disable automatic background service for ollama permanently (to avoid running at computer boot, default mode with ollama install)
```
**Note**: leave OLLAMA terminal (interactive mode) -> **WILL NOT SHUT DOWN THE SERVER**
```bash
CTRL + Z 
```


If ollama is being run separately, start server
```bash
ollama run llama3.2 #start ollama server with llama3.2, replace model of choice
```

list models
```bash
ollama list #models on computer
ollama ps #models running, with cpu/gpu usage info
```

If ollama is being run separately, start server
```bash
ollama run llama3.2 #start ollama server with llama3.2, replace model of choice
```


Check Ollama is running
http://localhost:11434/ 

*Default port is 11434

Should display
```
Ollama is running
```


stop model
```bash
ollama stop llama3.2
```
________________________________________________
##### OLLAMA Quickstart
https://github.com/ollama/ollama
Quickstart (just donwload and run llama 3.2) in terminal mode (ctrl+z to exit)
```bash
ollama run llama3.2
```
list ollama running models and cpu/gpu usage
```bash
ollama ps
```
run same model server mode
```bash
ollama serve
ollama run llama3.2
```
test run
```bash
ollama run llama3.2 "Summarize this file: $(cat README.md)"
```
test model is running
- default URL where Ollama endpoint is running: http://localhost:11434/
- Should display "Ollama is running" in browser.