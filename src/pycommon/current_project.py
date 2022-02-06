#! /usr/bin/env python3

import logging
from logging_utils import Logger

import os
import configparser
import sys
import subprocess


def make_project_section(config, project_name):
    if not config.has_section(project_name):
        default = config["default"]

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
    if len(sys.argv) <= 2:
        print("[ERROR]: Missing subcommand name and config key.")
        exit(1)

    subcommand = sys.argv[1]
    logger = Logger(level=logging.INFO, subcommand=subcommand)

    home = os.environ["HOME"]

    config_dir = os.path.join(home, ".pro")
    config_path = os.path.join(config_dir, "config")

    config = configparser.ConfigParser()
    config.read(config_path)

    if not config.has_section("current_project"):
        logging.error("Attempted to get information about the current project, but the current project is not set.")
        exit(1)

    current_project = config["current_project"]
    config_key = sys.argv[2]
    if not config.has_option("current_project", config_key):
        logging.error("Invalid option for current project.")
        print("\n[current_project]")
        for key, item in current_project.items():
            print(f"{key} = {item}")
        exit(1)

    print(current_project[config_key])
