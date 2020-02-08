# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *)   return ;;
esac

# Path to the bash it configuration
export BASH_IT="${HOME}/.bash_it"

# Lock and load a custom theme file.
# location /.bash_it/themes/
export BASH_IT_THEME="pure"
export THEME_SHOW_CLOCK_CHAR=false
export THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%Y-%m-%d"}

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
export SCM_GIT_SHOW_MINIMAL_INFO=true
export SCM_GIT_SHOW_DETAILS=false

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Will otherwise fall back on $USER.
export SHORT_USER="${USER:0:5}"

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
export SHORT_TERM_LINE=true

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load bash-it
source "$BASH_IT"/bash_it.sh

# Add to PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.poetry/bin:$PATH

# Load bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] &&
  . "/usr/local/etc/profile.d/bash_completion.sh"

# Load pyenv
eval "$(pyenv init -)"

# Load z
eval "$(fasd --init auto)"

# Load autoenv
eval "$(direnv hook bash)"

# Load hstr
alias hh=hstr
export HSTR_CONFIG=hicolor
shopt -s histappend
export HISTCONTROL=ignorespace
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

# If this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# If this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi

# Golang
export GOPATH=$HOME/go

# Output color listing directories
alias ls="ls -G"  # output color

# Make brew play nice with pyenv
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"

# Display an ascii art
echo "                  "
echo "  .-------.       "
echo "  |  Hi   |       "
echo "  '-------'       "
echo "      ^      (\_/)"
echo "      '----- (O.o)"
echo "             (> <)"
echo "                  "

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Load yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Load gogle cloud sdk
if [ -f "~/google-cloud-sdk/path.bash.inc" ]; then 
  . "~/google-cloud-sdk/path.bash.inc"
fi
if [ -f "~/google-cloud-sdk/completion.bash.inc" ]; then 
  . "//google-cloud-sdk/completion.bash.inc"
fi

# AWS
# https://github.com/apex/apex/issues/426#issuecomment-290307874
export AWS_SDK_LOAD_CONFIG=true
