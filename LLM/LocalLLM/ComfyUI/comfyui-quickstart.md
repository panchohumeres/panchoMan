### Sources:
- https://www.youtube.com/watch?v=l4CiwGS2ewY
- https://blog.comfy.org/p/qwen-image-in-comfyui-new-era-of
- https://docs.comfy.org/development/core-concepts/models

### RUN
0. If install in conda environment,
```
conda activate comfyenv
#for listing available environments
conda env list

```
1. CD into ComfyUI folder (where it is installed) and run the python script
	```
	cd ComfyUI
	python main.py
	```

	a. With Manager (**Recommended**, requires[ installation of manager separately](comfyui-install.md#a.-install-node-manager) ):
	
	```
	python main.py --enable-manager
	```

	b. with [lowvram] [comfyui-trouble-hw-opt](comfyui-trouble-hw-opt.md#configurar-modo-baja-memoria) mode (for enhanced performance in commodity hardware)
	
		
		#lowvram mode
		python main.py --lowvram
		#lowvram mode & manager enabled
		python main.py --lowvram --enable-manager
		#lowvram mode & fp8 support
		python main.py --lowvram --fp8_e4m3fn-textenc
		 




2. Go to url shown in CLI, usually:
```
To see the GUI go to: http://127.0.0.1:8188
```

### Download Models and Workflows:


-------------------------------------------------------------------
 Generado con la asistencia de Gemini AI Overviews

