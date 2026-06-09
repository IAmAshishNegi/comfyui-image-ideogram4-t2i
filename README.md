# image_ideogram4_t2i fixed deployment

This is the corrected deployment bundle for the ComfyUI Wizard submission `kd79235r9ngdxp9wvpq6zx9hqx88b4n4`.

## What was broken

The Wizard-generated Dockerfile only contained:

```dockerfile
FROM runpod/worker-comfyui:5.8.4-base
```

That base image is a clean ComfyUI worker, so the endpoint could become `Ready` while still having no Ideogram model files to execute the workflow. The downloaded `api-workflow.json` was also the compact subgraph wrapper, not the expanded graph that is easier to run and debug in serverless.

## What this bundle changes

- Downloads the model files referenced by the expanded workflow:
  - `flux2-vae.safetensors`
  - `ideogram4_fp8_scaled.safetensors`
  - `ideogram4_unconditional_fp8_scaled.safetensors`
  - `qwen3vl_8b_fp8_scaled.safetensors`
- Uses `api-workflow.json` copied from `workflows/ideogram4_bridal_makeup_instagram_post.json`.
- Includes `submit-smoke-test.mjs` to test a rebuilt endpoint with the correct RunPod payload shape: `{"input":{"workflow": ...}}`.

## Build and push

Build this remotely or on a machine with enough disk/network bandwidth for the checkpoint downloads:

```bash
docker build -t <registry>/<repo>:image-ideogram4-t2i-fixed .
docker push <registry>/<repo>:image-ideogram4-t2i-fixed
```

Then update the RunPod template or create a new template with that pushed image and start command `/start.sh`.

## Smoke test

Set your RunPod API key locally, then run:

```bash
export RUNPOD_API_KEY=...
node submit-smoke-test.mjs <endpoint-id>
```

Optional custom prompt:

```bash
node submit-smoke-test.mjs <endpoint-id> "Luxury Instagram post for a bridal makeup salon, red and gold Indian bride, readable ad text"
```

The response is saved to `endpoint-smoke-response.json`.
