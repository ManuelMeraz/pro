# pro (project)
command line development environment (CLDE) for debian based systems in bash

```
pro set 

Set new project
    * check directory, if not exists ask for git repo url
    * ask for docker repo and tag
    * build custom image with username
```

```
pro config 

usage: pro config [<options>] [<setting>=<value>...]

This subcommand will configure the global configuration for pro. pro
needs to be configured before using any other subcommands.

arguments:
  <setting>=<value>... These values will be updated without prompting.

options:
  -f|--force           Reconfigure pro after it has already been configured
  -n|--no-prompt       Apply any direct updates. Do not prompt for any settings.
```

```
pro cd

cd to current project directory.
```

```
pro container start 

Start the project container. Restart if already running.
```

```
pro container stop

Stop the project container.
```

```
pro container attach 

attach to current project docker container 
```

## Dependencies

```
sudo apt install -y docker.io silversearcher-ag fzf 
sudo usermod -aG docker $USER # log in and out after this or reboot
```

## Installation

Installation will install to `/opt/pro`

```
sudo scripts/install_pro.sh
echo "[[ -d /opt/pro ]] && source /opt/pro/setup.sh" >> ~/.bashrc
source ~/.bashrc
```
