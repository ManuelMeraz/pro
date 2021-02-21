#! /usr/bin/env python3

import logging
from logging_utils import Logger

import os
import configparser


def prompt_user_workspace(home):
    default_workspace = os.path.join(home, "projects")
    workspace_path = input(f"[INFO][configure]: workspace path [{default_workspace}]?") or default_workspace

    if not os.path.exists(workspace_path):
        os.mkdir(workspace_path)

    return workspace_path


def prompt_docker_image():
    default_docker_image = "ubuntu:latest";
    return input(f"[INFO][configure]: docker image [{default_docker_image}]?") or default_docker_image


def prompt_docker_user_name():
    default_username = os.environ["USER"];
    return input(f"[INFO][configure]: docker image username [{default_username}]?") or default_username


if __name__ == "__main__":
    logger = Logger(level=logging.INFO, subcommand="configure")
    logging.info("Configuring defaults...")

    home = os.environ["HOME"]

    config_dir = os.path.join(home, ".pro")
    config_path = os.path.join(config_dir, "config")

    if not os.path.exists(config_dir):
        os.mkdir(config_dir)

    config = configparser.ConfigParser()

    config["default"] = {"workspace": prompt_user_workspace(home),
                         "username": prompt_docker_user_name(),
                         "image": prompt_docker_image()}

    with open(config_path, 'w') as configfile:
        config.write(configfile)

    logging.info(f"{config_path} created!")
