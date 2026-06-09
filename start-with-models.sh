#!/usr/bin/env bash
set -euo pipefail

echo "[startup] $(date -u '+%Y-%m-%dT%H:%M:%SZ') starting model preparation"
/usr/local/bin/download-models.sh
echo "[startup] $(date -u '+%Y-%m-%dT%H:%M:%SZ') model preparation complete; starting RunPod ComfyUI worker"
exec /start.sh
