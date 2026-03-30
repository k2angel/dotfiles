# List services that you want to enable:
{ pkgs, ... }:

{
  services = {
    openssh.enable = true;

    greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --remember --time --cmd \"sway --unsupported-gpu\"";
          user = "greeter";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable= true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
