{ inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    ./hardware-configuration.nix
    ../../modules/system
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.kernelParams = [
    "video=DP-2:d"
    "video=HDMI-A-1:e"
  ];
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

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

