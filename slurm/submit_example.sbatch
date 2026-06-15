#!/bin/bash
#SBATCH --job-name=hello-lab
#SBATCH --partition=debug
#SBATCH --ntasks=1
#SBATCH --time=00:01:00

echo "Hello from SLURM on $(hostname)"
