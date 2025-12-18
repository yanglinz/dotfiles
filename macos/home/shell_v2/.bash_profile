# Zsh is our main driver, but we still need to make sure that
# the proper PATH is configured in bash for one-off tools that
# uses bash, like GitUp.

export PATH=/usr/local/sbin:$PATH
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

. "$HOME/.cargo/env"
