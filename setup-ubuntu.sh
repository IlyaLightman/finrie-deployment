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
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    echo "Docker installation completed successfully."
}

install_docker_compose() {
    echo "Docker Compose is not installed. Installing Docker Compose..."
    sudo curl -fsSL -o /usr/local/bin/docker-compose https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose installation completed successfully."
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

    if ! command -v docker-compose &> /dev/null; then
        install_docker_compose
    fi
    
    download_docker_compose
    
    run_application

    xdg-open localhost:3000
}

open_site() {
    if which xdg-open > /dev/null
    then
        xdg-open URL
    elif which gnome-open > /dev/null
    then
        gnome-open URL
    fi
}

main
open_site
