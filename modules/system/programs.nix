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
        # session.default_session = "sway-uwsm";

        display = {
          show_time = true;
          time_format = "%Y-%m-%d %H:%M:%S";
        };

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
