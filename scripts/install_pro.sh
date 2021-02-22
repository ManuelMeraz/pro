#! /bin/bash

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

[[ ! -d /opt/pro ]] && mkdir /opt/pro || (echo "requires sudo to run this script" && exit 1)

echo "Installing to /opt/pro.."
cp -r "${this_dir}/.." /opt/pro || (echo "requires sudo to run this script" && exit 1)

user=$(whoami)
chown -R "${user}:${user}" /opt/pro
echo "Done!"

