{ lib, pkgs, ... }:

{
  programs = {
    mpv.enable = lib.mkForce false;
    zsh.shellAliases = {
      nob = "${pkgs.nh}/bin/nh home build --diff always";
      nos = "${pkgs.nh}/bin/nh home switch --diff always";
    };
  };

  services = {
    swayidle = {
      events.before-sleep = lib.mkForce "/usr/bin/swaylock -f -c 000000";

      timeouts = lib.mkForce [
        {
          timeout = 300;
          command = "/usr/bin/swaylock -f -c 000000";
        }
      ];
    };
  };
}
