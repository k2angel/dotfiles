{
  lib,
  config,
  pkgs,
  ...
}:

let
  jq = lib.getExe pkgs.jq;
  notify-send = lib.getExe pkgs.libnotify;

  recording-proc = pkgs.writeShellScriptBin "recording-proc" ''
    DEFAULT_AUDIO="@DEFAULT_SINK@"
    XONAR_AUDIO="alsa_output.usb-ASUSTeK_XONAR_SOUND_CARD-00.analog-stereo"
    OUTPUT="${config.xdg.userDirs.videos}/$(${pkgs.coreutils}/bin/date +%Y-%m-%d_%H-%M-%S).mkv"

    if ${pkgs.procps}/bin/pgrep -x wf-recorder >/dev/null; then
        ${pkgs.procps}/bin/pkill -INT -x wf-recorder
        ${notify-send} --app-name wf-recorder "Recording stopped"
        exit 0
    fi

    focused_json=$(swaymsg -t get_tree | jq '.. | objects | select(.focused? == true)')
    app_id=$(${jq} -r '.app_id // empty' <<<"$focused_json")
    class=$(${jq} -r '.window_properties.class // empty' <<<"$focused_json")
    audio="$DEFAULT_AUDIO"

    if [[ "$app_id" == "LR2oraja Endless Dream 0.4.0" ]] || [[ "$class" == "LR2oraja Endless Dream 0.4.0" ]]; then
        audio="$XONAR_AUDIO"
    fi

    ${notify-send} \
        --app-name wf-recorder \
        "Recording started" \
        "$(basename "$OUTPUT")"

    wf-recorder \
        --audio="$audio.monitor" -P b=320k \
        -c av1_nvenc -r 60 -x nv12 -p cq=34 \
        -p color_primaries=bt709 -p color_trc=bt709 -p colorspace=bt709 -p color_range=tv \
        -f "$OUTPUT"
  '';
in
{
  services.mako.settings."app-name=wf-recorder".layer = "overlay";

  wayland.windowManager.sway = {
    config = {
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+g" = "output DP-2 enable; output HDMI-A-1 disable";
          "${modifier}+Shift+g" = "output DP-2 disable; output HDMI-A-1 enable";
          "Ctrl+Print" = "exec ${lib.getExe recording-proc}";
        };

      output = {
        "HDMI-A-1" = {
          enable = "";
          res = "1920x1080";
          pos = "0 0";
        };

        "DP-2" = {
          disable = "";
          res = "1920x1080@119.993Hz";
          pos = "1920 0";
        };
      };
    };
  };
}
