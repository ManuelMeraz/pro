#! /bin/bash

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# check if defaults exists, if not create

__pro_subcommand_set() {
    project_name=$1
    __pro_log_debug "Setting project: ${project_name}"

    ${project_dir}/pycommon/set_project.py "$@" || __pro_error_exit "$LINENO" "Attempted to set project." || return 1

    __pro_log_info "Building docker image..."
    ${project_dir}/docker/build_image.sh || __pro_error_exit "$LINENO" "Attempted build image." || return 1

    image_name="${project_name}-docker"
    __pro_log_info "Docker image ${image_name} complete."
}
