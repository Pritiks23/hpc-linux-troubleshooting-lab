# hpc-linux-troubleshooting-lab
Monday's Version


# HPC Linux Troubleshooting Lab (Codespaces Edition)

I created this project to  simulate a simplified HPC (High Performance Computing) environment to demonstrate core systems engineering concepts including MPI execution, batch scheduling (Slurm-style), system failure diagnosis, and service management using systemd-like unit configuration.

The lab is designed to replicate real-world cluster troubleshooting workflows in a controlled environment (GitHub Codespaces / Linux container).

---

## What This Project Demonstrates
<img width="1700" height="1646" alt="image" src="https://github.com/user-attachments/assets/13b45e85-753d-463e-bd83-e4edf7843d98" />


## 1. MPI (Parallel Execution Layer)

I started with MPI(Message Passing Interface) which is a standard communication framework used by distributed memory HPC applications. It allows proccess running on multiple CPUs or nodes to exchange data using oeprations such as send, receive, nbroadcast and reduce. MPI enables large scientific simulations and parallel workloads to scale across clusters. 

The

I compiled and executed a simple MPI program using mpicc and mpirun. When I first ran into the “slot” error, I investigated why MPI was refusing to launch multiple processes. I learned that MPI enforces a concept called slots, which represent available execution capacity on a node.

To resolve this, I used:

mpirun --oversubscribe -np 4 ./hello_mpi

I did this because in containerized environments like Codespaces, the system does not expose real multi-core scheduling in the same way a cluster does. Oversubscription allowed MPI to simulate parallel execution even when physical slot limits were not properly advertised.

This helped me understand how MPI adapts to constrained environments and how process-based parallelism is actually orchestrated.

## 2. Slurm (Batch Scheduling Simulation)
<img width="1700" height="404" alt="image" src="https://github.com/user-attachments/assets/4c3ed500-19cd-4a26-a6c2-7901722cea27" />


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

I did this because memory exhaustion is one of the most common failure modes in HPC jobs. The process was terminated by the Linux kernel, which demonstrated how the Out-of-Memory (OOM) killer behaves when the system runs out of available memory.

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
<img width="1700" height="686" alt="image" src="https://github.com/user-attachments/assets/19f25547-d5dd-472c-9433-71eda2cfd435" />
<img width="1700" height="440" alt="image" src="https://github.com/user-attachments/assets/2304d168-4b63-4962-9f74-ad00fea41477" />


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
<img width="1700" height="542" alt="image" src="https://github.com/user-attachments/assets/5f368aeb-232c-418d-b956-2c051e400bed" />
<img width="1570" height="820" alt="image" src="https://github.com/user-attachments/assets/f7f002b3-5174-4ff9-8e00-7ccada247168" />
<img width="1570" height="438" alt="image" src="https://github.com/user-attachments/assets/c341d08d-559a-4568-bb1e-879fc10e2454" />




Finally, I explored supporting HPC ecosystem tools to understand how clusters are provisioned and managed.

Ansible: Imagine you need to install Python and configure Slurm on 500 compute nodes. Instead of logging into each server, you create an Ansible Playbook then run ansible-playbook install-python.yaml Ansible will SSH into every node, run the commands verify the desired state exists and report failures. 

Slurm configuration files: I examined how partitions and scheduling policies are defined. Slurm sits between users and compute nodes, users sibmit jobs with sbathc, job queue in partitions and lsurm dispatched them yo nodes when the requested resource - CPUs memory, GPUS are available. 

Spack documentation: Spack is a package manager built for scientific software. It handles the combiniatorial compelxity of building the same library against different compilers and MPI version. For example when some groups need CUDA 11 and others need CUDA 12. When you install with Spack it can auto generaye lmod modules so users just module load like normal.



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
