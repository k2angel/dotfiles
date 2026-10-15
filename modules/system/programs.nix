{ pkgs, ... }:

{
  programs = {
    kdeconnect.enable = true;
    zsh.enable = true;

    sway = {
      enable = true;

      extraPackages = with pkgs; [
        swaylock
        swaybg
      ];
    };

    tuigreet = {
      enable = true;

      settings = {
        display.time = true;
        # session.default_session = "sway-uwsm";

        remember = {
          username = true;
          user_session = true;
        };
      };
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
