{
  config,
  lib,
  pkgs,
  ...
}:

let
  wrapper = config.targets.genericLinux.nixGL.defaultWrapper;
in
{
  programs = {
    firefox.enable = lib.mkForce false;
    mpv.enable = lib.mkForce false;
    swaylock.package = null;
    vesktop.enable = lib.mkForce false;

    zsh.shellAliases =
      let
        impure = lib.optionalString (wrapper == "nvidia") " --impure";
      in
      {
        nob = lib.mkForce "${pkgs.nh}/bin/nh home build --diff always${impure}";
        nos = lib.mkForce "${pkgs.nh}/bin/nh home switch --diff always${impure}";
      };
  };
}
