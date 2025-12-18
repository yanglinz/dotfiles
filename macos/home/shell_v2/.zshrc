# Display an intro ascii art
echo "                  "
echo "  .-------.       "
echo "  |  Hi   |       "
echo "  '-------'       "
echo "      ^      (\_/)"
echo "      '----- (O.o)"
echo "             (> <)"
echo "                  "

source ~/.dotfiles_vars

# Enable Powerlevel10k instant prompt.
# Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Show colors
export CLICOLOR=1

# Homebrew
eval "$(brew shellenv)"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Enable autocompletion
# https://github.com/Homebrew/brew/blob/master/docs/Shell-Completion.md#configuring-completions-in-zsh
autoload -Uz compinit
compinit

# Adding tools to PATH
export PATH="$PATH:$DOTFILES_SOURCE_DIR/bin"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
source "$HOME/.cargo/env"

# Docker
# Change default platform for M1 macs
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# Z command
eval "$(zoxide init zsh)"

# History search
eval "$(atuin init zsh)"

# Asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
. ~/.asdf/plugins/golang/set-env.zsh

# Ruby
export GEM_HOME="$HOME/.gem"
export PATH="$HOME/.gem/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# Make sure this is the last thing sourced in your ~/.zshrc file.
source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# SSH
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
