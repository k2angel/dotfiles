{ pkgs, ... }:

{
  programs = {
    kdeconnect.enable = true;
    zsh.enable = true;

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
}
