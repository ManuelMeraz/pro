#! /bin/bash

project_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source "${project_dir}/common/log.sh" || return 1
source "${project_dir}/common/clean_up.sh" || return 1
source "${project_dir}/common/error_exit.sh" || return 1

source "${project_dir}/subcommands/set.sh" || __pro_error_exit "$LINENO" 
source "${project_dir}/subcommands/attach.sh" || __pro_error_exit "$LINENO" 
source "${project_dir}/subcommands/cd.sh" || __pro_error_exit "$LINENO" 
source "${project_dir}/subcommands/start.sh" || __pro_error_exit "$LINENO" 
source "${project_dir}/subcommands/stop.sh" || __pro_error_exit "$LINENO" 

__pro_usage () {
    echo "unknown command: $*"
    echo "usage: script set|attach|cd|start|stop ARGUMENTS"
}

__pro_set () {
    shift
    __pro_subcommand_set "$@"
}

__pro_attach () {
    shift
    __pro_subcommand_attach "$@"
}

__pro_cd() {
    shift
    __pro_subcommand_cd "$@"
}

__pro_start () {
    shift
    __pro_subcommand_start "$@"
}

__pro_stop () {
    shift
    __pro_subcommand_stop "$@"
}


# Associative array where we specify available entry points
declare -A __PRO_SUBCOMMANDS=(
    [main]=__pro_usage
    [set]=__pro_set
    [attach]=__pro_attach
    [start]=__pro_start
    [stop]=__pro_stop
    [cd]=__pro_cd
)

pro() {
    if [[ -d $HOME/.pro ]]; then
        # Magic line that makes it all working
        "${__PRO_SUBCOMMANDS[${1:-main}]:-${__PRO_SUBCOMMANDS[main]}}" "$@" 
    else
        __pro_log_info "First time running pro."
        "${project_dir}"/pycommon/configure_defaults.py
    fi

}
