#! /bin/bash

__pro_subcommand_cd() {
    if ! cat $HOME/.pro/config | grep current_project; then
        __pro_log_error "Current project is not set. Nothing to cd to."
        return 1
    fi

    project_path="$(${root_lib_dir}/pycommon/current_project.py 'cd' path)" || __pro_error_exit "Failed to get project path." || return 1
    cd "${project_path}" || __pro_error_exit "Failed to cd to project after current project path." || return 1
}
