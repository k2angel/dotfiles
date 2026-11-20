{ pkgs, ... }:

{
  services = {
    udisks2.enable = true;

    kmscon = {
      enable = true;
      useXkbConfig = true;

      config = {
        dpms-timeout = 0;
        font-engine = "pango";
        font-size = 14;
        font-name = "monospace";
      };
    };

    pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;
      # jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    displayManager.tuigreet = {
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

    xserver.xkb = {
      layout = "jp";
      model = "jp106";
      options = "ctrl:nocaps";
    };
  };

  environment.systemPackages = [ pkgs.wiremix ];
}
