# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *)   return ;;
esac

# Section 01
# ----------
# Setup bash-it

# https://github.com/Bash-it/bash-it
export BASH_IT="${HOME}/.bash_it"

# Lock and load a custom theme file.
# location /.bash_it/themes/
export BASH_IT_THEME="newin"
export THEME_SHOW_CLOCK_CHAR=false
export THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%Y-%m-%d"}

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
export SCM_GIT_SHOW_MINIMAL_INFO=true
export SCM_GIT_SHOW_DETAILS=false

# Set Xterm/screen/Tmux title with only a short hostname.
export SHORT_HOSTNAME=$(hostname -s)
# Set Xterm/screen/Tmux title with only a short username.
export SHORT_USER="${USER:0:5}"
# Set Xterm/screen/Tmux title with shortened command and directory.
export SHORT_TERM_LINE=true

# Load bash-it
source "$BASH_IT"/bash_it.sh

# Section 02
# ----------
# Common setup

# Display an intro ascii art
echo "                  "
echo "  .-------.       "
echo "  |  Hi   |       "
echo "  '-------'       "
echo "      ^      (\_/)"
echo "      '----- (O.o)"
echo "             (> <)"
echo "                  "

# Load bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] &&
  . "/usr/local/etc/profile.d/bash_completion.sh"

# Create some aliases
alias dc="docker-compose"
# Output color listing directories
alias ls="ls -G"
alias ks="exa -l"
# Change rg defaults
alias rg="rg --hidden --glob '!.git'"
alias vmrun="/Applications/VMware\ Fusion.app/Contents/Library/vmrun"

# Section 03
# ----------
# Setup PATH alterting tools

# Add relevant dirs to path
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.poetry/bin:$PATH

# Initialize pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# Make brew play nice with pyenv
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"

# Initialize nix
# . "$HOME/.nix-profile/etc/profile.d/nix.sh"

# Initialize rust
[[ -r "$HOME/.cargo" ]] && . "$HOME/.cargo/env"

# Section 04
# ----------
# Setup other tools

# Initialize z
eval "$(fasd --init auto)"

# Initialize direnv
eval "$(direnv hook bash)"

# Setup Go
export GOPATH="$HOME/go"
# https://github.com/apex/apex/issues/426#issuecomment-290307874
export AWS_SDK_LOAD_CONFIG=true

# Load google cloud sdk
[[ -r "$HOME/google-cloud-sdk/path.bash.inc" ]] &&
  . "$HOME/google-cloud-sdk/path.bash.inc"
[[ -r "$HOME/google-cloud-sdk/completion.bash.inc" ]] &&
  . "$HOME/google-cloud-sdk/completion.bash.inc"

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
