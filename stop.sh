#!/bin/bash
docker compose stop
sudo git add .
sudo git commit -m "Sync changes"
sudo git push
