{
  lib,
  pkgs,
  username,
  ...
}:

{
  features.wireless.enable = true;

  networking = {
    useDHCP = false;

    firewall = {
      allowedUDPPorts = [ 5353 ];
      trustedInterfaces = [ "ve-+" ];

      extraInputRules =
        let
          tcp = "{ 5082, 8096, 8920 }";
          udp = "{ 1900, 7359 }";
        in
        ''
          ether saddr 94:45:60:13:b6:aa tcp dport ${tcp} accept
          ether saddr 94:45:60:13:b6:aa udp dport ${udp} accept
          tcp dport ${tcp} drop
          udp dport ${udp} drop
        '';
    };

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
    };

    wg-quick.interfaces.wg0 = {
      autostart = false;
      configFile = "/etc/wireguard/wg-US-FREE-15.conf";
    };
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

  containers = {
    lms = {
      autoStart = true;
      privateNetwork = true;
      hostAddress = "192.168.100.20";
      localAddress = "192.168.100.21";
      forwardPorts = [ { hostPort = 5082; } ];

      bindMounts = {
        "/music" = {
          hostPath = "/mnt/pirate/Music/Library";
        };

        "/var/lib/lms" = {
          hostPath = "/var/lib/lms";
          isReadOnly = false;
        };
      };

      config =
        { config, lib, ... }:
        {
          imports = [ ../../modules/features/system/lms.nix ];

          services = {
            resolved.enable = true;

            lms = {
              enable = true;
              library = "/music";
              openFirewall = true;
            };
          };

          networking.useHostResolvConf = lib.mkForce false;
          system.stateVersion = config.system.nixos.release;
        };
    };

    nix-serve = {
      autoStart = true;
      privateNetwork = true;
      hostAddress = "192.168.100.30";
      localAddress = "192.168.100.31";
      forwardPorts = [ { hostPort = 5000; } ];

      bindMounts = {
        "/etc/nix-serve" = {
          hostPath = "/etc/nix-serve";
        };
      };

      config =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          services = {
            resolved.enable = true;

            nix-serve = {
              enable = true;
              package = pkgs.nix-serve-ng;
              secretKeyFile = "/etc/nix-serve/nix-cache-priv-key";
              openFirewall = true;
            };
          };

          networking.useHostResolvConf = lib.mkForce false;
          system.stateVersion = config.system.nixos.release;
        };
    };
  };

  services = {
    jellyfin = {
      enable = true;
      user = username;
    };
  };

  systemd.services = {
    jellyfin = {
      wantedBy = lib.mkForce [ ];
    };
  };
}
