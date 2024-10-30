#Sources

- https://www.youtube.com/watch?v=bvRLpRWgyBc
- https://docs.openwebui.com/getting-started/
- https://stackoverflow.com/questions/62325068/cannot-install-latest-nodejs-using-conda-on-mac

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
3.



