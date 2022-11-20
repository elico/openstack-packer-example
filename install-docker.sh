#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export DOCKER_COMPOSE_VERSION="2.12.1"

apt update
apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

chmod a+r /etc/apt/keyrings/docker.gpg

apt update

apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

if [ -f "docker-compose-linux-x86_64.xz" ];then
	unxz docker-compose-linux-x86_64.xz
	cp -v docker-compose-linux-x86_64 /usr/bin/docker-compose
else
	curl -SL "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64" -o /usr/bin/docker-compose
fi

chmod +x /usr/bin/docker-compose

# cleanup
apt clean
rm -rf /var/lib/apt/lists/*
