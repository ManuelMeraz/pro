#! /bin/bash

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# check if defaults exists, if not create

__pro_subcommand_set() {
    project_name=$1
    __pro_log_debug "Setting project: ${project_name}"

    this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    root_lib_dir="${this_dir}/.."

    current_project_name="$(${root_lib_dir}/pycommon/current_project.py 'set' 'name')"
    container_name="${current_project_name}-docker"

    if docker ps | grep -i "${container_name}" &> /dev/null; then
        __pro_log_info "Stopping ${container_name}..."
        docker container stop "${container_name}" 1> /dev/null || __pro_error_exit "$LINENO" "Attempted to stop the container ${container_name} but failed." || return 1
        docker container prune --force 1> /dev/null || __pro_error_exit "$LINENO" "Attempted to prune containers while setting project." || return 1
    fi

    "${root_lib_dir}/pycommon/set_project.py" "$@" || __pro_error_exit "$LINENO" "Attempted to set project." || return 1

    __pro_log_info "Building docker image..."
    "${root_lib_dir}/docker/build_image.sh" || __pro_error_exit "$LINENO" "Attempted build image." || return 1

    image_name="${project_name}-docker"
    __pro_log_info "Docker image ${image_name} complete."
}
