{ pkgs, ... }:

{
  wmenu-powermenu = pkgs.writeShellScriptBin "wmenu-powermenu" ''
    options="Lock\nLogout\nReboot\nShutdown\nSuspend"
    chosen=$(echo -e "$options" | ${pkgs.wmenu}/bin/wmenu -p "System" -l 5)
    case "$chosen" in
    *Lock) ${pkgs.swaylock}/bin/swaylock -f -c 000000 ;;
    *Logout) ${pkgs.uwsm}/bin/uwsm stop ;;
    *Reboot) ${pkgs.systemd}/bin/systemctl reboot ;;
    *Shutdown) ${pkgs.systemd}/bin/systemctl poweroff ;;
    *Suspend) ${pkgs.swaylock}/bin/swaylock -f -c 000000 && ${pkgs.systemd}/bin/systemctl suspend ;;
    *) exit 1 ;;
    esac
  '';

  bemenu-cliphist = pkgs.writeScriptBin "bemenu-cliphist" ''
    export BEMENU_BACKEND=curses
    result=$(${pkgs.cliphist}/bin/cliphist list | ${pkgs.bemenu}/bin/bemenu -p cliphist)
    if [ -n "$result" ]; then
      echo "$result" | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send "Copied to clipboard!"
    fi
  '';
}
