#!/bin/bash

APP_NAME="my-react-app"

# Stop and remove any existing container with same name
docker ps -q --filter "name=$APP_NAME" | xargs -r sudo docker stop
docker ps -aq --filter "name=$APP_NAME" | xargs -r sudo docker rm

if [ "$1" == "dev" ]; then
  echo "Starting DEV deployment on port 80..."
  sudo docker run -d --name $APP_NAME -p 80:80 $APP_NAME:latest
elif [ "$1" == "prod" ]; then
  echo "Starting PROD deployment on port 80..."
  sudo docker run -d --name $APP_NAME -p 80:80 $APP_NAME:latest
else
  echo "Usage: ./deploy.sh [dev|prod]"
  exit 1
fi