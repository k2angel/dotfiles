{
  config,
  pkgs,
  lib,
  ...
}:

let
  myScripts = import ./scripts.nix { inherit pkgs; };
in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemd.dbusImplementation = "broker";

    config = rec {
      modifier = "Mod4";
      terminal = "${pkgs.foot}/bin/footclient";
      menu = "${pkgs.wmenu}/bin/wmenu-run";
      gaps = {
        inner = 4;
        outer = 2;
      };
      output."*".bg = "${../../image/large_ev50.png} fill";

      fonts = {
        names = [
          "JetBrains Mono NL"
          "UDEV Gothic 35"
        ];
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
          repeat_delay = 200;
          repeat_rate = 25;
          xkb_layout = "jp";
        };

        "type:pointer" = {
          pointer_accel = "-0.05";
          accel_profile = "flat";
        };
      };

      keybindings = lib.mkOptionDefault {
        "${modifier}+Shift+q" = null;
        "${modifier}+q" = "kill";
        "${modifier}+e" = "exec ${terminal} ${pkgs.yazi}/bin/yazi";
        "${modifier}+Shift+e" = "exec ${myScripts.wmenu-powermenu}/bin/wmenu-powermenu";
        "${modifier}+v" = ''
          exec ${pkgs.foot}/bin/foot \
          -o "main.pad=0x0" \
          -o "colors-${config.colorScheme.variant}.alpha=1" \
          -a "bemenu_cliphist" \
          ${myScripts.bemenu-cliphist}/bin/bemenu-cliphist
        '';
      };

      window = {
        titlebar = false;

        commands = [
          {
            criteria.app_id = "termfilechooser";
            command = builtins.concatStringsSep ", " [
              "floating enable"
              "sticky enable"
              "border pixel 1px"
              "resize set 77ppt 77ppt"
              "move position center"
            ];
          }
          {
            criteria.app_id = "bemenu_cliphist";
            command = builtins.concatStringsSep ", " [
              "floating enable"
              "sticky enable"
              "border pixel 1px"
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

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";

          fonts = {
            names = [
              "JetBrains Mono NL"
              "UDEV Gothic 35"
            ];
            style = "Regular";
            size = 11.0;
          };
          extraConfig = ''
            height 22
            separator_symbol "｜"
          '';
          colors = {
            background = "#282c34";
            focusedWorkspace = {
              background = "#61afef";
              border = "#61afef";
              text = "#1e2127";
            };
            inactiveWorkspace = {
              background = "#282c34";
              border = "#282c34";
              text = "#abb2bf";
            };
            urgentWorkspace = {
              background = "#e06c75";
              border = "#e06c75";
              text = "#1e2127";
            };
          };
        }
      ];
    };
  };
}
