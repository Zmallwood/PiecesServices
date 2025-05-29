#!/usr/bin/sh

docker build -t pieces-main-api ../../backend/services/main-api/
docker tag pieces-main-api:latest localhost:5000/pieces-main-api
docker push localhost:5000/pieces-main-api:latest

docker build -t pieces-game-renderer ../../backend/services/game-renderer/
docker tag pieces-game-renderer:latest localhost:5000/pieces-game-renderer
docker push localhost:5000/pieces-game-renderer:latest

docker build -t pieces-frontend ../../frontend/
docker tag pieces-frontend:latest localhost:5000/pieces-frontend
docker push localhost:5000/pieces-frontend:latest
