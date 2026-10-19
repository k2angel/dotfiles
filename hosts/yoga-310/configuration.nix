{
  pkgs,
  username,
  ...
}:

{
  nix = {
    distributedBuilds = true;

    settings = {
      trusted-users = [ "@wheel" ];
    };

    buildMachines = [
      {
        hostName = "builder";
        system = pkgs.stdenv.hostPlatform.system;
        protocol = "ssh-ng";
        maxJobs = 3;

        system-features = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
      }
    ];
  };

  features.bluetooth.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  networking = {
    useDHCP = false;
    useNetworkd = false;
    wireless.iwd.enable = true;
    firewall.allowedUDPPorts = [ 5353 ];
  };

  systemd.network = {
    enable = true;

    networks."25-wireless" = {
      name = "wlan0";
      dhcpV4Config.UseDNS = false;

      networkConfig = {
        DHCP = true;
        MulticastDNS = true;
      };
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  users.users.${username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINR2QeX5/nYQeKgtB7uzU6v2TUcrUXEUQE0PvuayzGV9 k2angel@visterhv"
  ];
}
