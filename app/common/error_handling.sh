#! /bin/bash

# error log on command fail
error_exit() {
	line=$1
	shift 1
	__error "non zero return code from line: $line — $*"
	exit 1
}

register_handle_exit() {
    trap handle_exit 0 SIGHUP SIGINT SIGQUIT SIGABRT SIGTERM
}

register_handle_exit
