{ ... }:

{
  xdg.configFile."uwsm/env".text = ''
    export LANG=ja_JP.UTF-8
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
    export GTK_USE_PORTAL=1
  '';
}
