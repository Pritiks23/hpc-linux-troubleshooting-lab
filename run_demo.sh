#!/bin/bash

echo "==================================="
echo "HPC INCIDENT SIMULATION START"
echo "==================================="

echo ""
echo "[1] VERIFY SSH PORT"
nc -zv localhost 2222

echo ""
echo "[2] SSH NON-INTERACTIVE TEST"
ssh -i ~/.ssh/id_ed25519 \
    -o BatchMode=yes \
    -p 2222 localhost "echo SSH OK"

echo ""
echo "[3] SERVICE DIAGNOSTICS"
bash troubleshooting/service_diagnostics.sh ssh

echo ""
echo "[4] SYSTEM RESOURCES"
free -h
df -h

echo ""
echo "[5] NETWORK STATE"
ss -tupln

echo ""
echo "[6] MPI DEMO"
bash mpi/run_mpi.sh

echo ""
echo "[7] SLURM SIMULATION"
bash slurm/sbatch_mock.sh slurm/submit_example.sbatch

echo ""
echo "==================================="
echo "END OF INCIDENT SIMULATION"
echo "==================================="
