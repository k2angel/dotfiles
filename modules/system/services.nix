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

    pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
