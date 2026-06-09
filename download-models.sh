#!/usr/bin/env bash
set -euo pipefail

download_if_missing() {
  local url="$1"
  local path="$2"

  if [ -s "$path" ]; then
    echo "Model already present: $path"
    return
  fi

  mkdir -p "$(dirname "$path")"
  echo "Downloading $(basename "$path")"
  curl -L --fail --retry 8 --retry-delay 10 --retry-all-errors -o "${path}.tmp" "$url"
  mv "${path}.tmp" "$path"
}

download_if_missing \
  "https://huggingface.co/Comfy-Org/flux2-dev/resolve/main/split_files/vae/flux2-vae.safetensors" \
  "/comfyui/models/vae/flux2-vae.safetensors"

download_if_missing \
  "https://huggingface.co/Comfy-Org/Ideogram-4/resolve/main/diffusion_models/ideogram4_fp8_scaled.safetensors" \
  "/comfyui/models/diffusion_models/ideogram4_fp8_scaled.safetensors"

download_if_missing \
  "https://huggingface.co/Comfy-Org/Ideogram-4/resolve/main/diffusion_models/ideogram4_unconditional_fp8_scaled.safetensors" \
  "/comfyui/models/diffusion_models/ideogram4_unconditional_fp8_scaled.safetensors"

download_if_missing \
  "https://huggingface.co/Comfy-Org/Qwen3-VL/resolve/main/text_encoders/qwen3vl_8b_fp8_scaled.safetensors" \
  "/comfyui/models/text_encoders/qwen3vl_8b_fp8_scaled.safetensors"
