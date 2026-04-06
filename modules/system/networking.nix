{ host, ... }:

{
  networking = {
    hostName = "${host}";

    nftables.enable = true;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
      trustedInterfaces = [ "tailscale0" ];
    };
  };
}
