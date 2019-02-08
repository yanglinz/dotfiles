#!/usr/bin/env python3

import os
import contextlib
import subprocess
from pathlib import Path

from scripts.utils import profile


HOME = Path.home()  # Path to ~

source_to_targets = {
    # This is something
    # Relative to project root
    # Relative absolute path
    "stow/shell": HOME,
}

personal_targets = {
    # This is something
    # "stow/aws/personal": "~",
    "stow/git/personal": HOME
}

work_targets = {
    # This is something
    "stow/git/work": HOME
}


@contextlib.contextmanager
def working_directory(path):
    prev_cwd = Path.cwd()
    os.chdir(str(path))
    try:
        yield
    finally:
        os.chdir(str(prev_cwd))


def get_targets(p=profile.get_profile()):
    all_targets = {}
    if p == profile.PROFILE_PERSONAL:
        all_targets = {**source_to_targets, **personal_targets}
    if p == profile.PROFILE_WORK:
        all_targets = {**source_to_targets, **work_targets}

    return all_targets


def link_target(source, target):
    source_path = Path.cwd().joinpath(source)
    *parent_path_parts, source_dir_name = source_path.parts
    source_parent_path = Path(*parent_path_parts)

    with working_directory(source_parent_path):
        print(f"Linking {source}")
        print(f"Linking {source_parent_path}/{source_dir_name} to {target}")
        try:
            subprocess.run(["stow", "-t", target, source_dir_name], capture_output=False)
        except OSError as e:
            print(e)


def link_targets():
    current_dir = Path.cwd().parts[-1]
    assert current_dir == "dotfiles"

    for source, target in get_targets().items():
        link_target(source, target)
