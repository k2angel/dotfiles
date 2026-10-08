{ ... }:

{
  networking = {
    useDHCP = false;
    networkmanager.enable = false;
    wireless.iwd.enable = true;

    firewall.extraInputRules = ''
      ether saddr 94:45:60:13:b6:aa tcp dport { 5082, 8096 } accept
      tcp dport { 5082, 8096 } drop
    '';
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
    blocky.settings.connectIPVersion = "v4";
    };
  };
}
