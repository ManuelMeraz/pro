#! /usr/bin/env python3

"""
This script will prompt the user for new project information. It will then look at
the ~/.pro/config file and set the current project section in that file.
"""

import logging
from logging_utils import Logger

import os
import configparser
import sys
import subprocess


def make_project_section(config, project_name):
    if not config.has_section(project_name):
        default = config["settings"]

        project_section = {
            "path": os.path.join(default["workspace"], project_name),
            "image": default["image"],
            "username": default["username"]}

        return project_section

    return config[project_name]


def prompt_user_for_project_details(project):
    image = input(f"[INFO]: docker image [{project['image']}]?") or project['image']
    username = input(f"[INFO]: docker username [{project['username']}]?") or project['username']

    project["image"] = image
    project["username"] = username

    return project


if __name__ == "__main__":
    logger = Logger(level=logging.INFO, subcommand="checkout")

    if len(sys.argv) <= 1:
        exit(1)

    # import pdb; pdb.set_trace()

    home = os.environ["HOME"]

    config_dir = os.path.join(home, ".pro")
    config_path = os.path.join(config_dir, "config")

    config = configparser.ConfigParser()
    config.read(config_path)

    project_name = sys.argv[1]

    project_section = make_project_section(config, project_name)
    if not os.path.exists(project_section["path"]):
        logging.error(f"Attempted to checkout project {project_name} but the path {project_section['path']} does not exist.")
        exit(1)

    project_section["name"] = project_name

    config[project_name] = prompt_user_for_project_details(project_section)
    config["current_project"] = config[project_name]

    with open(config_path, 'w') as configfile:
        config.write(configfile)
