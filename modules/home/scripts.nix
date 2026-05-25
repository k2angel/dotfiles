{ pkgs, ... }:

{
  bemenu-cliphist = pkgs.writeScriptBin "bemenu-cliphist" ''
    LOCKFILE="/tmp/bemenu-cliphist.lock"
    exec 9>"$LOCKFILE"
    if ! flock -n 9; then
      echo "Script is already running." >&2
        exit 1
        fi

    export BEMENU_BACKEND=curses
    result=$(${pkgs.cliphist}/bin/cliphist list | ${pkgs.bemenu}/bin/bemenu -p cliphist)

    if [ -n "$result" ]; then
      echo "$result" | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send "Copied to clipboard!"
    fi
  '';

  screenshot-proc = pkgs.writeShellScriptBin "screenshot-proc" ''
    screenshot_dir=$(${pkgs.xdg-user-dirs}/bin/xdg-user-dir PICTURES)/Screenshots
    screenshot_name=Screenshot_$(${pkgs.coreutils}/bin/date +"%Y%m%d-%H%M%S").png
    screenshot_out="$screenshot_dir/$screenshot_name"

    if ${pkgs.coreutils}/bin/cat | ${pkgs.coreutils}/bin/tee "$screenshot_out" | ${pkgs.wl-clipboard}/bin/wl-copy; then
      ${pkgs.libnotify}/bin/notify-send "Screenshot saved" \
        "$screenshot_name and copied." \
        -i $screenshot_out \
        -a "GrimProcessor"
    else
      ${pkgs.libnotify}/bin/notify-send "Processing Error" \
        "Failed to save or copy image data." \
        -u critical
        exit 1
    fi
  '';

  wmenu-powermenu = pkgs.writeShellScriptBin "wmenu-powermenu" ''
    LOCKFILE="/tmp/wmenu-powermenu.lock"
    exec 9>"$LOCKFILE"
    if ! flock -n 9; then
      echo "Script is already running." >&2
        exit 1
        fi

    options="Lock\nLogout\nReboot\nShutdown\nSuspend"
    chosen=$(echo -e "$options" | ${pkgs.wmenu}/bin/wmenu -p "System" -l 5)

    case "$chosen" in
    *Lock) swaylock -f ;;
    *Logout) ${pkgs.uwsm}/bin/uwsm stop ;;
    *Reboot) ${pkgs.systemd}/bin/systemctl reboot ;;
    *Shutdown) ${pkgs.systemd}/bin/systemctl poweroff ;;
    *Suspend) swaylock -f && ${pkgs.systemd}/bin/systemctl suspend ;;
    *) exit 1 ;;
    esac
  '';
}
