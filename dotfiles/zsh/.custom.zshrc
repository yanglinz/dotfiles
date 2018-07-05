# oh-my-zsh themes
ZSH_THEME="robbyrussell"

# oh-my-zsh plguins
plugins=(git docker npm httpie pip pyenv)

# vi-mode
export KEYTIMEOUT=1  # reduce lag when ESC is pressed

# brew
export PATH="/usr/local/sbin:$PATH"

# travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# google cloud sdk
[ -f ~/google-cloud-sdk/path.zsh.inc ] && source ~/google-cloud-sdk/path.zsh.inc
[ -f ~/google-cloud-sdk/completion.zsh.inc ] && source ~/google-cloud-sdk/completion.zsh.inc
