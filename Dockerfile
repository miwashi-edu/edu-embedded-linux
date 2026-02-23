#FROM balenalib/raspberry-pi:latest
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    sudo \
    vim \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    python3 \
    python3-pip \
    python3-dev \
    git \
    gdb \
    openssh-server \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-packages \
    RPi.GPIO \
    gpiozero

# SSH setup
RUN mkdir -p /var/run/sshd \
 && useradd -m -s /bin/bash dev \
 && echo "dev:dev" | chpasswd \
 && usermod -aG sudo dev \
 && echo "dev ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/dev \
 && chmod 0440 /etc/sudoers.d/dev \
 && sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config \
 && sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config \
 && sed -i 's@^#\?AuthorizedKeysFile .*@AuthorizedKeysFile .ssh/authorized_keys@' /etc/ssh/sshd_config

WORKDIR /workspace

EXPOSE 22
CMD ["/usr/sbin/sshd","-D","-e"]