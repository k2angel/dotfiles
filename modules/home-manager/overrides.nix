{ lib, pkgs, ... }:

{
  programs = {
    mpv.enable = lib.mkForce false;
    swaylock.package = null;
    zsh.shellAliases = {
      nob = lib.mkForce "${pkgs.nh}/bin/nh home build --diff always";
      nos = lib.mkForce "${pkgs.nh}/bin/nh home switch --diff always";
    };
  };

  services = {
    swayidle = {
      events.before-sleep = lib.mkForce "/usr/bin/swaylock -f";

      timeouts = lib.mkForce [
        {
          timeout = 300;
          command = "/usr/bin/swaylock -f";
        }
      ];
    };
  };
}
