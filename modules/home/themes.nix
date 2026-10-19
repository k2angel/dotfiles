{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

let
  wmenu_settings = with config.scheme.withHashtag; {
    f = "monospace 11";
    N = base00;
    n = base05;
    M = base0D;
    m = base00;
    S = base0D;
    s = base00;
  };
in
{
  imports = [ inputs.base16.homeManagerModule ];

  scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";

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

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  systemd.user.sessionVariables = {
    WMENU_OPTS = lib.cli.toCommandLineShell (optionName: {
      option = "-${optionName}";
      sep = null;
      explicitBool = false;
    }) wmenu_settings;
  };
}
