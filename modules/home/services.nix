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
    sway-audio-idle.enable = true;

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

      settings = {
        default-timeout = 5000;
      };
    };
  };
}
