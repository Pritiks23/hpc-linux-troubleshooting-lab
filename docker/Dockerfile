FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    openssh-server \
    slurm-wlm \
    build-essential \
    python3 \
    htop \
    iproute2 \
    net-tools \
    systemd \
    vim \
    curl

RUN mkdir /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
