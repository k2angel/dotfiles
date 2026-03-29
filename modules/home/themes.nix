{ pkgs, ... }:

{
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
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };
}
