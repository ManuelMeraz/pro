#! /bin/bash

__pro_subcommand_cd() {
    __pro_log_debug "pro subcommand cd"
    project_path="$(${project_dir}/pycommon/current_project.py 'cd' path)" || __pro_error_exit "$LINENO" "Attempted to get the current project path but failed."
    cd "${project_path}" || return 1
}
