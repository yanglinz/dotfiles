import requests


class JenkinsConfig:
    BASE_URL = "https://jenkins-2.addepar.com/"
    DEFAULT_USER = "yanglin.zhao"


def get_user_comet_builds():
    url = f"{JenkinsConfig.BASE_URL}/view/URO/job/COMET/job/Build-and-Deploy-AMP-Services-Comet/buildHistory/ajax/api/json?search={JenkinsConfig.DEFAULT_USER}"
    resp = requests.get(url)
    return resp.text


if __name__ == "__main__":
    response = get_user_comet_builds()
    print(response)
