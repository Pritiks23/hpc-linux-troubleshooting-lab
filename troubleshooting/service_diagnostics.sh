#!/usr/bin/env bash
set -euo pipefail
SERVICE="${1:-broken_app.service}"

systemctl status "$SERVICE" || true
journalctl -u "$SERVICE" -n 50 --no-pager || true
