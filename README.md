# Yanglin's Dotfiles

This is my personal dotfiles for MacOS.

> Note that I've not tested much outside of my own personal use. Use at your own risk. 🚧

## Setup

Most of the initial setup is automated, with the exception of a couple of manual steps.

To get started, run the initial setup scripts.

```sh
make setup
```

Then link the dotfiles by running the stow commands.

```sh
make link
```

Next, we need to configure iTerm to load its default configuration from our newly linked `~/.iterm` directory.

```
Preferences -> Load preferenes from custom folder or URL
```

Then finally, we need to [set fish as the default shell](https://stackoverflow.com/questions/453236/how-to-set-my-default-shell-on-mac).

```sh
# Add $(which fish) to /etc/shells
sudo vim /etc/shells
```

## Thanks

Most of the setup have come from helpful articles and other dotfiles

- [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
- [Zach Holman's dotfiles](https://github.com/holman/dotfiles)
- [Gary Bernhardt's dotfiles](https://github.com/garybernhardt/dotfiles)
