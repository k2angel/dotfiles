{ inputs, lib, pkgs, username, ... }:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    ../../modules/system
  ];

  nixpkgs.config.allowUnfree = true;

  boot = {
    loader.systemd-boot.enable = lib.mkForce false;

    kernelParams = [
      "drm.edid_firmware=DP-2:edid/lg.bin"
      "video=DP-2:d"
      "video=HDMI-A-1:e"
    ];

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  hardware = {
    graphics.enable = true;
    nvidia.open = true;

    display.edid.packages = [(
      pkgs.runCommand "lg-edid" {} ''
        mkdir -p $out/lib/firmware/edid
        cp "${./edid/lg.bin}" $out/lib/firmware/edid/lg.bin
      ''
    )];

    openrazer = {
      enable = true;
      users = [ "${username}" ];
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  fileSystems = {
    "/".options = [ "noatime" "compress=zstd" ];
    "/home".options = [ "noatime" "compress=zstd" ];
    "/nix".options = [ "noatime" "compress=zstd" ];
    "/mnt/game".options = [ "noatime" "compress=zstd" ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4*1024;
  }];

  environment.systemPackages = with pkgs; [
    sbctl
    polychromatic
  ];
}

