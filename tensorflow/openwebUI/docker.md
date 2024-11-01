### Sources
https://docs.openwebui.com/getting-started/ -> Docker Compose section
https://peter-nhan.github.io/posts/Ollama-intro/

#### Docker Commands
- https://stackoverflow.com/questions/33083385/getting-console-output-from-a-docker-container -> logs
- https://stackoverflow.com/questions/26153686/how-do-i-run-a-command-on-an-already-existing-docker-container -> commands
- https://docs.docker.com/reference/cli/docker/container/start/ -> docker start ref
- https://stackoverflow.com/questions/41322541/rebuild-docker-container-on-file-changes -> containers - images
- https://stackoverflow.com/questions/30233105/docker-compose-up-for-only-certain-containers -> docker-compose fine grained execution services

If Ollama is on a Different Server, use this command:

To connect to Ollama on another server, change the OLLAMA_BASE_URL to the server's URL:
NOT RECOMMENDED!! HAS RESTART ALWAYS POLICY :https://stackoverflow.com/questions/41555884/docker-what-does-docker-run-restart-always-actually-do
```bash
docker run -d -p 3000:8080 -e OLLAMA_BASE_URL=https://example.com -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```
** RECOMMENDED EXAMPLE WITHOUT RESTART ALWAYS POLICY **
Example localhost port 11434
```bash
docker run -d -p 3000:8080 -e OLLAMA_BASE_URL=http://localhost:11434 -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main
```
Example localhost port 11434
```bash
docker rm -f open-webui
docker run -d -p 3000:8080 -e OLLAMA_BASE_URL=http://localhost:11434 -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main
```

docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -e OLLAMA_BASE_URL=http://localhost:11434 -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main


host.docker.internal:host-gateway

```bash
docker rm -f open-webui
docker run -d -p 3000:8080 -e -e OLLAMA_BASE_URL=http://localhost:11434 -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main
```



_________________________________________________________________________________
#### Other docker commands
Re-starting container with new environment variables
Container has to be re-moved and re-built
See:
- https://forums.docker.com/t/passing-environment-variables-to-the-container-at-docker-restart-container-name/85832
- https://stackoverflow.com/questions/41322541/rebuild-docker-container-on-file-changes
```bash
#replace open-webui with the actual name of the container
docker stop open-webui #stop container
docker rm -f open-webui #remove container
docker logs -f open-webui #replace open-webui with the actual name of the container

#re-start and re-build container (change command with new env variables)
docker run -d -p 3000:8080 -e OLLAMA_BASE_URL=http://host.docker.internal:11434 -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main
```
http://host.docker.internal:11434 


Check container logs real-time
```bash
docker logs -f open-webui #replace open-webui with the actual name of the container
```
list running containers with ports and names
```bash
docker ps -a
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

__________________________________________________________________________
TROUBLESHOOTING:
* Be careful of contexts, specially when using docker-desktop (other context could be using needed ports)
  - https://serverfault.com/questions/1128587/change-the-docker-context-in-docker-desktop
  - https://forums.docker.com/t/docker-ps-a-doesnt-show-running-containers/121046/3
  - https://unix.stackexchange.com/questions/106561/finding-the-pid-of-the-process-using-a-specific-port
 
* cannot see ollama localhost server outside of docker
 - https://github.com/open-webui/open-webui/issues/209
