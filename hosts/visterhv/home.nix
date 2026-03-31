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

      programs = {
        sway.output = {
          "HDMI-A-1" = "enable resolution 1920x1080 position 0,0";
          "DP-2" = "disable resolution 1920x1080@119.993Hz position 1920,0";
        };
      };
    };
  };
}
