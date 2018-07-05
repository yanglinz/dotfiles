# Oh-My-Zsh
ZSH_THEME="robbyrussell"

plugins=(git docker npm httpie pip pyenv)

# Vim
export KEYTIMEOUT=1  # reduce lag when ESC is pressed

# Homebrew
export PATH="/usr/local/sbin:$PATH"

# Travis
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# Google SDK
[ -f ~/google-cloud-sdk/path.zsh.inc ] && source ~/google-cloud-sdk/path.zsh.inc
[ -f ~/google-cloud-sdk/completion.zsh.inc ] && source ~/google-cloud-sdk/completion.zsh.inc
