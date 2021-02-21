#! /bin/bash

__pro_subcommand_stop() {
    this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    project_dir="${this_dir}/.."
    project_name="$(${project_dir}/pycommon/current_project.py 'set' 'name')"
    container_name="${project_name}-docker"

    if ! docker ps | grep -i "${container_name}" &> /dev/null; then
        __pro_log_error "The container ${container_name} is currently not running. Nothing to stop"
        return 1
    fi

    __pro_log_info "Stopping ${container_name}..."
    docker container stop ${container_name} 1> /dev/null || __pro_error_exit "$LINENO" "Attempted to stop the container ${container_name} but failed." || return 1

}
