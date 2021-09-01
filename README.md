# My Personal Dotfiles

This is my personal dotfiles for MacOS.

> Note that I've not tested much outside of my own personal use. Use at your own risk. 🚧

## Setup

Most of the initial setup is automated, with the exception of a couple of manual steps.

To get started, run the initial setup scripts.

```sh
make setup
```

Then link the dotfiles by running the [GNU Stow](https://www.gnu.org/software/stow/) commands.

```sh
make link
```

Next, we need to configure iTerm to load its default configuration from our newly linked `~/.iterm` directory.

```
Preferences -> Load preferences from custom folder or URL
```

Use the Nix managed bash.

```
chsh -s $(which bash)
```

## Thanks

Most of the setup have come from helpful articles and other dotfiles.

- [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
- [Zach Holman's dotfiles](https://github.com/holman/dotfiles)
- [Gary Bernhardt's dotfiles](https://github.com/garybernhardt/dotfiles)
