#! /usr/bin/env python3

import logging
from logging_utils import Logger

import os
import configparser
import argparse

from default_settings import DEFAULT_SETTINGS, prompt_user, Setting

def update_config_with_passed_in_options(config_in_making, passed_in_key_pairs, current_settings):
    for k, v in passed_in_key_pairs.items():
        try:
            current_settings.pop(k)
            config_in_making[k] = v
        except KeyError:
            print(f"[WARN]: {k} is not a valid option. Ignoring.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--update",
			    metavar="KEY=VALUE",
			    nargs='+',
			    help= "(do not put spaces before or after the = sign). If a value contains spaces, "
                                 'you should define it with double quotes: foo="this is a sentence". Note that '
				 "values are always treated as strings.")

    parser.add_argument(
        "--no-prompt",
        action="store_true",
        default=False,
        help="Update ~/.pro/config directly without prompting by passing in key-value pairs."
    )

    args = parser.parse_args()

    logger = Logger(level=logging.INFO, subcommand="configure")
    logging.info("Configuring settings...")

    home = os.environ["HOME"]
    config_dir = os.path.join(home, ".pro")
    config_path = os.path.join(config_dir, "config")
    config = configparser.ConfigParser()

    passed_in_options = {}
    if args.update is not None:
        passed_in_options = dict(map(lambda k_v:k_v.split("="), args.update))

    config_being_made = {}

    if not os.path.exists(config_path):
        if not os.path.exists(config_dir):
            os.mkdir(config_dir)

        user_settings = {}
        update_config_with_passed_in_options(user_settings, passed_in_options, DEFAULT_SETTINGS)

        if not args.no_prompt:
            user_settings= {name: prompt_user(setting) for name, setting in DEFAULT_SETTINGS.items()}
        else:
            for k, v in DEFAULT_SETTINGS.items():
                user_settings[k] = v.value

    else:
        config.read(config_path)
        settings = DEFAULT_SETTINGS

        user_settings = config["settings"]

        for name, setting in settings.items():
            if name in user_settings:
                settings[name].value = user_settings[name]

        update_config_with_passed_in_options(user_settings, passed_in_options, settings)

        if not args.no_prompt:
            user_settings.update({name: prompt_user(setting) for name, setting in settings.items()})

    config["settings"] = user_settings

    with open(config_path, 'w') as configfile:
        config.write(configfile)

    logging.info(f"{config_path} created!")
