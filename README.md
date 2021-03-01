# pro (project)
command line development environment (CLDE) for debian based systems in bash

## Subcommands

**config:** Get or set project or global settings

**checkout:** Switch projects or begin new project

**status:** Show the status of pro and the active project

**cd:** Change directories to the current project or related directories.

**container:** Various docker convenience container subcommands (attach|run|start|stop)

**build:** Build the current project

**ed:** Edit a file in the project

### Documentation

#### Config

```
usage: pro config [<options>] [<setting>=<value>...]

Configure global settings or the active project settings

arguments:
  <setting>=<value>... These values will be updated without prompting.

  -n|--no-prompt        Apply arguments without prompting.

options:
  -g|--global           Configure the global settings
  -p|--project          Configure the active project settings

defaults:
  -d|--show-defaults    Show default settings
```

#### Default Settings


| Name      | Value        | Description                                                              |
|-----------|--------------|--------------------------------------------------------------------------|
| workspace | $HOME        | The path to the workspace is the directory where your projects will live |
| image     | ubuntu:20.04 | The default docker image for development                                 |


#### Checkout

```
usage: pro co|checkout [<options>] <project>

Checkout a project and make it the the active project.

arguments:
  <project> The name of an existing directory in the configured workspace.

options:
  -n|--new-project     Checkout a new project
  -s|--stop-container  Stop the active project container before switching projects
```

#### Cd

```
usage: pro cd [<options>] [<directory>]

cd to active project directory. 

arguments:
  <directory> A directory in the project to cd to in the project.

options:
  -w|--workspace     cd to the workspace instead
  -f|--fuzz 		 Use fzf to search for a specific directory 
```

#### Container

The purpose of this docker command is to use docker containers for
developing.

**attach:** Attach to the current container

**exec:** Execute a command in the container and interact with it.

**run:** Run the container and attach.

**stop:** Stop the docker container


#### Attach
```
pro container attach [<command>] [--] <docker>...

Attach to active project docker container with an interactive bash shell

arguments:
	command A command that will be executed on login to the shell
```

#### Exec
```
pro container exec [<command>] [--] <docker>...

Execute a command in the docker container and interact with it

arguments:
  -d|--detach    Execute the command without attaching to the container
```

#### Run

```
usage: pro container run [--] <docker>...

Start the active project container. Restart if already running.
```

#### Stop
```
usage: pro container stop [<options>] [--] <docker>...

Stop the active project container

options:
  -a|--all     		   Stop all project docker containers
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
