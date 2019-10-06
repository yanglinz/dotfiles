#!/usr/bin/env python3

import os
import contextlib
import subprocess
import getpass
from pathlib import Path

from termcolor import cprint

from scripts.utils import profile

WHO_AM_I = getpass.getuser()
HOME_PATH = Path.home()
VS_CODE_PATH = f"/Users/{WHO_AM_I}/Library/Application Support/Code/User"

source_to_targets = {
    # This is a mapping of directories to stow
    # The keys are directories relative to the project to
    # that will be the target for GNU Stow.
    # The values are absolute directories that GNU Stow
    # will apply the target to.
    "stow/shell": HOME_PATH,
    "stow/vim": HOME_PATH,
    "stow/git": HOME_PATH,
    "stow/vscode": VS_CODE_PATH,
}


@contextlib.contextmanager
def working_directory(path):
    prev_cwd = Path.cwd()
    os.chdir(str(path))
    try:
        yield
    finally:
        os.chdir(str(prev_cwd))


def stow_target(source, target, unlink=False):
    source_path = Path.cwd().joinpath(source)
    *parent_path_parts, source_dir_name = source_path.parts
    source_parent_path = Path(*parent_path_parts)

    with working_directory(source_parent_path):
        if not unlink:
            cprint(f"Linking {source}", "green")
        else:
            cprint(f"Unlinking {source}", "red")

        try:
            if not unlink:
                stow_command = ["stow", "-t", target, source_dir_name]
            else:
                stow_command = ["stow", "-t", target, "-D", source_dir_name]

            subprocess.run(stow_command, capture_output=False)
        except OSError as e:
            cprint(f"Failed to link {source}", "red")
            print(e)


def ensure_cwd():
    current_dir = str(Path.cwd())
    dir_names = set(os.listdir(path=current_dir))
    required_names = {
        "scripts",
        "stow",
        "sync-root",
        "sync-home",
        "Makefile",
        "Pipfile",
        "cli.py",
    }
    assert dir_names & (required_names) == required_names, "Must be in dotfile root dir"


def link_targets():
    ensure_cwd()
    for source, target in source_to_targets.items():
        stow_target(source, target)


def unlink_targets():
    ensure_cwd()
    for source, target in source_to_targets.items():
        stow_target(source, target, unlink=True)
