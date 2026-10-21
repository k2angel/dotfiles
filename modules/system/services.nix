{
  services = {
    greetd.enable = true;
    udisks2.enable = true;

    kmscon = {
      enable = true;
      useXkbConfig = true;

      config = {
        font-engine = "pango";
        font-size = 14;
        font-name = "monospace";
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

    xserver.xkb = {
      layout = "jp";
      model = "jp106";
      options = "ctrl:nocaps";
    };
  };
}
