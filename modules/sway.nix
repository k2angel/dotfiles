{ config, pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "footclient";
      # menu = 'wmenu-run "JetBrains Mono NL Regular 11" -N "#282c34" -n "#abb2bf" -M "#61afef" -m "#1e2127" -S "#61afef" -s "#1e2127"';
      menu = "wmenu-run";
      fonts = {
        names = [ "JetBrains Mono NL" "UDEV Gothic 35" ];
        style = "Regular";
        size = 11.0;
      };
      window = {
        titlebar = false;
      };
      gaps = {
        inner = 4;
        outer = 2;
      };
      colors.focused = {
        border = "#61afef";
        background = "#61afef";
        text = "#1e2127";
        indicator = "#2e9ef4";
        childBorder = "#61afef";
      };
      startup = [
        { command = "autotiling -l 2"; }
        { command = "swaymsg workspace number 1"; }
        { command = "footclient"; }
      ];
      input = {
        "type:keyboard" = {
          xkb_layout = "jp";
        };
        "type:pointer" = {
          pointer_accel = "-0.05";
          accel_profile = "\"flat\"";
        };
      };
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "Mod4+Shift+q" = null;
        "Mod4+q" = "kill";
      };
      bars = [{
        fonts = {
          names = [ "JetBrains Mono NL" "UDEV Gothic 35" ];
          style = "Regular";
          size = 11.0;
        };
        position = "top";
        statusCommand = "${pkgs.i3status}/bin/i3status";
        extraConfig = ''
          height 22
          separator_symbol "｜"
        '';
        colors = {
          background = "#282c34";
          focusedWorkspace = { background = "#61afef"; border = "#61afef"; text = "#1e2127"; };
          inactiveWorkspace = { background = "#282c34"; border = "#282c34"; text = "#abb2bf"; };
          urgentWorkspace = { background = "#e06c75"; border = "#e06c75"; text = "#1e2127"; };
        };
      }];
    };
  };

  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      lock = "lock";
    };
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f -c 000000"; }
    ];
  };
}
