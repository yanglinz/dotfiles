# oh-my-zsh themes
ZSH_THEME="robbyrussell"

# oh-my-zsh plguins
plugins=(git docker npm httpie pip pyenv)

# vi-mode
export KEYTIMEOUT=1  # reduce lag when ESC is pressed

# brew
export PATH="/usr/local/sbin:$PATH"

# travis gem
[ -f /Users/yzhao/.travis/travis.sh ] && source /Users/yzhao/.travis/travis.sh

# google cloud sdk
if [ -f '/Users/yzhao/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/yzhao/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/yzhao/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/yzhao/google-cloud-sdk/completion.zsh.inc'; fi
