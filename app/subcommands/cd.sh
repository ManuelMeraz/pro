#! /bin/bash

__pro_subcommand_cd() {
    __pro_log_debug "pro subcommand cd"

    project_path="$(${project_dir}/pycommon/current_project.py 'cd' path)" || __pro_error_exit "$LINENO" "Failed to get project path." || return 1
    cd "${project_path}" || __pro_error_exit "$LINENO" "Failed to cd to project after current project path." || return 1
}
