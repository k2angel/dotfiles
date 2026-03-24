{ config, pkgs, ... }:

{
  imports = [
    ./modules/zsh/config.nix
    ./modules/nvim/config.nix
    ./modules/git.nix
  ];

  home.username = "k2angel";
  home.homeDirectory = "/home/k2angel";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    hello
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    LANG = "ja_JP.UTF-8";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
