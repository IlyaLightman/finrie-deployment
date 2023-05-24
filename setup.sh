#!/bin/bash

DOCKER_COMPOSE_URL="https://raw.githubusercontent.com/IlyaLightman/finrie-deployment/main/docker-compose.yml"

check_docker_installation() {
    if command -v docker &> /dev/null; then
        return 0
    else
        return 1
    fi
}

install_docker() {
    echo "Docker is not installed. Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    echo "Docker installation completed successfully."
}

download_docker_compose() {
    echo "Downloading docker-compose.yml..."
    curl -fsSL -o docker-compose.yml "${DOCKER_COMPOSE_URL}"
    echo "docker-compose.yml downloaded successfully."
}

run_application() {
    docker-compose up
}

main() {
    if ! check_docker_installation; then
        install_docker
    fi
    
    download_docker_compose
    
    run_application
}

main
