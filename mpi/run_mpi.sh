#!/usr/bin/env bash
set -euo pipefail
mpicc -o hello_mpi hello_mpi.c
mpirun -np "${1:-2}" ./hello_mpi
