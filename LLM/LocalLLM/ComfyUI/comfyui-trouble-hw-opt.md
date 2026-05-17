### Troubleshooting related to Hardware Optimizations
----------------------------------------------------------


#### Resource Managers
Custom "Nodes" (Plug-ins) for hardware resources monitoring (CPU, RAM, GPU, VRAM, etc. available):
- https://www.youtube.com/watch?v=OFYxair2pKQ
1. **crystools**:
  - https://github.com/crystian/comfyui-crystools
  - Install (within corresponding conda env):```cd ComfyUI/custom_nodes
  git clone https://github.com/crystian/comfyui-crystools.git
  cd comfyui-crystools
  pip install -r requirements.txt```
2. **ComfyUI-Elegant-Resource-Monitor**
    - https://comfy.icu/extension/ChrisColeTech__ComfyUI-Elegant-Resource-Monitor
    - https://www.floyo.ai/all-comfyui-nodes/comfyui-elegant-resource-monitor-chriscoletech
   
CLI Monitoring
 - NVIDIA:
   ```
   #Run this command to print a clean summary of your total, used, and free video memory:
   nvidia-smi --query-gpu=memory.total,memory.used,memory.free --format=csv
   #If you want a shorter, faster command that only prints the exact number of free Megabytes, use this:
   nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits
   ```
- System: Run the standard free command with the -h flag to see your system memory in human-readable gigabytes:
  ```
  free -h
  ```
- Pro-Tip: The "All-in-One" Custom Command
  ```
  echo "--- FREE VRAM ---"; nvidia-smi --query-gpu=memory.free --format=csv,noheader; echo "--- FREE RAM ---"; free -h | grep   Mem | awk '{print $7 " available"}'
  ```







