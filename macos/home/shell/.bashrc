# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *)   return ;;
esac

# Setup starship

eval "$(starship init bash)"

# Load bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] &&
  . "/usr/local/etc/profile.d/bash_completion.sh"

# Create some aliases
# Output color listing directories
alias ls="ls -G"
# Change rg defaults
alias rg="rg --hidden --glob '!.git'"

# Disable brew auto update
export HOMEBREW_NO_AUTO_UPDATE=1

# Add relevant dirs to path
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.bin:$PATH

# Initialize z
. /usr/local/etc/profile.d/z.sh

# Initialize direnv
# eval "$(direnv hook bash)"

# Vim mode
set -o vi

# Setup alternative history tool
alias hh=hstr
export HSTR_CONFIG=hicolor
shopt -s histappend
export HISTCONTROL=ignorespace
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

# If this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\e^ihstr -- \n"'; fi

# If this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
