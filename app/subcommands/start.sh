#! /bin/bash

__pro_subcommand_start() {
    __pro_log_debug "pro subcommand start"

    __pro_log_info "Starting docker container..."
    ${project_dir}/docker/start_image.sh || __pro_error_exit "$LINENO" "Attempted start container." || return 1
}
