{ host, ... }:

{
  networking = {
    hostName = "${host}";

    nftables.enable = true;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
    };
  };
}
