#!/bin/bash
docker load -i images/bookstack.tar
docker load -i images/mysql.tar
docker compose up -d 

