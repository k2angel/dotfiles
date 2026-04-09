{ inputs, lib, pkgs, username, ... }:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
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

  networking = {
    useDHCP = false;
    useNetworkd = true;
    networkmanager.enable = lib.mkForce false;
    wireless.iwd.enable = true;

    defaultGateway = {
      address = "192.168.3.1";
      interface = "wlan0";
    };
    nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];

    interfaces.wlan0 = {
      ipv4.addresses = [{
        address = "192.168.3.171";
        prefixLength = 24;
      }];
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  fileSystems = {
    "/".options = [ "noatime" "compress=zstd" ];
    "/home".options = [ "noatime" "compress=zstd" ];
    "/home/${username}/Desktop" = {
      device = "/mnt/arch_home/k2angel/Desktop";
      fsType = "none";
      options = [ "bind" "x-systemd.requires=/mnt/arch_home"];
    };
    "/home/${username}/Documents" = {
      device = "/mnt/arch_home/k2angel/Documents";
      fsType = "none";
      options = [ "bind" "x-systemd.requires=/mnt/arch_home"];
    };
    "/home/${username}/Downloads" = {
      device = "/mnt/arch_home/k2angel/Downloads";
      fsType = "none";
      options = [ "bind" "x-systemd.requires=/mnt/arch_home"];
    };
    "/home/${username}/Music" = {
      device = "/mnt/arch_home/k2angel/Music";
      fsType = "none";
      options = [ "bind" "x-systemd.requires=/mnt/arch_home"];
    };
    "/home/${username}/Pictures" = {
      device = "/mnt/arch_home/k2angel/Pictures";
      fsType = "none";
      options = [ "bind" "x-systemd.requires=/mnt/arch_home"];
    };
    "/home/${username}/Videos" = {
      device = "/mnt/arch_home/k2angel/Videos";
      fsType = "none";
      options = [ "bind" "x-systemd.requires=/mnt/arch_home"];
    };
    "/nix".options = [ "noatime" "compress=zstd" ];
    "/mnt/arch_home".options = [ "noatime" "compress=zstd" ];
    "/mnt/game".options = [ "noatime" "compress=zstd" ];
  };
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4*1024;
  }];

  programs.uwsm.waylandCompositors.sway.extraArgs = [ "--unsupported-gpu" ];

  environment.systemPackages = with pkgs; [
    sbctl
    polychromatic
  ];
}

