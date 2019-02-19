#!/usr/bin/env python

import getpass

PROFILE_WORK = "profile:work"
PROFILE_PERSONAL = "profile:personal"


def get_profile():
    username = getpass.getuser()
    profile_by_user = {
        "y0z04ss": PROFILE_WORK,
        "yzhao": PROFILE_WORK,
        "sheep": PROFILE_PERSONAL,
    }
    return profile_by_user.get(username) or PROFILE_PERSONAL


if __name__ == "__main__":
    print(get_profile())
