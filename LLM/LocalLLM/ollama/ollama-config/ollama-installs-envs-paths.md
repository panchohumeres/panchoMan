**Sources**:
- https://docs.ollama.com/faq


### Types of Installs on Linux
Ollama has to ways of running it, via systemd and by manual execution of the service:
- **Systemd Install:** Runs as the restricted system user `ollama`., with files residing in a different location from home user files. Starts automatically when computer boots up.
- **Manual Service (`ollama serve`):** Runs under personal user home account. It has access to user files and home directory, and it only runs when you explicitly type the ollama command.

#### Default Paths

As they run under different users, the installs (via systemd or manual) default todifferent folders:

- **Systemd path:** `/usr/share/ollama/.ollama/models/`
- **Manual path:** `/home/youruser/.ollama/models/`

**Note**: If you download a model while running the manual service, it will **not** show up when you use the systemd service (and vice versa).

#### Models Path
Default locations for storing models on Linux:
```
# Check the system service folder (systemd)
sudo ls -la /usr/share/ollama/.ollama/models/

# Check your personal user folder ("manual" execution)
ls -la ~/.ollama/models/ 
```


#### Environment Vars and Config Files
- To change settings for the **Systemd install**, you have to edit `/etc/systemd/system/ollama.service` file.
- To change settings for the **Manual service**, you have to use CLI commands like `export OLLAMA_MODELS="..."` right before running it.