**Sources**:
- https://modelpiper.com/blog/ollama-environment-variables
- https://docs.ollama.com/faq


* Ollama configuration is set through environment variables. At startup Ollama server reads this variables to control networking, model storage, memory behavior, and inference performance. 
* It also inherits variables from the linux environment for settings such as GPU selection.
* Any changes to the variables will onlye be re-read by ollama after restart.

* **Important**: The env vars configure the background server (`ollama serve`), not the `ollama run` command. Setting one in the same shell as `ollama run` will not be enforced if the server is already running as a separate process. 

### Setting Env Vars (Linux)
----------------------
If running Ollama as **systemd service** (automatic background daemon)
1. Open editor for config file:
```
systemctl edit ollama.service
```
2. For each environment variable, add a line `Environment` under section `[Service]`, for example:
```
[Service] Environment="OLLAMA_HOST=0.0.0.0:11434"
```
3. Save and exit, , reload systemd and ollama
```
systemctl daemon-reload
systemctl restart ollama
```

If running Ollama **"manually"** (i.e. executing ```ollama serve``` ):

1. Set temporary env var and start the server, for example for path:
```
export OLLAMA_MODELS="/mnt/slave-drive/ollama-models"
ollama serve 

```
2.  To make the setting permanent, add it to ```~/.bashrc``` script
```
#edit the script with your editor of choice
nano ~/.bashrc 

#add the setting, for example Ollama models path
export OLLAMA_MODELS="/mnt/slave-drive/ollama-models"

#to apply the changes inmediatly
source ~/.bashrc
```

### Variables
----------------
#### ``` PATH``` 
--------------
The `PATH` variable inside a systemd service file tells Ollama **where to search for executable tools and system libraries** when it starts up.

**Note**
When installing on Linux using the official `curl` script, the installer reads the terminal's `PATH` variable active at that moment and copies it into this file.
Can lead to confusion if some apps such as a Conda environment were active when running the install script, which can make it can grab paths particular to that environment and bundle them into the file. In such cases it will not fall back on other app's paths if other paths for critical libraries (such as nvidia toolkit) are in the file (it will skip them).


#### ``` OLLAMA_MODELS```  (Models Path)
-------------
``` OLLAMA_MODELS```  tells Ollama where to save the models.

1. Setting in the terminal session:
```
# Give your personal Linux user full ownership of the new folder 
sudo chown -R $USER:$USER /mnt/slave-drive/ollama-models

# for example setting the path in other drive 
export OLLAMA_MODELS="/mnt/slave-drive/ollama-models"

ollama serve #run the app
```
To clear the env var
```
unset OLLAMA_MODELS
```
Check the env var
```
echo $OLLAMA_MODELS
```
2. Setting permanently:

```
#Append to startup script
echo 'export OLLAMA_MODELS="/mnt/slave-drive/ollama-models"' >> ~/.bashrc

#Verify the line was added
tail -n 3 ~/.bashrc

#force terminal session to read the updated file
source ~/.bashrc
```

   A **safer option** can be editing the file (A single `>` will **overwrite and completely erase the entire** `.bashrc` file.):
   
```
nano ~/.bashrc #example with nano editor

#Append the line to startup script
export OLLAMA_MODELS="/mnt/slave-drive/ollama-models"

#save the file
CTRL + X and Y when prompted

#Verify the line was added
tail -n 3 ~/.bashrc

#force terminal session to read the updated file
source ~/.bashrc

```

-------------------------------------------
* Written with the aid of gemini overviews