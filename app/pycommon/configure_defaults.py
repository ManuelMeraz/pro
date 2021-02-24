#! /usr/bin/env python3

import logging
from logging_utils import Logger

import os
import configparser
import argparse

from default_settings import DEFAULT_SETTINGS, prompt_user, Setting

def update_config_with_passed_in_options(config_in_making, passed_in_key_pairs):
    for k, v in passed_in_key_pairs.items():
        try:
            DEFAULT_SETTINGS.pop(k)
            config[k] = v
        except KeyError:
            print("[WARNING]: {k} is not a valid option. Ignoring.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--set",
			    metavar="KEY=VALUE",
			    nargs='+',
			    help="Set a number of key-value pairs "
				 "(do not put spaces before or after the = sign). "
				 "If a value contains spaces, you should define "
				 "it with double quotes: "
				 'foo="this is a sentence". Note that '
				 "values are always treated as strings.")
    args = parser.parse_args()

    logger = Logger(level=logging.INFO, subcommand="configure")
    logging.info("Configuring defaults...")

    home = os.environ["HOME"]
    config_dir = os.path.join(home, ".pro")
    config_path = os.path.join(config_dir, "config")
    config = configparser.ConfigParser()

    passed_in_options = {}
    if args.set is not None:
        passed_in_options = dict(map(lambda k_v:k_v.split("="), args.set))

    config_being_made = {}

    if not os.path.exists(config_path):
        print("a")
        if not os.path.exists(config_dir):
            os.mkdir(config_dir)

        user_settings = {}
        update_config_with_passed_in_options(user_settings, passed_in_options)
        user_settings= {name: prompt_user(setting) for name, setting in DEFAULT_SETTINGS.items()}
        config["settings"] = user_settings

    else:
        print("b")
        config.read(config_path)
        settings = DEFAULT_SETTINGS

        user_settings = config["settings"]
        settings = {name: Setting(user_settings[name], setting.desc) for name, setting in settings.items()}

        update_config_with_passed_in_options(user_settings, passed_in_options)

        user_settings = {name: prompt_user(setting) for name, setting in settings.items()}
        config["settings"] = user_settings


    with open(config_path, 'w') as configfile:
        config.write(configfile)

    logging.info(f"{config_path} created!")
