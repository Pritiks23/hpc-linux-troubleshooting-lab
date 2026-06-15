#!/usr/bin/env bash
set -euo pipefail
TARGET_FILE="${1:-/tmp/fake_disk_fill.bin}"
SIZE_MB="${2:-100}"
dd if=/dev/zero of="$TARGET_FILE" bs=1M count="$SIZE_MB" status=progress
