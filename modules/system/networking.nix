{ lib, host, ... }:

{
  networking = {
    hostName = "${host}";

    nftables.enable = true;
    networkmanager.enable = lib.mkDefault true;
  };

  services = {
    firewalld = {
      enable = true;

      zones = {
        public = {
          forward = true;
          services = [
            "dhcpv6-client"
            "kdeconnect"
            "ssh"
          ];
        };

        trusted = {
          forward = true;
          interfaces = [ "tailscale0" ];
        };
      };
    };
  };
}
