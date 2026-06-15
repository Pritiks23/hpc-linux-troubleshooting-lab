# hpc-linux-troubleshooting-lab
Monday's Version


# HPC Linux Troubleshooting Lab (Codespaces Edition)

This project simulates a small-scale HPC + Linux production environment entirely inside GitHub Codespaces. It is designed to demonstrate my ability to debug real system-level failures using standard Linux observability and scheduling tools.

The environment intentionally includes failing services, resource exhaustion scenarios, and misconfigured system components to replicate real operational issues found in HPC clusters and Linux servers.

---

## What This Project Demonstrates

### Linux Service Troubleshooting
I diagnose failing systemd services using:
- `systemctl status <service>`
- `journalctl -u <service> -n 100 --no-pager`
- log parsing for root cause analysis
- dependency and permission inspection

### System Resource Debugging
I analyze system health under failure conditions using:
- `top` / `htop` for CPU and memory pressure
- `free -h` for swap exhaustion
- `df -h` for disk saturation issues
- `ss -tupln` for socket and port-level inspection

### Network and SSH Diagnostics
I debug connectivity issues using:
- `nc -zv` for port reachability
- SSH service logs via `journalctl`
- authentication and key failure inspection

### HPC Job Scheduling (Slurm Simulation)
This project demonstrates:
- job submission using `sbatch`
- queue-based scheduling concepts
- partitions and resource allocation
- walltime and CPU/memory constraints
- fair-share scheduling principles

### Configuration and Permissions
I apply Linux system administration practices including:
- user/group management
- UID consistency considerations
- `chmod`, `chown`, and shared directory configuration
- setgid directory behavior for collaborative environments

### Automation and Infrastructure as Code
I use:
- Ansible playbooks for system provisioning
- reproducible environment configuration
- role-based deployment structure

### Scientific Software Build Systems
I demonstrate awareness of:
- CMake and Autotools build systems
- Spack-based package management
- MPI-based distributed execution patterns

---

## Failure Scenarios Included

This environment intentionally simulates:
- memory exhaustion leading to OOM conditions
- disk-full failures breaking services silently
- broken systemd services due to misconfiguration
- SSH login failures due to auth or port issues
- CPU saturation causing scheduling delays

Each scenario is paired with a structured diagnostic workflow.

---

## Troubleshooting Methodology

The diagnostic approach follows:

1. Check service state (`systemctl status`)
2. Inspect logs (`journalctl`)
3. Evaluate system resources (`top`, `free`, `df`)
4. Verify network bindings (`ss -tupln`)
5. Validate configuration + permissions
6. Trace dependency chain failure

---

## Goal

To replicate real-world Linux/HPC system administration tasks in a controlled environment that demonstrates operational debugging, system observability, and infrastructure understanding.
