{ config, pkgs, ... }:

{
  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-termfilechooser
    ];

    config = {
      common = {
        default = [ "gtk" ];
      };

      sway = {
        default = [
          "wlr"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };
  };

  systemd.user.settings = {
    Manager.ManagerEnvironment = {
      # https://discourse.nixos.org/t/configuring-xdg-desktop-portal-with-home-manager-on-ubuntu-hyprland-via-nixgl/65287/6
      XDG_DATA_DIRS = "/usr/local/share:/usr/share:${config.home.profileDirectory}/share:/nix/var/nix/profiles/default/share";
    };
  };

  home.packages = [
    pkgs.xdg-utils
  ];
}
