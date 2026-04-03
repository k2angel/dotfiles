{ config, pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    extraSessionCommands = ''
      export LANG=ja_JP.UTF-8
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export GTK_USE_PORTAL=1
    '';
    wrapperFeatures.gtk = true;

    systemd = {
      variables = [ "--all" ];
      xdgAutostart = true;
    };

    config = rec {
      modifier = "Mod4";
      terminal = "${pkgs.foot}/bin/footclient";
      menu = ''
        ${pkgs.wmenu}/bin/wmenu-run -f "JetBrains Mono NL Regular 11" -N "#282c34" -n "#abb2bf" -M "#61afef" -m "#1e2127" -S "#61afef" -s "#1e2127"
      '';
      gaps = { inner = 4; outer = 2; };
      output."*".bg = "${../../image/large_ev50.png} fill";

      fonts = {
        names = [ "JetBrains Mono NL" "UDEV Gothic 35" ];
        style = "Regular";
        size = 11.0;
      };

      colors.focused = {
        border = "#61afef";
        background = "#61afef";
        text = "#1e2127";
        indicator = "#2e9ef4";
        childBorder = "#61afef";
      };

      startup = [
        { command = "swaymsg workspace number 1"; }
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

      keybindings = lib.mkOptionDefault {
        "${modifier}+Shift+q" = null;
        "${modifier}+q" = "kill";
        "${modifier}+e" = "exec ${terminal} ${pkgs.yazi}/bin/yazi";
      };

      window = {
        titlebar = false;

        commands = [
          {
            criteria.app_id = "termfilechooser";
            command = builtins.concatStringsSep ", " [
              "floating enable"
              "sticky enable"
              "border pixel none"
              "resize set 77ppt 77ppt"
              "move position center"
            ];
          }
          {
            criteria.app_id = "bemenu_cliphist";
            command = builtins.concatStringsSep ", " [
              "floating enable"
              "sticky enable"
              "border pixel none"
              "resize set 800px 600px"
              "move position center"
              # "resize set 100ppt 100px"
              # "move window to position 0 100ppt"
              # "move up 100px"
            ];
          }
          {
            criteria = {
              app_id = "firefox";
              title = "^ピクチャーインピクチャー$";
            };
            command = builtins.concatStringsSep ", " [
              "floating enable"
              "sticky enable"
              "border none"
            ];
          }
        ];
      };

      bars = [{
        position = "top";
        statusCommand = "${pkgs.i3status}/bin/i3status";

        fonts = {
          names = [ "JetBrains Mono NL" "UDEV Gothic 35" ];
          style = "Regular";
          size = 11.0;
        };
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
}
