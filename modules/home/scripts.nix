{ pkgs, ... }:

{
  wmenu-powermenu = pkgs.writeShellScriptBin "wmenu-powermenu" ''
    options="Lock\nLogout\nReboot\nShutdown\nSuspend"
    chosen=$(echo -e "$options" | ${pkgs.wmenu}/bin/wmenu -p "System" -l 5)
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
