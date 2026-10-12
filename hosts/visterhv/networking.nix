{
  self,
  config,
  lib,
  username,
  ...
}:

{
  imports = [ (self + /modules/features/lmsd.nix) ];

  networking = {
    useDHCP = false;
    networkmanager.enable = false;
    wireless.iwd.enable = true;

    firewall.extraInputRules = ''
      ether saddr 94:45:60:13:b6:aa tcp dport { 5082, 8096 } accept
      tcp dport { 5082, 8096 } drop
    '';

    wg-quick.interfaces.wg0 = {
      autostart = false;
      configFile = "/etc/wireguard/wg-US-FREE-15.conf";
    };
  };

  systemd.network = {
    enable = true;

    networks."25-wireless" = {
      name = "wlan0";
      address = [ "192.168.3.171/24" ];
      gateway = [ "192.168.3.1" ];
      networkConfig.DHCP = false;
    };
  };

  services = {
    jellyfin = {
      enable = true;
      user = username;
    };

    lmsd = {
      enable = true;
      library = "/mnt/pirate/Music/Library";
    };
  };

  systemd.services = {
    lmsd.serviceConfig.BindReadOnlyPaths = [ "${config.services.lmsd.library}:/music" ];

    jellyfin = {
      wantedBy = lib.mkForce [ ];
      serviceConfig.BindPaths = [ "/mnt/pirate/jellyfin:/media" ];
    };
  };
}
