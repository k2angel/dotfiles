{
  services = {
    playerctld.enable = true;
    polkit-gnome.enable = true;
    udiskie.enable = true;

    cliphist = {
      enable = true;

      extraOptions = [
        "-max-items"
        "10000"
      ];
    };

    mako = {
      enable = true;

      settings = {
        default-timeout = 5000;
      };
    };
  };
}
