{ lib, pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = lib.mkForce false;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
