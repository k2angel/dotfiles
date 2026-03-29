{ ... }:

{
  networking = {
    hostName = "nixos-vm";
    nftables.enable = true;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
  };
}
