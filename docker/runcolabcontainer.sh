#!/usr/bin/env bash

# Run container from image
#IMAGE_ID="56e9b6fa7044"
IMAGE_name=$1 #"us-docker.pkg.dev/colab-images/public/runtime" #  #"mycuda11"
PLATFORM="$(uname -m)"
echo $PLATFORM

Dataset_PATH="/home/lkk/Documents/Dataset"

HOST_PORT=127.0.0.1:9000 #9000 #10000

echo "Script executed from: ${PWD}"
BASEDIR=$(dirname $0)
echo "Script location: ${BASEDIR}"

#sudo xhost +si:localuser:root
# Map host's display socket to docker
DOCKER_ARGS+=("-v /tmp/.X11-unix:/tmp/.X11-unix")
DOCKER_ARGS+=("-e DISPLAY")
DOCKER_ARGS+=("-e NVIDIA_VISIBLE_DEVICES=all")
DOCKER_ARGS+=("-e NVIDIA_DRIVER_CAPABILITIES=all")

# docker run --runtime nvidia --network host -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix \
#     $CONTAINER_NAME \
#     /bin/bash
docker run -it --rm \
    --privileged \
    -p ${HOST_PORT}:8080 \
    ${DOCKER_ARGS[@]} \
    -v /dev/*:/dev/* \
    -v ${Dataset_PATH}:/Dataset \
    --runtime nvidia \
    $IMAGE_name