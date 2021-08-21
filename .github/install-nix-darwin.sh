#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Copy over default config
git clone https://github.com/LnL7/nix-darwin.git ~/.nix-defexpr/darwin
mkdir -p ~/.nixpkgs
cp ~/.nix-defexpr/darwin/modules/examples/simple.nix ~/.nixpkgs/darwin-configuration.nix

echo "foo: 1"

# Configure nix channel
nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
nix-channel --update

echo "foo: 2"

# Configure PATH
export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels:$NIX_PATH
export NIX_PATH=darwin=$HOME/.nix-defexpr/darwin:darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$NIX_PATH

echo "foo: 3"

darwin-rebuild switch

# $(nix-build '<darwin>' -A system --no-out-link)/sw/bin/darwin-rebuild build
$(nix-build '<darwin>' -A system --no-out-link)/sw/bin/darwin-rebuild switch

. /etc/static/bashrc
