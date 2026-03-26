{ config, pkgs, ... }:

{
  imports = [
    ./modules/zsh/config.nix
    ./modules/nvim/config.nix
    ./modules/firefox/config.nix
    ./modules/vesktop/config.nix
    ./modules/git.nix
    ./modules/sway.nix
    ./modules/foot.nix
    ./modules/beets.nix
    ./modules/themes.nix
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
    duf
    tealdeer
    fastfetch
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc-ut
      ];
      settings = {
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "jp";
            DefaultIM = "mozc";
          };
          "Groups/0/Items/0".Name = "keyboard-jp";
          "Groups/0/Items/1".Name = "mozc";
        };
        addons = {
          classicui.globalSection.Theme = "default-dark";
        };
      };
      waylandFrontend = true;
    };
  };

  xdg.configFile."uwsm/env".text = ''
    export LANG=ja_JP.UTF-8
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
