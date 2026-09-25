{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.targets.genericLinux;
  wrapper = cfg.nixGL.defaultWrapper;
  enableNixGL = cfg.enable && wrapper != null;
in
{
  programs = {
    firefox.enable = lib.mkForce false;
    mpv.enable = lib.mkForce false;
    swaylock.package = null;
    vesktop.enable = lib.mkForce false;

    imv = {
      enable = lib.mkForce enableNixGL;
      package = lib.mkIf enableNixGL (config.lib.nixGL.wrap pkgs.imv);
    };

    zsh.shellAliases =
      let
        impure = lib.optionalString (wrapper == "nvidia" && enableNixGL) " --impure";
      in
      {
        nob = lib.mkForce "${pkgs.nh}/bin/nh home build --diff always${impure}";
        nos = lib.mkForce "${pkgs.nh}/bin/nh home switch --diff always${impure}";
      };
  };
}
