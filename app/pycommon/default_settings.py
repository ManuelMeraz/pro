#! /usr/bin/env python3

import os

class Setting:
    def __init__(self, value, desc):
        self.value = value
        self.desc = desc

DEFAULT_SETTINGS = {
    "workspace" : Setting(os.environ["HOME"], desc="Workspace Path"),
    "username" : Setting(os.environ["USER"], desc="Docker container username"),
    "image" : Setting("ubuntu:20.04", desc="Default docker image")
}

def prompt_user(setting: Setting):
    user_value = input(f"[INFO][configure]: {setting.desc} [{setting.value}]?") or setting.value

    if os.path.isfile(user_value) or os.path.isdir(user_value):
        user_value = os.path.expanduser(user_value)

    return user_value

if __name__ == "__main__":
    print("testing module")
    for setting_name, setting in DEFAULT_SETTINGS.items():
        value = prompt_user(setting)
        print(f"value is {value}")
