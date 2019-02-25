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
set -g theme_display_date no

# Extra fish color options
set -g fish_color_autosuggestion green --bold
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape bryellow --bold
set -g fish_color_history_current green --bold
set -g fish_color_host green
set -g fish_color_match	--background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param	cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

# Set editor variable
set -Ux EDITOR vim

# Activate node path
if type -q node
  # Do nothing, nvm is already activated
else
  nvm use 8
end

# Add to PATH
set -x PATH /usr/local/sbin $PATH
set -x PATH $HOME/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.poetry/bin $PATH

switch "$PATH"
  # We want to make sure the brew's python is the first PATH.
  # However, we don't want it before virtual environment's PATH.
  # If Pipenv/Poetry virtualenv is already activated and in PATH
  # Avoid overriding the virtualenv PATH
  # https://github.com/sdispater/poetry/issues/497
case "*pypoetry/virtualenvs*" 
  # Poetry shell is active. Do nothing.
case "*share/virtualenvs*"
  # Pipenv shell is active. Do nothing.
case "*"
  set -x PATH /usr/local/opt/python/libexec/bin:$PATH
end

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
