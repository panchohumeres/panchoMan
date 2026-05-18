1. Outfitting a person with clothes from another image
   ---------------------------------------------------
   The Method: Use IP-Adapter FaceID / Cloth or OOTDiff (Open-Outfitting).
  Why it works on 4GB: IP-Adapter acts as a visual prompt. Instead of an enormous multimodal model, it injects the clothing style using a tiny 200MB reference file alongside a lightweight SD 1.5 Inpainting model.
  Keywords to search in ComfyUI Manager: ComfyUI_IPAdapter_plus or ComfyUI-OOTDiffusion.

2. Extracting a face from an image
   ----------------------------------------
     The Method: Use Reactor or InsightFace.
     Why it works on 4GB: This does not use diffusion models at all. It uses a hyper-fast script that detects facial landmarks, crops the face, and can swap it onto another body in less than 2 seconds, using virtually zero VRAM.
     Keywords to search in ComfyUI Manager: ComfyUI-Reactor.

3. Removing the background
   -----------------------------
   The Method: Use LayerDiffusion or Rembg / LayerMask.
   Why it works on 4GB: These are highly optimized automated segmentation networks (like BiRefNet or BRIA). They analyze the image edges and erase the background instantly without loading a massive AI generation pipeline.
   Keywords to search in ComfyUI Manager: ComfyUI-Inference-Core-Nodes or ComfyUI-Layer-Diffusion.

4. Correcting imperfections (Inpainting & Face Restoration)
   ------------------------------------------------------------
   The Method: Use CodeFormer or GFPGAN combined with an SD 1.5 Inpainting Model (like realisticVisionV60_v60Inpainting.safetensors).
   Why it works on 4GB: You mask the blemish or imperfection. The SD 1.5 model only regenerates those specific pixels. Then, CodeFormer runs a quick post-processing pass to sharpen eyes, skin texture, and teeth instantly.
   Keywords to search in ComfyUI Manager: ComfyUI-Impact-Pack (for Detailer nodes).

