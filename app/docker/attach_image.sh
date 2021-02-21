#!/usr/bin/env bash

# This script logs into the current matsinking docker image
# You must have built the image first and started it

# read the default options
this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${this_dir}/ms-docker-options"

docker exec -it ${DOCKER_NAME} bash -c "cd ${this_dir}; bash"
