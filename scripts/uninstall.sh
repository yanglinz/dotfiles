#!/usr/bin/env bash

cd dotfiles
stow -t $HOME -D bash
stow -t $HOME -D fish
stow -t $HOME -D git
stow -t $HOME -D tmux
stow -t $HOME -D vim
stow -t $HOME -D zsh
cd -
