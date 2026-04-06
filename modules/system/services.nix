# List services that you want to enable:
{ pkgs, ... }:

{
  services = {
    dbus.implementation = "broker";
    openssh.enable = true;

    greetd = {
      enable = true;
      useTextGreeter = true;

      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --remember --time --cmd '${pkgs.uwsm}/bin/uwsm start sway-uwsm.desktop'";
          user = "greeter";
        };
      };
    };

    pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      wireplumber.enable = true;
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
