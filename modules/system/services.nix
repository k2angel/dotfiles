# List services that you want to enable:
{ pkgs, ... }:

{
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable greetd.
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --time --cmd sway";
        user = "greeter";
      };
    };
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable= true;
    jack.enable = true;
    # pulse.enable = true;
  };
}
