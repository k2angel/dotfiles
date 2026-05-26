# List services that you want to enable:
{ pkgs, ... }:

{
  services = {
    udisks2.enable = true;

    greetd = {
      enable = true;
      useTextGreeter = true;

      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-user-session --time";
          user = "greeter";
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

    pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    resolved = {
      enable = true;

      settings.Resolve = {
        DNSOverTLS = true;
        DNSSEC = true;
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
