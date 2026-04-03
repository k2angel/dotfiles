{ pkgs, ... }:

{
  services = {
    kdeconnect.enable = true;

    autotiling = {
      enable = true;
      extraArgs = [ "--limit" "2" ];
    };

    cliphist = {
      enable = true;
      extraOptions = [ "max-items 1000" ];
    };

    swayidle = {
      enable = true;

      events = {
        before-sleep = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
        lock = "lock";
      };

      timeouts = [
        { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f -c 000000"; }
      ];
    };

    mako ={
      enable = true;

      settings = {
        background-color = "#282c34";
        text-color = "#abb2bf";
        border-color = "#abb2bf";
        default-timeout = 5000;
        "urgency=low" = { border-color = "#abb2bf"; };
        "urgency=normal" = { border-color = "#abb2bf"; };
        "urgency=high" = { border-color = "#abb2bf"; };
      };
    };
  };
}
