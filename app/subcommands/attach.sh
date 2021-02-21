#! /bin/bash

__pro_subcommand_attach() {
    this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    root_lib_dir="${this_dir}/.."
    project_name="$(${root_lib_dir}/pycommon/current_project.py 'set' 'name')"
    container_name="${project_name}-docker"

    if ! docker ps | grep -i "${container_name}" &> /dev/null; then
        __pro_log_error "The container ${container_name} is currently not running. Nothing to attach to"
        return 1
    fi

    ${root_lib_dir}/docker/attach_image.sh
}
