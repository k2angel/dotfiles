{ ... }:

{
  networking = {
    hostName = "nixos-vm"; # Define your hostname.
    nftables = true;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
  };
}
