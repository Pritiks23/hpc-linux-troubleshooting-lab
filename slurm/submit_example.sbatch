#!/bin/bash
#SBATCH --job-name=test_job
#SBATCH --output=out.txt
#SBATCH --ntasks=1
#SBATCH --time=00:05:00

echo "Running HPC job simulation"
hostname
sleep 10
