#! /bin/bash

__pro_subcommand_container_subcommand_run() {
    project_name="$(${root_lib_dir}/pycommon/current_project.py 'set' 'name')" || __pro_error_exit "Current project is not set" || return 1
    container_name="${project_name}-docker"
}
