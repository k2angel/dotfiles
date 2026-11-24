{ config, pkgs, ... }:

{
  gtk.colorScheme = config.stylix.polarity;

  home.pointerCursor = {
    enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
    gtk.enable = true;
    sway.enable = true;
    x11.enable = true;
  };

  stylix.targets = {
    bat.enable = true;
    bemenu.enable = true;
    btop.enable = true;
    foot.enable = true;
    gtk.enable = true;
    lazygit.enable = true;
    qt.enable = true;

    mako = {
      enable = true;

      fonts.override = {
        sansSerif.name = "monospace";
      };
    };
  };
}
