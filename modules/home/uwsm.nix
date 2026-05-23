{ ... }:

{
  xdg.configFile."uwsm/env".text = ''
    export LANG=ja_JP.UTF-8
    export EDITOR=nvim
    export VISUAL=nvim
    export GTK_USE_PORTAL=1
  '';
}
