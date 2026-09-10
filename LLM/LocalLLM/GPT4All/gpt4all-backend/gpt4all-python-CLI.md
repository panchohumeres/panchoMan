**Sources**:
- https://docs.gpt4all.io/old/gpt4all_cli.html
- https://github.com/nomic-ai/gpt4all/wiki/Python-CLI
- https://github.com/nomic-ai/gpt4all/issues/3033

GPT4All CLI is a python wrapper. It can be run either through a command line interface or within Python.

#### Install
-----------------------------------
**Recommended**: Create a conda environment
```bash
#replace gpt4all with whatever environment name
conda create --name gpt4all 

conda activate gpt4all #Switch to environment
conda install pip #make sure have pip installed
conda deactivate #deactivate environment
```

Install packages
```
pip install gpt4all typer

###other packages it may complain if not installed in the env
pip install typing-extensions
```

**Recommended (for Conda ENV):** Install **CUDA in environment** (otherwise GPT4All will fall back only to CPU)

GPT4All looks for `libcudart.so.11.0` (**CUDA 11**) or `libcudart.so.12` (**CUDA 12**). Despite newer versions of CUDA being retrocompatible with older versions, GPT4All will fail in finding the CUDA libraries.

This command will install gpt4all bundled with the necessary CUDA libs:
```
pip install "gpt4all[cuda]"
```



**The CLI is a self-contained script called [app.py](https://github.com/nomic-ai/gpt4all/blob/main/gpt4all-bindings/cli/app.py)**;  [download](https://raw.githubusercontent.com/nomic-ai/gpt4all/main/gpt4all-bindings/cli/app.py) and save it anywhere you like.
**Note**: Check the official download link in the GPT4All documentation.

```bash
## IN your target folder

#with curl
curl -O https://raw.githubusercontent.com/nomic-ai/gpt4all/main/gpt4all-bindings/cli/app.py

#with wget
wget https://raw.githubusercontent.com/nomic-ai/gpt4all/main/gpt4all-bindings/cli/app.py

```
#### Python CLI
------------------
Python script which is built on top of the [Python bindings](https://docs.gpt4all.io/old/gpt4all_python.html) ([repository](https://github.com/nomic-ai/gpt4all/tree/main/gpt4all-bindings/python)) and the [typer](https://typer.tiangolo.com/) package. 

Base command for running

```bash
#with no options, it will download a default model and run a chat
python app.py repl 
```

Manual
```
python app.py repl --help
```

**Run a specific model**:
list models
```bash
### Replace with the path to your GPT4All install or models path
ls ~/.cache/gpt4all/
```

Run model
```bash
#replace the path to your path to models
#replace deepseek in the example with your model
python app.py repl --model /home/user/my-gpt4all-models/DeepSeek-R1-Distill-Llama-8B-Q4_0.gguf
```

### Syntax
------------------------


#### Alternatives
------------------
Non official CLI
- https://pypi.org/project/gpt4all-cli/