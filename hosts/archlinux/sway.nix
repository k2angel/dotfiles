{ lib, config, ... }:

{
  wayland.windowManager.sway = {
    config = {
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+g" = "output DP-2 enable; output HDMI-A-1 disable";
          "${modifier}+Shift+g" = "output DP-2 disable; output HDMI-A-1 enable";
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
