#! /bin/bash

root_lib_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source "${root_lib_dir}/common/log.sh" || return 1
source "${root_lib_dir}/common/clean_up.sh" || return 1
source "${root_lib_dir}/common/error_exit.sh" || return 1

source "${root_lib_dir}/subcommands/set.sh" || __pro_error_exit "set subcommand" || return 1
source "${root_lib_dir}/subcommands/cd.sh" || __pro_error_exit "cd subcommand" || return 1

subcommand_container_dir="${root_lib_dir}/subcommands/container"
source "${root_lib_dir}/subcommands/container/container.sh" || __pro_error_exit "container subcommand" || return 1

__pro_usage() {
    echo "unknown command: $*"
    echo "usage: script set|cd|[con|container] ARGUMENTS"
}

__pro_set() {
    shift
    if [[ -z "$1" ]]; then
        __pro_log_info "[set] pro set takes the name of a new project"
    else
        __pro_subcommand_set "$@"
    fi
}

__pro_cd() {
    shift
    __pro_subcommand_cd "$@"
}

__pro_container() {
    shift
    __pro_subcommand_container "$@"
}


# Associative array where we specify available entry points
declare -A __PRO_SUBCOMMANDS=(
    [main]=__pro_usage
    [set]=__pro_set
    [cd]=__pro_cd
    [con]=__pro_container
    [container]=__pro_container
)

pro() {
    if [[ -d $HOME/.pro ]]; then

        # Magic line that makes it all working
        "${__PRO_SUBCOMMANDS[${1:-main}]:-${__PRO_SUBCOMMANDS[main]}}" "$@" 
    else
        __pro_log_info "First time running pro."
        "${root_lib_dir}"/pycommon/configure_defaults.py
    fi

}
