{
  self,
  pkgs,
  username,
  ...
}:

{
  imports = [ (self + /modules/features/lanzaboote.nix) ];

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  programs.uwsm.waylandCompositors.sway.extraArgs = [ "--unsupported-gpu" ];

  boot.kernelParams = [
    "drm.edid_firmware=DP-2:edid/lg.bin"
    "video=DP-2:d"
    "video=HDMI-A-1:e"
  ];

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
    useDHCP = false;
    networkmanager.enable = false;
    wireless.iwd.enable = true;
  };

  systemd.network = {
    enable = true;

    networks."25-wireless" = {
      name = "wlan0";
      address = [ "192.168.3.171/24" ];
      gateway = [ "192.168.3.1" ];
      networkConfig.DHCP = false;
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

  users.users.${username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINy5U5i0X7MxWivscSC289DyUil96Gbdekwfei56ckZ1 u0_a468"
  ];
}
