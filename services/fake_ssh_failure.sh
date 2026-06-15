#!/bin/bash

echo "Simulating SSH failure scenario..."

sudo systemctl stop ssh 2>/dev/null || true

echo "SSH service stopped (or simulated failure)."
