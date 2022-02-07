#! /bin/bash

if ! groups | grep docker &> /dev/null && ! hostname | grep docker &> /dev/null; then
    echo "You must have permission to execute docker. Add yourself to the docker group with the following command:"
    echo 
    echo "sudo usermod -aG docker $USER"
    echo 
    echo "Then log out and back in or restart your machine."
    return 1
fi

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
version="$(cat "${this_dir}/VERSION")"
source "${this_dir}/src/pro.sh"
