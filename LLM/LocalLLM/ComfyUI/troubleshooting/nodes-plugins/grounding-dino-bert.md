#### Grounding Dino BERT Conflict
----------------------------------
#### NODES /Packages Affected:
- GroundingDinoModelLoader (segment anything)
	- https://www.runcomfy.com/comfyui-nodes/comfyui_segment_anything/GroundingDinoModelLoader--segment-anything-
+ ComfyUI SAM2(Segment Anything 2)
	+ https://github.com/neverbiasu/ComfyUI-SAM2
	+ https://pyimagesearch.com/2026/01/19/grounded-sam-2-from-open-set-detection-to-segmentation-and-tracking/
+ ComfyUI Segment Anything
	+ https://github.com/storyicon/comfyui_segment_anything
		+ https://github.com/idea-research/grounded-segment-anything (Model)
+ Segment Anything for Stable Diffusion WebUI
	+ https://github.com/continue-revolution/sd-webui-segment-anything


#### **Sources**:
	- https://medium.com/@elvenkim1/the-fix-that-saves-my-grounding-dino-61271f0a7c00
	- https://github.com/1038lab/ComfyUI-RMBG/issues/196
	- https://github.com/IDEA-Research/Grounded-Segment-Anything/issues/555

#### Error:
```
AttributeError: 'BertModel' object has no attribute 'get_head_mask'
```



#### Stack Trace

```
TTP Request: HEAD https://huggingface.co/bert-base-uncased/resolve/main/model.safetensors "HTTP/1.1 302 Found"
Loading weights: 100%|██████████████████████| 199/199 [00:00<00:00, 1271.30it/s]
!!! Exception during processing !!! 'BertModel' object has no attribute 'get_head_mask'
Traceback (most recent call last):
  File "/path_to_comfyui/ComfyUI/execution.py", line 535, in execute
    output_data, output_ui, has_subgraph, has_pending_tasks = await get_output_data(prompt_id, unique_id, obj, input_data_all, execution_block_cb=execution_block_cb, pre_execute_cb=pre_execute_cb, v3_data=v3_data)
                                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "path_to_comfyui/ComfyUI/execution.py", line 335, in get_output_data
    return_values = await _async_map_node_over_list(prompt_id, unique_id, obj, input_data_all, obj.FUNCTION, allow_interrupt=True, execution_block_cb=execution_block_cb, pre_execute_cb=pre_execute_cb, v3_data=v3_data)
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "path_to_comfyui/ComfyUI/execution.py", line 309, in _async_map_node_over_list
    await process_inputs(input_dict, i)
  File "path_to_comfyui/ComfyUI/execution.py", line 297, in process_inputs
    result = f(**inputs)
             ^^^^^^^^^^^
  File "path_to_comfyui/ComfyUI/custom_nodes/comfyui-sam2/node.py", line 294, in main
    dino_model = load_groundingdino_model(model_name)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "path_to_comfyui/ComfyUI/custom_nodes/comfyui-sam2/node.py", line 146, in load_groundingdino_model
    dino = local_groundingdino_build_model(dino_model_args)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "path_to_comfyui/ComfyUI/custom_nodes/comfyui-sam2/local_groundingdino/models/__init__.py", line 17, in build_model
    model = build_func(args)
            ^^^^^^^^^^^^^^^^
  File "path_to_comfyui/ComfyUI/custom_nodes/comfyui-sam2/local_groundingdino/models/GroundingDINO/groundingdino.py", line 362, in build_groundingdino
    model = GroundingDINO(
            ^^^^^^^^^^^^^^
  File "path_to_comfyui/ComfyUI/custom_nodes/comfyui-sam2/local_groundingdino/models/GroundingDINO/groundingdino.py", line 101, in __init__
    self.bert = BertModelWarper(bert_model=self.bert)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "path_to_comfyui/ComfyUI/custom_nodes/comfyui-sam2/local_groundingdino/models/GroundingDINO/bertwarper.py", line 25, in __init__
    self.get_head_mask = bert_model.get_head_mask
                         ^^^^^^^^^^^^^^^^^^^^^^^^
  File "path_to_comfyui/anaconda3/envs/comfyenv/lib/python3.11/site-packages/torch/nn/modules/module.py", line 1967, in __getattr__
    raise AttributeError(
AttributeError: 'BertModel' object has no attribute 'get_head_mask'
```