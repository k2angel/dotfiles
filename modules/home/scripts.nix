{ pkgs, ... }:

{
  wmenu-powermenu = pkgs.writeShellScriptBin "wmenu-powermenu" ''
    options="Lock\nLogout\nReboot\nShutdown\nSuspend"
    chosen=$(echo -e "$options" | ${pkgs.wmenu}/bin/wmenu "JetBrains Mono Regular 11" -N "#282c34" -n "#abb2bf" -M "#61afef" -m "#1e2127" -S "#61afef" -s "#1e2127" -p "System" -l 5)
    case "$chosen" in
    *Lock) ${pkgs.swaylock}/bin/swaylock -f -c 000000 ;;
    *Logout) ${pkgs.sway}/bin/swaymsg exit ;;
    *Reboot) ${pkgs.systemd}/bin/systemctl reboot ;;
    *Shutdown) ${pkgs.systemd}/bin/systemctl poweroff ;;
    *Suspend) ${pkgs.swaylock}/bin/swaylock -f -c 000000 && ${pkgs.systemd}/bin/systemctl suspend ;;
    *) exit 1 ;;
    esac
  '';
}
