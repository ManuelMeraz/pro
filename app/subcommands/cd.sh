#! /bin/bash

__pro_subcommand_cd() {

    POSITIONAL=()
    while [[ $# -gt 0 ]]
    do
    key="$1"

    case $key in
        -w|--workspace)
        EXTENSION="$2"
        shift # past argument
        shift # past value

        workspace_path="$(cat $HOME/.pro/config | grep -i workspace | awk -F '= ' '{print $2}')"
        cd "${workspace_path}" || __pro_error_exit "Failed to cd to project after current workspace path." || return 1
        return 0

        ;;
        *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
    done
    set -- "${POSITIONAL[@]}" # restore positional parameters

    if ! cat $HOME/.pro/config | grep current_project &> /dev/null; then
        __pro_log_error "Current project is not set. Nothing to cd to."
        return 1
    fi


    project_path="$(${root_lib_dir}/pycommon/current_project.py 'cd' 'path')" || __pro_error_exit "Failed to get project path." || return 1
    cd "${project_path}" || __pro_error_exit "Failed to cd to project after current project path." || return 1
}
