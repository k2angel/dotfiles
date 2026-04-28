{ config, pkgs, ... }:

{
  services = {
    kdeconnect.enable = true;
    udiskie.enable = true;

    autotiling = {
      enable = true;
      package = pkgs.autotiling-rs;
    };

    cliphist = {
      enable = true;

      extraOptions = [
        "-max-items"
        "10000"
      ];
    };

    swayidle = {
      enable = true;

      events = {
        before-sleep = "swaylock -f -c 000000";
        lock = "lock";
      };

      timeouts = [
        {
          timeout = 300;
          command = "swaylock -f -c 000000";
        }
      ];
    };

    mako = {
      enable = true;

      settings = with config.colorScheme.palette; {
        default-timeout = 5000;
        background-color = "#${base00}";
        border-color = "#${base0D}";
        text-color = "#${base05}";
        progress-color = "over #${base02}";

        "urgency=low" = {
          background-color = "#${base00}";
          border-color = "#${base03}";
          text-color = "#${base05}";
        };

        "urgency=critical" = {
          background-color = "#${base00}";
          border-color = "#${base08}";
          text-color = "#${base05}";
        };
      };
    };
  };
}
