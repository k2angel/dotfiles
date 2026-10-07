{ pkgs, ... }:

{
  xdg = {
    enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "application/pdf" = "firefox.desktop";
        "application/vnd.microsoft.portable-executable" = "wine.desktop";
        "video/*" = "mpv.desktop";
        "x-scheme-handler/discord" = "vesktop.desktop";
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = false;
    };
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME
    env=TERMCMD=${pkgs.foot}/bin/foot -a termfilechooser
    env=PATH="$PATH:${pkgs.gnused}/bin:${pkgs.yazi}/bin"
    open_mode=suggested
    save_mode=last
  '';
}
