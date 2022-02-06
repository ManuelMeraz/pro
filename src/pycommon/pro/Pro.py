import configparser
import os

from typing import List


class Pro:
    def __init__(self):
        home = os.environ["HOME"]

        config_dir = os.path.join(home, ".pro")
        config_path = os.path.join(config_dir, "config")

        config = configparser.ConfigParser()
        config.read(config_path)

    def is_configured(self):
        """
        Pro is configured when the default global settings for the project have been
        set by the user. The configuration process must precede beginning any new projects.
        """
        pass

    def has_active_project(self):
        """
        Pro has an active project when at least one project has been checked out.
        """
        pass

    def projects(self) -> List[str]:
        pass
