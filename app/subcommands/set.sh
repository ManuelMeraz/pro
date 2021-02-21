#! /bin/bash

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# check if defaults exists, if not create

__pro_subcommand_set() {
    __pro_log_debug "sub command set"

    ${project_dir}/pycommon/set_project.py "$@" || __pro_error_exit "$LINENO" "Attempted to set project."
}
