#!/usr/bin/env fish

# Install fisher
if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

# iTerm shell itegration
source ~/.iterm-integration.fish

# Set theme options
# https://github.com/oh-my-fish/theme-bobthefish
set -g theme_powerline_fonts no
set -g theme_nerd_fonts no

# Set editor variable
set -Ux EDITOR vim

# Activate node path
if type -q node
  # Do nothing, nvm is already activated
else
  use nvm
end

# Add to PATH
set -x PATH /usr/local/sbin $PATH
set -x PATH $HOME/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH

# Conditionally add to PATH
if test -d $HOME/.fastlane/bin
  set -x PATH $HOME/.fastlane/bin $PATH
end

# Setup android
set -x ANDROID_HOME $HOME/Library/Android/sdk
if test -d $ANDROID_HOME
  set -x PATH $ANDROID_HOME/platforms $PATH
  set -x PATH $ANDROID_HOME/platform-tools $PATH
  set -x PATH $ANDROID_HOME/tools $PATH
end

# Display an ascii art
echo "                  "
echo "  .-------.       "
echo "  |  Hi   |       "
echo "  '-------'       "
echo "      ^      (\_/)"
echo "      '----- (O.o)"
echo "             (> <)"
echo "                  "