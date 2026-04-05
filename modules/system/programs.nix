{ pkgs, username, ... }:

{
  programs = {
    kdeconnect.enable = true;
    zsh.enable = true;

    nh = {
      enable = true;
      clean.enable = true;
      flake = "/home/${username}/nixos";
    };

    sway = {
      enable = true;

      extraPackages = with pkgs; [
        i3status
        grim
        swaylock
        swaybg
      ];
    };

    uwsm = {
      enable = true;

      waylandCompositors = {
        sway = {
          prettyName = "Sway";
          comment = "Sway compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/sway";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    nix-output-monitor
    wl-clipboard
    libnotify
    grim
    wmenu
  ];
}
