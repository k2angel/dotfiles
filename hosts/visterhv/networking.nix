{ ... }:

{
  networking = {
    useDHCP = false;
    networkmanager.enable = false;
    wireless.iwd.enable = true;
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

    firewalld.zones = {
      home = {
        forward = true;

        sources = [
          { address = "94:45:60:13:b6:aa"; }
          { address = "58:00:e3:f2:19:21"; }
        ];

        services = [
          "dhcpv6-client"
          "kdeconnect"
          "ssh"
          "steam-streaming"
        ];

        ports = [
          {
            port = 5000;
            protocol = "tcp";
          }
          {
            port = 5082;
            protocol = "tcp";
          }
          {
            port = 8096;
            protocol = "tcp";
          }
        ];
      };
    };
  };
}
