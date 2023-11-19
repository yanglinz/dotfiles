#!/usr/bin/env bash

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *)   return ;;
esac

# Setup starship
eval "$(starship init bash)"

# Load bash completion
# shellcheck disable=SC1091
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Create some aliases
# Output color listing directories
alias ls="ls --color=auto"
# Change rg defaults
alias rg="rg --hidden --glob '!.git'"

# Disable brew auto update
export HOMEBREW_NO_AUTO_UPDATE=1

# Add relevant dirs to path
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.bin:$PATH

# Initialize z
# shellcheck disable=SC1091
. /usr/local/etc/profile.d/z.sh

# Initialize direnv
eval "$(direnv hook bash)"

# Vim mode
set -o vi

# Setup alternative history tool
# TODO: We need fix atuin syncing issue
# eval "$(atuin init bash --disable-up-arrow)"
# export ATUIN_CONFIG_DIR="${HOME}/.atuin"
