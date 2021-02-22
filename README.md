# pro
command line development environment (CLDE) for debian based systems in bash

```
pro set 

Set new project
    * check directory, if not exists ask for git repo url
    * ask for docker repo and tag
    * build custom image with username
```

```
pro start 

Start the project container. Restart if already running.
```

```
pro stop

Stop the project container.
```

```
pro cd

cd to current project directory.
```

```
pro attach 

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
