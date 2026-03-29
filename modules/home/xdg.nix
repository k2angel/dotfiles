{ pkgs, username, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = false;
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME
    env=TERMCMD='foot -T "terminal filechooser" -a "termfilechooser"'
    env=PATH="$PATH:/run/current-system/sw/bin"
    open_mode=suggested
    save_mode=last
  '';
}
