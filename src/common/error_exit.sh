__pro_error_exit() {
	__pro_log_error "$*"
    __pro_clean_up
	return 1
}
