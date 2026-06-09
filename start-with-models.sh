#!/usr/bin/env bash
set -euo pipefail

/usr/local/bin/download-models.sh
exec /start.sh
