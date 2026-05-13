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
      output."*".bg = "${../../image/large_ev50.png} fill";

      colors = with config.colorScheme.palette; {
        background = "#${base07}";
      gaps = {
        inner = 4;
        outer = 2;
      };

        focused = {
          border = "#${base05}";
          background = "#${base0D}";
          text = "#${base00}";
          indicator = "#${base0D}";
          childBorder = "#${base0D}";
        };

        focusedInactive = {
          border = "#${base01}";
          background = "#${base01}";
          text = "#${base05}";
          indicator = "#${base03}";
          childBorder = "#${base01}";
        };

        placeholder = {
          border = "#${base00}";
          background = "#${base00}";
          text = "#${base05}";
          indicator = "#${base00}";
          childBorder = "#${base00}";
        };

        unfocused = {
          border = "#${base01}";
          background = "#${base00}";
          text = "#${base05}";
          indicator = "#${base01}";
          childBorder = "#${base01}";
        };

        urgent = {
          border = "#${base08}";
          background = "#${base08}";
          text = "#${base00}";
          indicator = "#${base08}";
          childBorder = "#${base08}";
        };
      fonts = {
        names = [
          "JetBrains Mono NL"
          "UDEV Gothic 35"
        ];
        style = "Regular";
        size = 11.0;
      };

      startup = [
        { command = "swaymsg workspace number 1"; }
      ];

      input = {
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "25";
          xkb_layout = "jp";
          xkb_options = "ctrl:nocaps";
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
          statusCommand = "${pkgs.i3blocks}/bin/i3status-rs config-default.toml";

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
