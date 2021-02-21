#!/usr/bin/env bash

set -o nounset
set -o errexit

# This script will start the docker image and create a docker container
# process that may be attached to. After this script use the bash.sh script
# to attach to the container.

# read the default options
this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
project_dir="${this_dir}/.."

source ${project_dir}/common/log.sh

repo="$(${project_dir}/pycommon/current_project.py 'set' 'image')"
project_name="$(${project_dir}/pycommon/current_project.py 'set' 'name')"
image_name="${project_name}-docker"

__pro_log_info "Cleaning up existing ${image_name} containers..."
docker stop ${image_name} &> /dev/null || true
docker rm   ${image_name} &> /dev/null || true

__pro_log_info "Running ${image_name}..."
docker run --privileged -d \
    -e "DISPLAY=unix$DISPLAY" -v "/tmp/.X11-unix:/tmp/.X11-unix:rw"  -v "/tmp:/tmp:rw" -v "/dev:/dev:rw" \
    -h ${image_name} \
    -v "$HOME:$HOME:rw" \
    -v "/opt:/opt:rw" \
    -d -it \
    --ipc=host --network=host \
    --name ${image_name} ${repo}

docker exec ${image_name} sh -c "echo 127.0.0.1 ${image_name} >> /etc/hosts"

#${this_dir}/attach_image.sh
