#!/usr/bin/env bash
set -euo pipefail
TARGET_FILE="${1:-/tmp/fake_disk_fill.bin}"
dd if=/dev/zero of="$TARGET_FILE" bs=1M count=100 status=progress
