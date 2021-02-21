#!/usr/bin/env bash

set -o nounset
set -o errexit

# This script logs into the current matsinking docker image
# You must have built the image first and started it

# read the default options
this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
root_lib_dir="${this_dir}/.."

source "${root_lib_dir}/common/log.sh"

project_name="$("${root_lib_dir}/pycommon/current_project.py" 'set' 'name')"
image_name="${project_name}-docker"

project_path="$("${root_lib_dir}/pycommon/current_project.py" 'set' 'path')"
docker exec -it "${image_name}" bash -c "cd ${project_path}; echo Attached to ${image_name}!;bash"
