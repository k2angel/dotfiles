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
    systemd.enable = false;

    config = rec {
      defaultWorkspace = "workspace number 1";
      menu = "uwsm app -- $(${pkgs.dmenu}/bin/dmenu_path | ${pkgs.wmenu}/bin/wmenu)";
      modifier = "Mod4";
      startup = [ { command = "uwsm finalize"; } ];
      terminal = "${pkgs.foot}/bin/footclient";
      fonts.size = 11.0;
      output."*".bg = "${../../image/large_ev50.png} fill";

      assigns = {
        "workspace number 2" = [ { app_id = "firefox"; } ];
        "workspace number 3" = [ { app_id = "vesktop"; } ];
      };

      colors = with config.colorScheme.palette; {
        background = "#${base07}";

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
      };

      gaps = {
        inner = 4;
        outer = 2;
      };

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
          exec ${terminal} \
            -o "main.pad=0x0" \
            -o "colors-${config.colorScheme.variant}.alpha=1" \
            -a "bemenu_cliphist" \
            ${myScripts.bemenu-cliphist}/bin/bemenu-cliphist
        '';
        "Print" =
          "exec ${pkgs.grim}/bin/grim - | ${pkgs.moreutils}/bin/ifne ${myScripts.screenshot-proc}/bin/screenshot-proc";
        "Alt+v" =
          "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save active - | ${pkgs.moreutils}/bin/ifne ${myScripts.screenshot-proc}/bin/screenshot-proc";
        "Alt+Ctrl+c" =
          "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save area - | ${pkgs.moreutils}/bin/ifne ${myScripts.screenshot-proc}/bin/screenshot-proc";
        "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
        "--locked XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_SOURCE@ toggle";
        "--locked XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%-";
        "--locked XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%+";
        "--locked XF86AudioPlay" = "exec playerctl play-pause";
        "--locked XF86AudioPause" = "exec playerctl play-pause";
        "--locked XF86AudioPrev" = "exec playerctl previous";
        "--locked XF86AudioNext" = "exec playerctl next";
        "--locked XF86AudioStop" = "exec playerctl stop";
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
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs config-default.toml";
          trayOutput = "none";
          trayPadding = 0;
          fonts.size = 11.0;
          extraConfig = "height 22";

          colors = with config.colorScheme.palette; {
            background = "#${base00}";
            separator = "#${base01}";
            statusline = "#${base04}";

            activeWorkspace = {
              background = "#${base03}";
              border = "#${base03}";
              text = "#${base00}";
            };

            bindingMode = {
              background = "#${base0A}";
              border = "#${base0A}";
              text = "#${base00}";
            };

            focusedWorkspace = {
              background = "#${base0D}";
              border = "#${base0D}";
              text = "#${base00}";
            };

            inactiveWorkspace = {
              background = "#${base00}";
              border = "#${base00}";
              text = "#${base05}";
            };

            urgentWorkspace = {
              background = "#${base08}";
              border = "#${base08}";
              text = "#${base00}";
            };
          };
        }
      ];
    };
  };
}
