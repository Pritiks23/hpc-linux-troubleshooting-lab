# hpc-linux-troubleshooting-lab
Monday's Version


# HPC Linux Troubleshooting Lab (Codespaces Edition)

This project simulates a simplified HPC (High Performance Computing) environment to demonstrate core systems engineering concepts including MPI execution, batch scheduling (Slurm-style), system failure diagnosis, and service management using systemd-like unit configuration.

The lab is designed to replicate real-world cluster troubleshooting workflows in a controlled environment (GitHub Codespaces / Linux container).

---

## What This Project Demonstrates
## 1. MPI (Parallel Execution Layer)

I started with MPI because it represents the fundamental compute layer in HPC systems — where work is distributed across multiple processes.

I compiled and executed a simple MPI program using mpicc and mpirun. When I first ran into the “slot” error, I investigated why MPI was refusing to launch multiple processes. I learned that MPI enforces a concept called slots, which represent available execution capacity on a node.

To resolve this, I used:

mpirun --oversubscribe -np 4 ./hello_mpi

I did this because in containerized environments like Codespaces, the system does not expose real multi-core scheduling in the same way a cluster does. Oversubscription allowed MPI to simulate parallel execution even when physical slot limits were not properly advertised.

This helped me understand how MPI adapts to constrained environments and how process-based parallelism is actually orchestrated.

## 2. Slurm (Batch Scheduling Simulation)

Next, I explored the Slurm module because real HPC systems never run workloads manually — everything goes through a scheduler.

I executed a mock batch job using:

bash submit_example.sbatch

I did this because Slurm represents the separation between job submission and job execution. Instead of directly running a program, users submit jobs to a scheduler, which handles resource allocation, queueing, and execution lifecycle management.

The script simulates the full Slurm lifecycle:

job submission
node assignment
execution phase
completion logging

This helped me understand how compute clusters enforce fairness, scheduling policies, and resource isolation.
## 3. System Failure Simulation (Linux Troubleshooting Layer)

I then moved into failure scenarios because understanding HPC systems requires knowing how they break under pressure.

Memory Pressure

I executed a memory stress script:

bash fake_memory_pressure.sh

I did this because memory exhaustion is one of the most common failure modes in HPC jobs. The process was terminated by the Linux kernel, which taught me how the Out-of-Memory (OOM) killer behaves when the system runs out of available memory.

This demonstrated that failures at scale are often abrupt and not always gracefully handled by applications.

Disk Utilization

I then analyzed disk usage using a simulated disk pressure script:

bash fake_disk_fill.sh

I did this because disk saturation is a common issue in HPC environments due to large intermediate datasets and logs.

Instead of actually filling the disk, the script surfaced filesystem usage, which allowed me to interpret df -h output and understand how to identify storage pressure before it becomes a system-wide failure.


## SSH Failure Scenario

I then simulated an SSH/service failure using:

bash fake_ssh_failure.sh

I did this because remote access is critical in HPC systems, and SSH failures often block entire workflows.

The output showed that systemd was not available in this environment, which helped me understand how service management differs between full Linux systems and containerized environments like Codespaces.


## 4. systemd Service Debugging

I then worked on debugging a broken systemd service configuration.

The service originally pointed to a non-existent executable:

ExecStart=/opt/app/run.sh

I identified this as the root cause because systemd services depend entirely on valid executable paths. If the binary does not exist, the service cannot start regardless of configuration correctness.

I fixed it by updating the path to a valid script in the repository:

ExecStart=/workspaces/hpc-linux-troubleshooting-lab/services/fake_disk_fill.sh

I did this because systemd failures in real HPC environments are often caused by incorrect deployment paths, missing binaries, or environment mismatches rather than system-level faults.

Since systemd is not active in this container, I validated correctness by manually executing the target script instead of relying on systemctl.


## 5. HPC Ecosystem Concepts (Ansible + Slurm + Spack)

Finally, I explored supporting HPC ecosystem tools to understand how clusters are provisioned and managed.

Ansible: I reviewed the playbook structure to understand how infrastructure-as-code is used to configure clusters consistently.
Slurm configuration files: I examined how partitions and scheduling policies are defined.
Spack documentation: I studied how HPC environments manage complex software dependencies across clusters.

I did this because HPC systems are not just compute engines — they are full-stack environments that require orchestration, configuration management, and reproducible software stacks.

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

## Conclusion

Overall, I worked through this lab to understand HPC systems as a layered architecture rather than isolated tools.

I learned that:

MPI handles parallel compute execution
Slurm manages job scheduling and resource allocation
Linux handles system-level failures (memory, disk, services)
systemd manages service lifecycle in production systems
HPC environments are highly dependent on correct configuration and resource constraints

Most importantly, I learned how to debug across layers instead of treating failures in isolation.
