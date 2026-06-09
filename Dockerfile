# Corrected image for the ComfyUI Wizard image_ideogram4_t2i submission.
# The Wizard-generated Dockerfile only inherited the clean worker base. This
# image installs the model files referenced by the expanded API workflow and
# keeps a startup hook as a quick integrity check before the handler starts.
FROM runpod/worker-comfyui:5.8.4-base

ENV MODE_TO_RUN=serverless

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p \
    /comfyui/models/vae \
    /comfyui/models/diffusion_models \
    /comfyui/models/text_encoders

COPY download-models.sh /usr/local/bin/download-models.sh
COPY start-with-models.sh /usr/local/bin/start-with-models.sh

RUN chmod +x /usr/local/bin/download-models.sh /usr/local/bin/start-with-models.sh

RUN /usr/local/bin/download-models.sh

CMD ["/usr/local/bin/start-with-models.sh"]
