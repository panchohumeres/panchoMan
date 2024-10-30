### Sources
https://docs.openwebui.com/getting-started/ -> Docker Compose section

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
