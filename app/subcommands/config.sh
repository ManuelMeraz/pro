#! /bin/bash

__pro_subcommand_config() {


    ################################## options #######################################
    force=false
    ##################################################################################

    POSITIONAL=()
    while [[ $# -gt 0 ]]
    do
    key="$1"

    case $key in
        -h|--help)
        shift # shift flag

        ##################################### help ########################################
        echo "usage: pro config [<options>] [<setting>=<value>...]"
        echo 
        echo "This subcommand will configure the global configuration for pro. pro"
        echo "needs to be configured before using any other subcommands."
        echo
        echo "arguments:"
        echo "  <setting>=<value>... These values will be updated without prompting."
        echo
        echo "options:"
        echo "  -f|--force           Reconfigure pro after it has already been configured"
        echo "  -n|--no-prompt       Apply any direct updates. Do not prompt for any settings."
        echo "  -h|--help            Show this help"
        echo
        python3 "${root_lib_dir}"/pycommon/default_settings.py --print-defaults

        return 0
        ##################################################################################

        ;;
        -f|--force)
        shift # shift flag

        #################################### force #######################################
        force=true
        ##################################################################################

        ;;
        -n|--no-prompt)
        shift # shift flag

        #################################### force #######################################
        flags="${flags} --no-prompt"
        ##################################################################################

        ;;
        *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
    done
    set -- "${POSITIONAL[@]}" # restore positional parameters

    ########################### config subcommand ###############################
    if [[ -d $HOME/.pro ]] && [[ "${force}" = false ]]; then
        __pro_log_info "pro is already configured."
    elif [[ -z ${POSITIONAL} ]]; then
        python3 "${root_lib_dir}"/pycommon/configure_defaults.py ${flags}
    else
        python3 "${root_lib_dir}"/pycommon/configure_defaults.py ${flags} --update "${POSITIONAL[@]}"
    fi
    ############################################################################
}
