#!/usr/bin/env python3

import os
import contextlib
import subprocess
from pathlib import Path
import getpass

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
    "stow/vscode": VS_CODE_PATH,
}

personal_targets = {
    # Personal targets are an extension to source_to_targets
    # that only applies to personal profiles/machines.
    "stow/git/personal": HOME_PATH
}

work_targets = {
    # Work targets are an extension to source_to_targets
    # that only applies to work profiles/machines.
    "stow/git/work": HOME_PATH
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


def stow_target(source, target, unlink=False):
    source_path = Path.cwd().joinpath(source)
    *parent_path_parts, source_dir_name = source_path.parts
    source_parent_path = Path(*parent_path_parts)

    with working_directory(source_parent_path):
        # TODO: Tweak outputs to include more info and color
        if not unlink:
            print(f"Linking {source}")
            print(f"Linking {source_parent_path}/{source_dir_name} to {target}")
        else:
            print(f"Unlinking {source}")
            print(f"Unlinking {source_parent_path}/{source_dir_name} to {target}")

        try:
            if not unlink:
                stow_command = ["stow", "-t", target, source_dir_name]
            else:
                stow_command = ["stow", "-t", target, "-D", source_dir_name]

            subprocess.run(stow_command, capture_output=False)
        except OSError as e:
            print(e)


def link_targets():
    current_dir = Path.cwd().parts[-1]
    assert current_dir == "dotfiles"

    for source, target in get_targets().items():
        stow_target(source, target)


def unlink_targets():
    current_dir = Path.cwd().parts[-1]
    assert current_dir == "dotfiles"

    for source, target in get_targets().items():
        stow_target(source, target, unlink=True)
