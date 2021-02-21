#!/usr/bin/env bash

set -o nounset
set -o errexit

# This script logs into the current matsinking docker image
# You must have built the image first and started it

# read the default options
this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
project_dir="${this_dir}/.."

source "${project_dir}/common/log.sh"

project_name="$("${project_dir}/pycommon/current_project.py" 'set' 'name')"
image_name="${project_name}-docker"

project_path="$("${project_dir}/pycommon/current_project.py" 'set' 'path')"
docker exec -it "${image_name}" bash -c "cd ${project_path}; bash"
