{
  lib,
  config,
  pkgs,
  ...
}:

let
  cliphist = lib.getExe pkgs.cliphist;
  notify-send = lib.getExe pkgs.libnotify;
  wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
  wmenu = lib.getExe' pkgs.wmenu "wmenu";
in
{
  bemenu-cliphist = pkgs.writeShellScriptBin "bemenu-cliphist" ''
    export BEMENU_BACKEND=curses
    result=$(${cliphist} list | ${lib.getExe pkgs.bemenu} -p cliphist)

    if [ -n "$result" ]; then
      echo "$result" | ${cliphist} decode | ${wl-copy} && ${notify-send} "Copied to clipboard!"
    fi
  '';

  screenshot-proc = pkgs.writeShellScriptBin "screenshot-proc" ''
    screenshot_dir=${config.xdg.userDirs.pictures}/Screenshots
    screenshot_name=Screenshot_$(${pkgs.coreutils}/bin/date +"%Y%m%d-%H%M%S").png
    screenshot_out="$screenshot_dir/$screenshot_name"

    if ${pkgs.coreutils}/bin/cat | ${pkgs.coreutils}/bin/tee "$screenshot_out" | ${wl-copy}; then
      ${notify-send} "Screenshot saved" \
        "$screenshot_name and copied." \
        -i $screenshot_out \
        -a "GrimProcessor"
    else
      ${notify-send} "Processing Error" \
        "Failed to save or copy image data." \
        -u critical
        exit 1
    fi
  '';

  wmenu-powermenu = pkgs.writeShellScriptBin "wmenu-powermenu" ''
    exec 9>/tmp/wmenu-powermenu.lock
    if ! ${pkgs.util-linux}/bin/flock -n 9; then
      exit 1
    fi

    options="Lock\nLogout\nReboot\nShutdown\nSuspend"
    chosen=$(echo -e "$options" | ${wmenu} -i -p "System" -l 5)

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
