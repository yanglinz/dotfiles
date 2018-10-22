#!/usr/bin/env bash

# Initialize git submodule
git submodule init

# Setup homebrew
brew tap homebrew/bundle
brew bundle

# Install fonts
./vendor/fonts/install.sh
