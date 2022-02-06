#! /bin/bash

__pro_subcommand_container_subcommand_stop() {
    project_name="$(${root_lib_dir}/pycommon/current_project.py 'set' 'name')" || __pro_error_exit "Current project is currently not set" || return 1
    container_name="${project_name}-docker"

    if ! docker ps | grep -i "${container_name}" &> /dev/null; then
        __pro_log_error "The container ${container_name} is currently not running. Nothing to stop"
        return 1
    fi

    __pro_log_info "Stopping ${container_name}..."
    docker container stop "${container_name}" 1> /dev/null || __pro_error_exit "Attempted to stop the container ${container_name} but failed." || return 1

}
