#!/usr/bin/env bash

# This script will start the docker image and create a docker container
# process that may be attached to. After this script use the bash.sh script
# to attach to the container.

# read the default options
this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${this_dir}/ms-docker-options"

echo "Cleaning up existing ${DOCKER_NAME} containers..."
docker stop ${DOCKER_NAME} || true
docker rm   ${DOCKER_NAME} || true

echo "Running ${DOCKER_NAME}..."
docker run --privileged -d \
    -e "DISPLAY=unix$DISPLAY" -v "/tmp/.X11-unix:/tmp/.X11-unix:rw"  -v "/tmp:/tmp:rw" -v "/dev:/dev:rw" \
    ${DOCKER_GPU_FLAGS} \
    -h ${DOCKER_NAME} \
    -v "$HOME:$HOME:rw" \
    ${DOCKER_RUN_EXTRA} \
    -d -p 80:80 -p 3000:3000 -p 8080:8080 -p 8081:8081 --ipc=host --network host \
    --env MATSINKING_ROOT=$MATSINKING_ROOT \
    --env DOCKER_NAME=${DOCKER_NAME} \
    --name ${DOCKER_NAME} ${DOCKER_NAME}:${TAG}

docker exec -u root ${DOCKER_NAME} sh -c "echo 127.0.0.1 ${DOCKER_NAME} >> /etc/hosts"
${this_dir}/attach_image.sh
