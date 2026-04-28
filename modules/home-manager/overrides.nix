{ lib, pkgs, ... }:

{
  programs = {
    mpv.enable = lib.mkForce false;
    zsh.shellAliases = {
      nob = "${pkgs.nh}/bin/nh home build --diff always";
      nos = "${pkgs.nh}/bin/nh home switch --diff always";
    };
  };
}
