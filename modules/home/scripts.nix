{ pkgs, ... }:

{
  bemenu-cliphist = pkgs.writeScriptBin "bemenu-cliphist" ''
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
    exec 9>/tmp/wmenu-powermenu.lock
    flock -n 9
    if [ $? -ne 0 ]; then
      exit 1
    fi

    options="Lock\nLogout\nReboot\nShutdown\nSuspend"
    chosen=$(echo -e "$options" | ${pkgs.wmenu}/bin/wmenu -i -p "System" -l 5)

    case "$chosen" in
      Lock) swaylock -f ;;
      Logout) uwsm stop ;;
      Reboot) systemctl reboot ;;
      Shutdown) systemctl poweroff ;;
      Suspend) swaylock -f && systemctl suspend ;;
      *) exit 1 ;;
    esac
  '';
}
