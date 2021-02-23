#! /bin/bash

__pro_subcommand_config() {

    POSITIONAL=()
    while [[ $# -gt 0 ]]
    do
    key="$1"


    ################################## options #######################################
    force=false
    ##################################################################################

    case $key in
        -h|--help)
        shift # past argument
        shift # past value

        ##################################### help ########################################
        echo "pro config:"
        echo 
        echo "This subcommand will configure the global configuration for pro. The project"
        echo "needs to be configured at least before using any other subcommands. "
        echo
        echo "Pairs may be passed in with a '=' to skip the prompt for that setting."
        echo
        echo "usage:"
        echo "  pro config"
        echo "  pro config workspace=/home/bob/projects image=ubuntu:20.04"
        echo
        echo "options:"
        echo "  -h|--help: show this help"
        echo "  -f|--force: reconfigure pro after it has already been configured"

        return 0
        ##################################################################################

        ;;
        -f|--force)
        shift # past argument
        shift # past value

        #################################### force #######################################
        force=true
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
    if [[ -d $HOME/.pro ]] && [[ ! ${force} ]]; then
        __pro_log_info "pro is already configured."
    else
        "${root_lib_dir}"/pycommon/configure_defaults.py
    fi
    ############################################################################

}
