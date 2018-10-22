# Install fisher
if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

# Basic themes
# https://github.com/oh-my-fish/theme-bobthefish
set -g theme_powerline_fonts no
set -g theme_nerd_fonts no

# iTerm shell itegration
source ~/.shared/iterm-integration.fish
