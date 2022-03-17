# Dotfiles

This repo houses my personal [dotfiles](https://dotfiles.github.io/).

> Note that this project is tailored for my own specific use-cases, and I've not
> tested much outside of my own personal use. Use at your own risk. 🚧

## My Setup

I'm not sure how common my setup is but I do development work on either my
Macbook Pro or my Windows desktop as the host, with a Linux development VM
running inside of them. It's evolved from the fact that:

- I genuinely like Apple hardware and the polish of its OS. I'm also locked in
  to their ecosystem via iPhone, iMessage, etc.
- I have a beefy Windows desktop that's mostly for gaming that I do occasional
  development work on. I've tried multiple times to convert to running Linux
  directly, but I got tired of fighting the GPU drivers and poor support for
  most of the games I play.
- I prefer Linux as the OS for development work - I find that running it in a VM
  is plenty fast enough, and it's easy to share commonality with both my MacOS
  and Windows machines.

So this `dotfile` project is my own attempt to help myself bootstrap and
reconcile changes my cross platform development environment across MacOS,
Windows, and Linux.

## Feature Highlights

- Development dependencies managed via [Nix](https://nixos.org/) and
  [Nix Darwin](https://github.com/LnL7/nix-darwin).
- Home directory symlinks managed via
  [Stow](https://www.gnu.org/software/stow/).
- TBD.

## Thanks

Most of the setup have come from helpful articles and other dotfiles.

- [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
- [Zach Holman's dotfiles](https://github.com/holman/dotfiles)
- [Gary Bernhardt's dotfiles](https://github.com/garybernhardt/dotfiles)
