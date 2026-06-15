#!/bin/bash

echo "======================================"
echo "HPC LINUX TROUBLESHOOTING LAB SETUP"
echo "======================================"

echo ""
echo "[1/6] Creating directory structure..."
mkdir -p /tmp/hpc_lab/{logs,data,queue,failures}

echo ""
echo "[2/6] Creating demo users (safe mode)..."
id demo >/dev/null 2>&1 || sudo useradd -m demo
id hpcuser >/dev/null 2>&1 || sudo useradd -m hpcuser

echo ""
echo "[3/6] Setting up fake application directory..."
sudo mkdir -p /opt/app
sudo bash -c 'cat > /opt/app/run.sh <<EOF
#!/bin/bash
echo "Starting HPC demo application..."
sleep 2
echo "ERROR: missing configuration file"
exit 1
EOF'

sudo chmod +x /opt/app/run.sh

echo ""
echo "[4/6] Setting permissions scenario (shared HPC directory)..."
sudo mkdir -p /tmp/hpc_shared
sudo chown root:root /tmp/hpc_shared
sudo chmod 770 /tmp/hpc_shared

echo ""
echo "[5/6] Verifying core tools..."
for cmd in systemctl journalctl df free ss nc ps; do
    command -v $cmd >/dev/null 2>&1 && echo "OK: $cmd" || echo "MISSING: $cmd"
done

echo ""
echo "[6/6] Setup complete."

echo ""
echo "Next step:"
echo "  bash run_demo.sh"
echo "======================================"
