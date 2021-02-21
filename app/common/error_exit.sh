__pro_error_exit() {
	line=$1
	shift 1
	__pro_log_error "non zero return code from line: $line - $*"
    __pro_clean_up
	return 1
}
