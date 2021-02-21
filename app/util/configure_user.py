#! /usr/bin/env python3

import os
import configparser
import logging


def prompt_user_workspace(home):
    default_workspace = os.path.join(home, "projects")
    workspace_path = input(f"[INFO]: workspace path [{default_workspace}]?") or default_workspace

    if not os.path.exists(workspace_path):
        os.mkdir(workspace_path)

    return workspace_path


def prompt_user_name():
    default_username = os.environ["USER"];
    return input(f"[INFO]: docker image username [{default_username}]?") or default_username


if __name__ == "__main__":
    home = os.environ["HOME"]

    config_dir = os.path.join(home, ".pro")
    config_path = os.path.join(config_dir, "config")
    if not os.path.exists(config_path):

        if not os.path.exists(config_dir):
            os.mkdir(config_dir)

        config = configparser.ConfigParser()

        config["default"] = {"workspace": prompt_user_workspace(home),
                             "username": prompt_user_name()}

        with open(config_path, 'w') as configfile:
            config.write(configfile)
