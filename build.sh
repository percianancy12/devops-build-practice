#!/bin/bash
APP_NAME="my-react-app"

echo "Building Docker image..."
docker build -t $APP_NAME:latest .