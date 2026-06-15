#!/usr/bin/env bash
set -euo pipefail
HOST="${1:-localhost}"

echo "Checking DNS..."
getent hosts "$HOST" || true

echo "Checking port 22..."
( timeout 3 bash -c "</dev/tcp/$HOST/22" && echo "SSH port open" ) || echo "SSH port closed/unreachable"

echo "Verbose SSH attempt..."
ssh -vvv -o ConnectTimeout=5 "$HOST" true || true
