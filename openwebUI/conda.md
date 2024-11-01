### Sources

- https://www.youtube.com/watch?v=bvRLpRWgyBc
- https://docs.openwebui.com/getting-started/
- https://stackoverflow.com/questions/62325068/cannot-install-latest-nodejs-using-conda-on-mac #how tu upgrade node in anaconda env

#### Secondary sources
- https://loisthash.medium.com/getting-started-in-node-js-with-conda-cd543de24311 #installing node in anaconda
- https://anaconda.org/conda-forge/nodejs #conda forge links for node

0. System Wide Installs
```bash
sudo apt-get install ffmpeg #ffmpeg for handling multimedia data
sudo apt-get install uvicorn #uvicorn, for python web server
cd open-webui
```

2. Clone repo
```bash
git clone https://github.com/open-webui/open-webui.git
cd open-webui
```
2. Create Conda Environment
```bash
conda create --name open-webui python=3.11 #create environment
conda activate open-webui #log into environment
```
2. Install node-NPM inside environment
a. install node from conda-forge repo
```bash
conda install -c conda-forge nodejs
```
b. IMPORTANT!! -> Update node and npm to latest version (>20, as is required by openwebUI).
Has to be done in this way as dependencies are broken in conda-forge and will not upgrade done in other way (see stackoverflow link)
```bash
conda upgrade -c conda-forge nodejs
```
3. Copy node environment
```bash
cp .env.example .env
```
4. Install and build node environment (Fron-end)
```bash
npm install
npm run build
```
5. Install python environment (Back-end)
```bash
cd .\backend
pip install -r requirements.txt -U
```
6. Start
```bash
bash start.sh
```
##### OLLAMA CONFIG
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




### TROUBLESHOOTING:

- As is running the app fails with this tensorflow error:
```bash
from torch._C import *  # noqa: F403
./nvidia/cusparse/lib/libcusparse.so.12: undefined symbol: __nvJitLinkComplete_12_4, version libnvJitLink.so.12
```
It is related with CUDA version to which is pointing in an environment config
https://github.com/pytorch/pytorch/issues/134929



