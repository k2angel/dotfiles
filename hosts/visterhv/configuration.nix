{
  inputs,
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  programs.uwsm.waylandCompositors.sway.extraArgs = [ "--unsupported-gpu" ];

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

    display.edid.packages = [
      (pkgs.runCommand "lg-edid" { } ''
        mkdir -p $out/lib/firmware/edid
        cp "${./edid/lg.bin}" $out/lib/firmware/edid/lg.bin
      '')
    ];

    openrazer = {
      enable = true;
      users = [ "${username}" ];
    };
  };

  networking = {
    useNetworkd = true;
    networkmanager.enable = false;
    wireless.iwd.enable = true;

    defaultGateway = {
      address = "192.168.3.1";
      interface = "wlan0";
    };

    interfaces.wlan0 = {
      ipv4.addresses = [
        {
          address = "192.168.3.171";
          prefixLength = 24;
        }
      ];
    };
  };

  services = {
    blocky.settings.connectIPVersion = "v4";

    firewalld.zones = {
      home = {
        forward = true;

        sources = [
          { mac = "94:45:60:13:b6:aa"; }
        ];

        services = [
          "dhcpv6-client"
          "kdeconnect"
          "ssh"
          "steam-streaming"
        ];

        ports = [
          {
            port = 5082;
            protocol = "tcp";
          }
          {
            port = 8096;
            protocol = "tcp";
          }
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
