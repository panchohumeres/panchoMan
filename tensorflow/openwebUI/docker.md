### Sources
https://docs.openwebui.com/getting-started/ -> Docker Compose section

If Ollama is on a Different Server, use this command:

To connect to Ollama on another server, change the OLLAMA_BASE_URL to the server's URL:
```bash
docker run -d -p 3000:8080 -e OLLAMA_BASE_URL=https://example.com -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

Example localhost port 11434
```bash
docker run -d -p 3000:8080 -e OLLAMA_BASE_URL=http://localhost:11434/ -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```


_________________________________________________________________________________________________________

Clone and cd into repo
```bash
git clone https://github.com/open-webui/open-webui.git
cd open-webui
```

Docker Compose
Using Docker Compose

For Nvidia GPU Support: Use an additional Docker Compose file:
```bash
docker compose -f docker-compose.yaml -f docker-compose.gpu.yaml up -d --build
```
Takes like an hour to build
