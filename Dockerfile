# Corrected image for the ComfyUI Wizard image_ideogram4_t2i submission.
# The Wizard-generated Dockerfile only inherited the clean worker base; this
# image adds the model files referenced by the expanded API workflow.
FROM runpod/worker-comfyui:5.8.4-base

ENV MODE_TO_RUN=serverless

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p \
    /comfyui/models/vae \
    /comfyui/models/diffusion_models \
    /comfyui/models/text_encoders

RUN curl -L --fail --retry 5 --retry-delay 10 \
    -o /comfyui/models/vae/flux2-vae.safetensors \
    https://huggingface.co/Comfy-Org/flux2-dev/resolve/main/split_files/vae/flux2-vae.safetensors

RUN curl -L --fail --retry 5 --retry-delay 10 \
    -o /comfyui/models/diffusion_models/ideogram4_fp8_scaled.safetensors \
    https://huggingface.co/Comfy-Org/Ideogram-4/resolve/main/diffusion_models/ideogram4_fp8_scaled.safetensors

RUN curl -L --fail --retry 5 --retry-delay 10 \
    -o /comfyui/models/diffusion_models/ideogram4_unconditional_fp8_scaled.safetensors \
    https://huggingface.co/Comfy-Org/Ideogram-4/resolve/main/diffusion_models/ideogram4_unconditional_fp8_scaled.safetensors

RUN curl -L --fail --retry 5 --retry-delay 10 \
    -o /comfyui/models/text_encoders/qwen3vl_8b_fp8_scaled.safetensors \
    https://huggingface.co/Comfy-Org/Qwen3-VL/resolve/main/text_encoders/qwen3vl_8b_fp8_scaled.safetensors

CMD ["/start.sh"]
