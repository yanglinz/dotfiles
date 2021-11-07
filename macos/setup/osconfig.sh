#!/usr/bin/env bash

# Taken mostly as-is from https://github.com/mathiasbynens/dotfiles/blob/master/.macos

function setup_osx() {
  # Close any open System Preferences panes, to prevent them from overriding
  # settings we’re about to change
  osascript -e 'tell application "System Preferences" to quit'

  # Ask for the administrator password upfront
  sudo -v

  # Keep-alive: update existing `sudo` time stamp until `.macos` has finished
  # while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

  # Always show scrollbars
  defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
  # Possible values: `WhenScrolling`, `Automatic` and `Always`

  # Disable the sound effects on boot
  sudo nvram SystemAudioVolume=" "

  # Restart automatically if the computer freezes
  sudo systemsetup -setrestartfreeze on

  # Allow application from unidentified developers
  spctl --master-disable

  # Set dock icon sizes
  defaults write com.apple.dock magnification -bool true
  defaults write com.apple.dock tilesize -int 36
  defaults write com.apple.dock largesize -int 64

  # Autohide the dock
  defaults write com.apple.dock autohide -bool true

  # Set Dock to add transparency to hidden apps
  defaults write com.apple.dock showhidden -bool true

  # Minimize applications to its icon
  defaults write com.apple.dock minimize-to-application -bool true

  # Don’t show recent applications in Dock
  defaults write com.apple.dock show-recents -bool false

  # Disable dashboard
  defaults write com.apple.dashboard mcx-disabled -bool true

  # Kill affected applications
  affected_apps=(
    "Address Book"
    "Calendar"
    "Contacts"
    "Dock"
    "Finder"
  )
  for app in "${affected_apps[@]}"; do
    killall "${app}" &>/dev/null
  done
}

[[ $OSTYPE == "darwin18" || $OSTYPE == "darwin19" || $OSTYPE == "darwin20" || $OSTYPE == "darwin21" ]] && setup_osx
