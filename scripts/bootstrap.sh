#!/usr/bin/env bash

cd dotfiles
stow -t $HOME bash
stow -t $HOME fish
stow -t $HOME git
stow -t $HOME vim 
stow -t $HOME zsh 
cd -
