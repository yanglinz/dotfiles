{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    # System dependencies
    pkgs.wget
    # Shell
    pkgs.bashInteractive
    pkgs.bash-completion
    pkgs.delta
    pkgs.direnv
    pkgs.exa
    pkgs.fasd
    pkgs.fzf
    pkgs.hstr
    pkgs.ripgrep
    # Utilities
    pkgs.dos2unix
    pkgs.jq
    pkgs.mkcert
    pkgs.nginx
    pkgs.nss
    pkgs.rlwrap
    pkgs.rsync
    pkgs.shellcheck
    pkgs.tldr
    pkgs.tree
    pkgs.tflint
    pkgs.watchman
    # Programming languages
    pkgs.deno
    pkgs.dep
    pkgs.git
    pkgs.go
    pkgs.jdk11
    pkgs.leiningen
    pkgs.perl
    pkgs.rustup
    pkgs.shfmt
    # Editors
    pkgs.neovim
    # Services
    pkgs.awscli2
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.shells = with pkgs; [ bashInteractive fish zsh ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
