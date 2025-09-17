#!/bin/bash
ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
  sudo docker build --platform=linux/arm64  -t solidnerd/bookstack:25.7.2 ./docker-bookstack/ 
else
  sudo docker build --platform=linux/amd64  -t solidnerd/bookstack:25.7.2 ./docker-bookstack/ 
fi
sudo chmod 777 -R ./
sudo docker compose up -d 

