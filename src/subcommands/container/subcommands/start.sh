#! /bin/bash

__pro_subcommand_container_subcommand_start() {
    ${root_lib_dir}/pycommon/current_project.py 'set' 'name' &> /dev/null || __pro_error_exit "Current project is not set" || return 1

    __pro_log_info "Starting docker container..."
    ${root_lib_dir}/docker/start_image.sh || __pro_error_exit "Attempted start container." || return 1
}
