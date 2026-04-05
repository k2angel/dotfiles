{ inputs, pkgs, ... }:

let
  nix-colors = inputs.nix-colors;
in {
  imports = [ inputs.nix-colors.homeManagerModules.default ];

  colorScheme = nix-colors.colorSchemes.onedark;

  home.pointerCursor = {
    enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
    gtk.enable = true;
    sway.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk4.theme = null;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };
}
