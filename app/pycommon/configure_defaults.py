#! /usr/bin/env python3

import logging
from logging_utils import Logger

import os
import configparser


def prompt_user_workspace(default_workspace):
    workspace_path = input(f"[INFO][configure]: workspace path [{default_workspace}]?") or default_workspace
    workspace_path = os.path.expanduser(workspace_path)

    if not os.path.exists(workspace_path):
        os.mkdir(workspace_path)

    return workspace_path


def prompt_docker_image(default_docker_image):
    return input(f"[INFO][configure]: docker image [{default_docker_image}]?") or default_docker_image


def prompt_docker_user_name(default_username):
    return input(f"[INFO][configure]: docker image username [{default_username}]?") or default_username


if __name__ == "__main__":
    logger = Logger(level=logging.INFO, subcommand="configure")
    logging.info("Configuring defaults...")

    home = os.environ["HOME"]

    config_dir = os.path.join(home, ".pro")
    config_path = os.path.join(config_dir, "config")

    config = configparser.ConfigParser()
    if not os.path.exists(config_path):

        if not os.path.exists(config_dir):
            os.mkdir(config_dir)

        config["default"] = {"workspace": prompt_user_workspace(home),
                             "username": prompt_docker_user_name(os.environ["USER"]),
                             "image": prompt_docker_image("ubuntu:latest")}
    else:
        config = configparser.ConfigParser()
        config.read(config_path)

        default_options = config["default"]
        config["default"] = {"workspace": prompt_user_workspace(default_options["workspace"]),
                             "username": prompt_docker_user_name(default_options["username"]),
                             "image": prompt_docker_image(default_options["image"])}


    with open(config_path, 'w') as configfile:
        config.write(configfile)

    logging.info(f"{config_path} created!")
