#!/usr/bin/sh

docker build -t pieces-main-api ../../backend/services/main-api/
docker tag pieces-main-api:latest localhost:5000/pieces-main-api
docker push localhost:5000/pieces-main-api:latest
