#! /bin/bash

source "${subcommand_container_dir}/subcommands/attach.sh" || return 1
source "${subcommand_container_dir}/subcommands/start.sh" || return 1
source "${subcommand_container_dir}/subcommands/stop.sh" || return 1


__pro_subcommand_container_usage () {
	echo "pro container:"
	echo 
	echo "Project development container tool"
	echo
	echo "usage:"
	echo "  attach: Atach to the project container if its running."
	echo "  start: Start or restart the current project docker container."
	echo "  stop: Stop the current project container if its running."
}

__pro_subcommand_container_attach () {
    shift
    __pro_subcommand_container_subcommand_attach "$@"
}


__pro_subcommand_container_start () {
    shift
    __pro_subcommand_container_subcommand_start "$@"
}

__pro_subcommand_container_stop () {
    shift
    __pro_subcommand_container_subcommand_stop "$@"
}

# Associative array where we specify available entry points
declare -A __PRO_SUBCOMMAND_CONTAINER_SUBCOMMANDS=(
    [main]=__pro_subcommand_container_usage

    [at]=__pro_subcommand_container_attach
    [attach]=__pro_subcommand_container_attach

    [st]=__pro_subcommand_container_start
    [start]=__pro_subcommand_container_start

    [sp]=__pro_subcommand_container_stop
    [stop]=__pro_subcommand_container_stop
)

__pro_subcommand_container() {
    "${__PRO_SUBCOMMAND_CONTAINER_SUBCOMMANDS[${1:-main}]:-${__PRO_SUBCOMMAND_CONTAINER_SUBCOMMANDS[main]}}" "$@" 
}
