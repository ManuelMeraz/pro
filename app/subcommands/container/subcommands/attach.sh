#! /bin/bash

__pro_subcommand_container_subcommand_attach() {
    project_name="$(${root_lib_dir}/pycommon/current_project.py 'set' 'name')" || __pro_error_exit "current project is not set" || return 1
    container_name="${project_name}-docker"

    if ! docker ps | grep -i "${container_name}" &> /dev/null; then
        __pro_log_error "The container ${container_name} is currently not running. Nothing to attach to"
        return 1
    fi

    "${root_lib_dir}/docker/attach_image.sh"
}
