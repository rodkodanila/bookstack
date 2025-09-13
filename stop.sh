#!/bin/bash
docker compose stop
sudo git add .
git commit -m "Sync changes"
git push
