{
  self,
  pkgs,
  username,
  ...
}:

{
  imports = [ (self + /modules/features/bluetooth.nix) ];

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
      }
    ];
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  networking = {
    useNetworkd = false;
    wireless.iwd.enable = true;
  };

  systemd.network = {
    enable = true;

    networks."25-wireless" = {
      name = "wlan0";
      DHCP = "yes";
      dhcpV4Config.UseDNS = false;
      networkConfig.MulticastDNS = true;
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  users.users.${username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKeFnOZf13UIpO0QK2eGJoiGYPvdOUrUaiVwoTC7I4fm k2angel@archlinux"
  ];
}
