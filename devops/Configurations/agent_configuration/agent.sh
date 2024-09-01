#!/bin/bash
# Installs docker and adds curr user to docker group + enables docker service.
# Works on ubuntu 20.04
# scp -i ~/ssh-key-pair.pem jenkins-compose.yml ubuntu@13.38.124.255:~
# jenkins-compose.yml
sudo apt update -y
sudo apt install -y docker.io docker-compose openjdk-17-jre-headless
sudo usermod -aG docker $USER
sudo systemctl enable docker

# Install aws-cli
sudo apt -y install unzip curl
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip
rm -rf aws

# Install kubectl
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -y
sudo apt-get install -y  kubectl
