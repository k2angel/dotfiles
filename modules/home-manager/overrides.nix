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
    mpv.enable = lib.mkForce false;
    swaylock.package = null;

    firefox = {
      enable = lib.mkForce enableNixGL;
      package = lib.mkIf enableNixGL (config.lib.nixGL.wrap pkgs.firefox);
    };

    imv = {
      enable = lib.mkForce enableNixGL;
      package = lib.mkIf enableNixGL (config.lib.nixGL.wrap pkgs.imv);
    };

    zsh.shellAliases =
      let
        nh = lib.getExe pkgs.nh;
        impure = lib.isBool (wrapper == "nvidia" && enableNixGL);
      in
      {
        nob = lib.mkForce "${nh} home build" + lib.optionalString impure " --impure";
        nos = lib.mkForce "${nh} home switch" + lib.optionalString impure " --impure";
      };
  };
}
