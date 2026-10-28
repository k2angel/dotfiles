{
  config,
  lib,
  pkgs,
  isNixOS,
  ...
}:

{
  services = {
    playerctld.enable = true;
    polkit-gnome.enable = true;
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

    swayidle =
      let
        swaylock = if isNixOS then lib.getExe pkgs.swaylock else "/usr/bin/swaylock";
        swaymsg = if isNixOS then lib.getExe' pkgs.sway "swaymsg" else "/usr/bin/swaymsg";
      in
      {
        enable = true;

        events = {
          before-sleep = "${swaylock} -f";
          lock = "lock";
        };

        timeouts = [
          {
            timeout = 300;
            command = "${swaylock} -f";
          }
          {
            timeout = 600;
            command = "${swaymsg} \"output * power off\"";
            resumeCommand = "${swaymsg} \"output * power on\"";
          }
        ];
      };

    mako = {
      enable = true;

      settings = with config.scheme.withHashtag; {
        default-timeout = 5000;
        background-color = base00;
        border-color = base0D;
        text-color = base05;
        progress-color = "over ${base02}";

        "urgency=low" = {
          background-color = base00;
          border-color = base03;
          text-color = base05;
        };

        "urgency=critical" = {
          background-color = base00;
          border-color = base08;
          text-color = base05;
        };
      };
    };
  };
}
