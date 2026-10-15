{
  config,
  lib,
  host,
  ...
}:

{
  networking = {
    hostName = host;
    useNetworkd = lib.mkDefault true;
    nftables.enable = true;
    stevenblack.enable = true;
    firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
  };

  services = {
    resolved.enable = true;

    openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    tailscale = {
      enable = true;
      openFirewall = true;
    };
  };

  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];
}
