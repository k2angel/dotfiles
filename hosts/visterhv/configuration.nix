{ inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    ./hardware-configuration.nix
    ../../modules/system
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  fileSystems = {
    "/".options = [ "noatime" "compress=zstd" ];
    "/home".options = [ "noatime" "compress=zstd" ];
    "/nix".options = [ "noatime" "compress=zstd" ];
  };
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4*1024;
  }];

  environment.systemPackages = [
    pkgs.sbctl
  ];
}

