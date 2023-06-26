# MacOS Setup

This document will show how to setup a full development environment starting
from a fresh install of MacOS. While the goal of a `dotfile` project _is_ to
make the process of setting up a new development environment easier, it is not
quite a one step process (yet). There are still some manual steps we have to
take during a fresh install.

## Install Xcode

We need `git` to bootstrap the project. The easiest way to get `git` is to
install `xcode` by running:

```sh
xcode-select --install
```

## Clone Repo

We can then clone our `dotfiles` repo by running:

```sh
git clone git@github.com:yanglinz/dotfiles.git
```

> NOTE: We'll need to airdrop existing `.ssh` directory's public/private keys.

## Bootstrap `dotfiles`

Once we have the project cloned, we can run kickstart the setup process by
running:

```sh
make setup
```

While this will install _most_ of our dependencies, the one key dependency we
have to install is [nix-darwin](https://github.com/LnL7/nix-darwin).

```sh
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```

Once Nix and Brew are both installed, we should have enough dependencies
installed to link the `dotfiles` repo to the `$HOME` directory by running:

```sh
make link
```

To make sure everything worked as expected, we can open a new terminal and run:

```sh
upgrade
```

> NOTE: If `nix-darwin` throws some errors about pre-existing files, we can
> simply move them via `sudo mv /etc/shells /etc/shells.back` and
> `sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.back`.

# Configure Terminal.app

Open the `Terminal.app` preference menu, and import the profile from `macos/drift/A.Personalized.terminal`. Make sure the set the newly imported profile as the default.
