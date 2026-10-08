{
  config,
  lib,
  host,
  ...
}:

{
  networking = {
    hostName = host;
    nameservers = [ "127.0.0.1:5354" ];
    nftables.enable = true;
    networkmanager.enable = lib.mkDefault true;
    firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
  };

  services = {
    resolved.enable = true;

    blocky = {
      enable = true;

      settings = {
        log.privacy = true;

        ports = {
          dns = 5354;
          http = [
            4000
          ];
        };

        upstreams.groups.default = [
          "tcp-tls:1.1.1.1:853"
          "tcp-tls:1.0.0.1:853"
          "tcp-tls:8.8.8.8:853"
        ];

        bootstrapDns = [
          { upstream = "1.1.1.1"; }
          { upstream = "1.0.0.1"; }
          { upstream = "8.8.8.8"; }
        ];

        blocking = {
          blockType = "nxDomain";
          clientGroupsBlock.default = [ "ads" ];

          denylists.ads = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardDNS.txt"
            "https://warui.intaa.net/adhosts/hosts_lb.txt"
          ];
        };

        caching = {
          minTime = "60m";
          prefetching = true;
        };
      };
    };

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
