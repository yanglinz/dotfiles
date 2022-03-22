# Dotfiles

This repo houses my personal [dotfiles](https://dotfiles.github.io/).

> Note that this project is tailored for my own specific use-cases, and I've not
> tested much outside of my own personal use. Use at your own risk. 🚧

## Feature Highlights

Here are some of the things that's taken care of by these dotfiles:

- [Setup scripts](scripts/bootstrap.sh) for bootstrapping new MacOS installations.
- Symlinks managed by [GNU Stow](https://www.gnu.org/software/stow/).
- Shell related dependencies managed via [Nix](https://nixos.org/) and
  [Nix Darwin](https://github.com/LnL7/nix-darwin).
- MacOS applications managed via [Brew Cask](https://github.com/Homebrew/homebrew-cask).
- Managed configuration and themes for [kitty terminal emulator](https://sw.kovidgoyal.net/kitty/).
- VSCode configuration and [custom extensions](macos/home/vscode-extensions).

## Thanks

Most of the setup have come from helpful articles and other dotfiles.

- [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
- [Zach Holman's dotfiles](https://github.com/holman/dotfiles)
- [Gary Bernhardt's dotfiles](https://github.com/garybernhardt/dotfiles)
