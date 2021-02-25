#! /usr/bin/env python3

import os
import argparse

class Setting:
    def __init__(self, value, desc):
        self.value = value
        self.desc = desc

DEFAULT_SETTINGS = {
    "workspace" : Setting(os.environ["HOME"], desc="Workspace Path"),
    "username" : Setting(os.environ["USER"], desc="Docker container username"),
    "image" : Setting("ubuntu:20.04", desc="Default docker image"),
}

def prompt_user(setting: Setting):
    user_value = input(f"[INFO][configure]: {setting.desc} [{setting.value}]?") or setting.value

    if os.path.isfile(user_value) or os.path.isdir(user_value):
        user_value = os.path.expanduser(user_value)

    return user_value

if __name__ == "__main__":

    def test_default_settings():
        print("testing module")
        for setting_name, setting in DEFAULT_SETTINGS.items():
            value = prompt_user(setting)
            print(f"value is {value}")


    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--print-defaults",
        action="store_true",
        default=False,
        help="Print default settings to be used for help by the config.sh subcommand"
    )

    args = parser.parse_args()

    if args.print_defaults:
        print("default settings:")
        for name, setting in DEFAULT_SETTINGS.items():
            print(f"  {name:<12} = {setting.value:<12}    {setting.desc:<12}")
    else:
        test_default_settings()
