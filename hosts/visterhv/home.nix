{ inputs, lib, self, pkgs, username, host, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs self username host; };
    users.${username} = {
      imports = [ ../../modules/home ];

      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "25.11";
      };

      wayland.windowManager.sway = {
        config = {
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

        extraConfig = let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in ''
          bindsym ${modifier}+g output DP-2 enable; output HDMI-A-1 disable
          bindsym ${modifier}+Shift+g output DP-2 disable; output HDMI-A-1 enable
        '';
      };

      programs = {
        beets.settings.directory = lib.mkForce "/mnt/pirate/Music/Library";
      };
    };
  };
}
