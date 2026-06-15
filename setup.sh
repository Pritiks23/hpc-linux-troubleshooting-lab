#!/bin/bash

echo "Bootstrapping HPC troubleshooting lab..."

mkdir -p /tmp/hpc_lab/{logs,data}

# Ensure SSH key auth is possible
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# generate key (non-interactive safe)
ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519 <<< y >/dev/null 2>&1

cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

echo "Setup complete (no password auth needed)."
