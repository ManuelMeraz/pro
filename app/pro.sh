#! /bin/bash

root_lib_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source "${root_lib_dir}/common/log.sh" || return 1
source "${root_lib_dir}/common/clean_up.sh" || return 1
source "${root_lib_dir}/common/error_exit.sh" || return 1

source "${root_lib_dir}/subcommands/set.sh" || __pro_error_exit "failed source set subcommand" || return 1
source "${root_lib_dir}/subcommands/cd.sh" || __pro_error_exit "failed source cd subcommand" || return 1
source "${root_lib_dir}/subcommands/config.sh" || __pro_error_exit "failed source bash subcommand" || return 1

subcommand_container_dir="${root_lib_dir}/subcommands/container"
source "${root_lib_dir}/subcommands/container/container.sh" || __pro_error_exit "container subcommand" || return 1

__pro_config() {
    shift
    __pro_subcommand_config "$@"
}

__pro_usage() {
	echo "pro: ${version}"
	echo 
    echo "A command line development environment (CLDE) for bash and debian based systems."
	echo
	echo "usage:"
	echo "  config: configure pro"
	echo "  set <project_name>: a directory name within the workspace"
	echo "  cd: cd to the project"
	echo "  [con|container] attach|run|start|stop"
    echo
	echo "options:"
	echo "  -h|--help: show this help"
}

__pro_is_configured() {
    [[ ! -d $HOME/.pro ]] && __pro_log_error "pro is not configured. To configure please run 'pro config'." && echo && __pro_usage && return 1
    return 0
}

__pro_set() {
    if ! __pro_is_configured; then
        return 1
    fi

    shift
    if [[ -z "$1" ]]; then
        echo "pro set:"
        echo 
        echo "This subcommand will set the current project to an existing directory matching <project_name> within the workspace."
        echo
        echo "usage:"
        echo "  pro set <existing_project>"
        echo
        echo "options:"
        echo "  -h|--help: show this help"

        workspace="$HOME"
        if [[ -d $HOME/.pro ]]; then
            workspace="$(cat $HOME/.pro/config | grep -i workspace | awk -F '= ' '{print $2}')"
        fi

        echo "current workspace: ${workspace}"
        return 1
    fi

    __pro_subcommand_set "$@"
}

__pro_cd() {
    if ! __pro_is_configured; then
        return 1
    fi

    shift
    __pro_subcommand_cd "$@"
}

__pro_container() {
    if ! __pro_is_configured; then
        return 1
    fi

    shift
    __pro_subcommand_container "$@"
}


# Associative array where we specify available entry points
declare -A __PRO_SUBCOMMANDS=(
    [main]=__pro_usage
    [config]=__pro_config
    [set]=__pro_set
    [cd]=__pro_cd

    [con]=__pro_container
    [container]=__pro_container
)

pro() {
    # Magic line that makes it all working
    "${__PRO_SUBCOMMANDS[${1:-main}]:-${__PRO_SUBCOMMANDS[main]}}" "$@" 
}
