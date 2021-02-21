#!/usr/bin/env bash

set -o nounset
set -o errexit

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
project_dir="${this_dir}/.."

docker_uid="$(id -u)" 
docker_gid="$(id -g)"
docker_username="$(${project_dir}/pycommon/current_project.py 'set' 'username')"
repo="$(${project_dir}/pycommon/current_project.py 'set' 'image')"
project_name="$(${project_dir}/pycommon/current_project.py 'set' 'name')"

image_name="${project_name}-docker"

docker build \
    --build-arg DOCKER_UID="${docker_uid}" \
    --build-arg DOCKER_GID="${docker_gid}" \
    --build-arg DOCKER_USERNAME="${docker_username}" \
    --build-arg REPO="${repo}" \
    -t "${image_name}" "${this_dir}"  || exit 1
