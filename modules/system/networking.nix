{ lib, host, ... }:

{
  networking = {
    hostName = "${host}";

    nftables.enable = true;
    networkmanager.enable = lib.mkDefault true;

    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
    };
  };
}
