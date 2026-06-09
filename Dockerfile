# Diagnostic image for the ComfyUI Wizard image_ideogram4_t2i submission.
# Keep the Docker image thin and download/check model files at worker startup
# so RunPod container logs show exactly where startup gets stuck.
FROM runpod/worker-comfyui:5.8.4-base

ENV MODE_TO_RUN=serverless

RUN mkdir -p \
    /comfyui/models/vae \
    /comfyui/models/diffusion_models \
    /comfyui/models/text_encoders

COPY download-models.sh /usr/local/bin/download-models.sh
COPY start-with-models.sh /usr/local/bin/start-with-models.sh

RUN chmod +x /usr/local/bin/download-models.sh /usr/local/bin/start-with-models.sh

CMD ["/usr/local/bin/start-with-models.sh"]
