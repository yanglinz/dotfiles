import getpass


def get_profile():
    username = getpass.getuser()
    profile_by_user = {
        "y0z04ss": "profile:work",
        "sheep": "profile:personal"
    }
    return profile_by_user.get(username) or "profile:personal"


if __name__ == "__main__":
    print(get_profile())
