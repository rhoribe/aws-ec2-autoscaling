#!/bin/bash 
set -e

# Logs
exec > >(tee /var/log/user-data.log|logger -t user-data-extra -s 2>/dev/console) 2>&1

# Update System
sudo yum clean all
sudo yum update -y

# Install Packages
sudo yum install -y git htop vim 

# Install Docker
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on

# Install Docker compose 
sudo curl -L https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s | tr '[:upper:]' '[:lower:]')-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Site Example 
mkdir  ${service_name} &&  cd ${service_name}

cat <<EOF > docker-compose.yaml
version: '3'

services:
  nginx:
    image: nginx:latest
    container_name: ${service_name} 
    ports:
      - "80:80"
    volumes:
      - /var/www/html:/usr/share/nginx/html
    restart: always
EOF

docker-compose up -d

