#!/usr/bin/env bash
set -euo pipefail
SERVICE_FILE="${1:-/etc/systemd/system/broken_service.service}"
SERVICE_NAME="$(basename "$SERVICE_FILE")"
sudo sed -i 's|^ExecStart=.*|ExecStart=/usr/bin/sleep infinity|' "$SERVICE_FILE"
sudo systemctl daemon-reload
sudo systemctl restart "$SERVICE_NAME"
