#!/bin/bash

# Set up and install Docker and Docker Compose

# Docker
DOCKER_VERSION="5:20.10.23~3-0~ubuntu-"
apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
	add-apt-repository -y "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $( lsb_release -cs ) stable" && \
	apt-get install -y docker-ce=${DOCKER_VERSION}$( lsb_release -cs ) docker-ce-cli=${DOCKER_VERSION}$( lsb_release -cs ) containerd.io && \
	docker --version && \
	rm -rf /var/lib/apt/lists/*

# Docker Compose
COMPOSE_VER="2.17.2"
COMPOSE_SWITCH_VERSION="1.0.5"
dockerPluginDir=/usr/local/lib/docker/cli-plugins && \
	mkdir -p $dockerPluginDir && \
	curl -sSL "https://github.com/docker/compose/releases/download/v${COMPOSE_VER}/docker-compose-linux-$(uname -m)" -o $dockerPluginDir/docker-compose && \
	chmod +x $dockerPluginDir/docker-compose && \
	curl -fL "https://github.com/docker/compose-switch/releases/download/v${COMPOSE_SWITCH_VERSION}/docker-compose-linux-$(dpkg --print-architecture)" -o /usr/local/bin/compose-switch && \
	# Quick test of the Docker Compose install
	docker compose version && \
	chmod +x /usr/local/bin/compose-switch && \
	update-alternatives --install /usr/local/bin/docker-compose docker-compose /usr/local/bin/compose-switch 99 && \
	# Tests if docker-compose for v1 is transposed to v2
	docker-compose version
