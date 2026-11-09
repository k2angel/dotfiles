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

  scheme = config.stylix.base16Scheme;
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
    fzf.enable = true;
    gtk.enable = true;
    lazygit.enable = true;
    qt.enable = true;
    tmux.enable = true;

    mako = {
      enable = true;

      fonts.override = {
        sansSerif.name = "monospace";
      };
    };
  };

  systemd.user.sessionVariables = {
    WMENU_OPTS = lib.cli.toCommandLineShell (optionName: {
      option = "-${optionName}";
      sep = null;
      explicitBool = false;
    }) wmenu_settings;
  };
}
