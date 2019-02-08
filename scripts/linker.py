#!/usr/bin/env python3

import os

from scripts.utils import profile

source_to_targets = {
    # This is something
    "stow/bin": "~",
    "stow/shell": "~",
}

personal_targets = {
    # This is something
    "stow/aws/personal": "~",
    "stow/git/personal": "~",
}

work_targets = {
    # This is something
    "stow/git/work": "~"
}


def link_target(source, target):
    print(source)
    print(target)
    pass


def link_targets(p=profile.get_profile()):

    all_targets = {}
    if p == profile.PROFILE_PERSONAL:
        all_targets = {**source_to_targets, **personal_targets}
    if p == profile.PROFILE_WORK:
        all_targets = {**source_to_targets, **work_targets}

    for source, target in all_targets.items():
        link_target(source, target)
