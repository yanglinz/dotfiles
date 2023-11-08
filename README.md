# Dotfiles

This repo houses my personal [dotfiles](https://dotfiles.github.io/).

> Note that this project is tailored for my own specific use-cases, and I've not
> tested much outside of my own personal use. Use at your own risk. 🚧

## Feature Highlights

Here are some of the things that are included in these dotfiles:

- [Setup scripts](scripts/bootstrap.sh) for bootstrapping new MacOS installations.
- `$HOME` dotfiles managed via [GNU Stow](https://www.gnu.org/software/stow/).
- Global packages and applications managed via [Brew Cask](https://github.com/Homebrew/homebrew-cask).
- [Nix](https://nixos.org/) and [Nix Flakes](https://zero-to-nix.com/concepts/flakes) to manage per-project environment and tools.
- Configuration and theme for [iTerm2](https://iterm2.com/).
- Configurations for various shell related utilities like `bash`, `git`, `vim`, etc.
- One-off [`bin`](macos/home/bin/.bin) scripts.
- Configuration for VSCode, including [locally managed extensions](macos/home/vscode-extensions).

## Thanks

Most of the setup have come from helpful articles and other dotfiles.

- [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
- [Zach Holman's dotfiles](https://github.com/holman/dotfiles)
- [Gary Bernhardt's dotfiles](https://github.com/garybernhardt/dotfiles)
